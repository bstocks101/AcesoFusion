//
//  AcesoFusionFilter.m
//  AcesoFusion
//
//  Copyright (c) 2016 Roland Baasch. All rights reserved.
//

#import "AcesoFusionFilter.h"

@implementation AcesoFusionFilter


/**
 Called when Horos is started, sets running state to false, allowing for execution
 */
- (void) initPlugin
{
    NSLog(@"AF: Aceso Fusion Plug-in initialised");
    self.executing = false;
   
}


- (void) dealloc
{
    
    [super dealloc];
}

- (long) filterImage:(NSString*) menuName
{
    if (self.executing) {
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:@"Aceso Fusion is executing already!"];
        [alert runModal];
        
        return 1;
    }
    
    self.xrCount = 0;
    self.usCount = 0;
    self.validSelection = false;
    self.collection = [[ImageCollection alloc] init];
    
    NSLog(@"AF: Aceso Fusion Plug-in started");
    self.executing = true;
    
    self.currentBrowser = [BrowserController currentBrowser];
    NSArray *selectedItems = [_currentBrowser databaseSelection];
    NSMutableArray* selectedSeries = [NSMutableArray arrayWithCapacity:0];
    
    if ([selectedItems count] == 0) {
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:@"No studies/series selected!"];
        [alert runModal];
        
        return 1;
    }
    
    self.pix = [NSMutableArray arrayWithCapacity: 0];
    self.files = [NSMutableArray arrayWithCapacity: 0];

    for (id item in selectedItems) {
        if ([item isKindOfClass:[DicomStudy class]]) {
            DicomStudy *study = (DicomStudy*) item;
            
            for (DicomSeries *series in [study imageSeries]){
                [selectedSeries addObject:(DicomSeries*)series];
            }
            
        } else if ([item isKindOfClass:[DicomSeries class]])
            [selectedSeries addObject:(DicomSeries*)item];
    }
    
    NSLog(@"Total series: %lu", (unsigned long)[selectedSeries count]);
  
    self.availableSets = [self findFullSets:selectedSeries];
    
    NSArray* availableOrientations = [self.availableSets allKeys];
    NSLog(@"Number of complete sets: %lu", [availableOrientations count]);
    
    AFSelectionController* selectionController = [[AFSelectionController alloc] initWithWindowNibName:@"AFSelectionController"];
    [selectionController addObserver:self forKeyPath:@"selectedTitle" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [NSApp beginSheet: selectionController.window modalForWindow:[NSApp keyWindow] modalDelegate:self didEndSelector:nil contextInfo:nil];
    [selectionController populateDisplay:availableOrientations];
    

    
    
    self.executing = false;
    return 0;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"selectedTitle"]){
        NSLog(@"Observed the change %@", change);
        self.selectedTitle = change[@"new"];
        NSLog(@"The selected view is %@", self.selectedTitle);
        [self generateView];
    }
    if([keyPath isEqualToString:@"crossPositionX"]){
        NSLog(@"Pointer moved X: %@", change);
    }
    
    
}

-(void) generateView{
    AFCompleteSet* selectedCollection = self.availableSets[self.selectedTitle];
    
    
    [self.currentBrowser.databaseOutline selectRowIndexes: [NSIndexSet indexSetWithIndex: [self.currentBrowser.databaseOutline
                                                                                           rowForItem: selectedCollection.usSeries]] byExtendingSelection: NO];
        [self.currentBrowser databaseOpenStudy:selectedCollection.usSeries];
    
        [self.currentBrowser.databaseOutline selectRowIndexes: [NSIndexSet indexSetWithIndex: [self.currentBrowser.databaseOutline
                                                                                               rowForItem: selectedCollection.xrSeries]] byExtendingSelection: NO];
        [self.currentBrowser databaseOpenStudy:selectedCollection.xrSeries];
    

    NSArray* viewers = [super viewerControllersList];
    ViewerController* vc = viewers[0];
    ViewerController* xrViewer = viewers[1];
    NSButton* button = [[NSButton alloc]init];
    button.tag = 1;
    [vc computeInterval];
    [vc SetThicknessInterval:nil];
    AFController* ac =[[AFController alloc] initWithController:vc];
    [ac endThicknessInterval:button];
    
    _mprViewer = [[AFViewController alloc] initWithPixList:vc.pixList :vc.fileList :vc.volumeData :ac :nil];
    [_mprViewer showWindow:nil];
    [_mprViewer.xrView setPixels:xrViewer.pixList files:xrViewer.fileList rois:nil firstImage:0 level:'i' reset:YES];
    [_mprViewer.xrView setDrawing:YES];
    
    [self addObserver:_mprViewer.controller.xReslicedView forKeyPath:@"crossPositionX" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(printCoords:)
                                   userInfo:nil
                                    repeats:YES];
}

-(void) printCoords:(NSTimer*) t{
    ViewerController* viewControl = [super viewerControllersList][1];
    NSMutableArray* roiSeriesList = [viewControl roiList];
    NSMutableArray* roiImageList = [roiSeriesList objectAtIndex: [[viewControl imageView] curImage]];
    float x =_mprViewer.controller.xReslicedView.crossPositionX;
    NSLog(@"X: %f", x);
    ROI* newROI = [viewControl newROI: tCPolygon];
    NSMutableArray  *points = [newROI points];
    
    [points addObject: [viewControl newPoint: x+100 : 500]];   // Values are in pixels! not in mm!
    [points addObject: [viewControl newPoint: x : 600]];
    [points addObject: [viewControl newPoint: x-100 : 500]];
    [points addObject: [viewControl newPoint: x : 400]];
    
    [newROI setROIMode: ROI_selected];
    
    [roiImageList addObject: newROI];
    
    [viewControl needsDisplayUpdate];
}




//array of DicomSeries
-(NSDictionary*) findFullSets:(NSArray*) selectedItems{
    NSMutableDictionary* fullSets = [[NSMutableDictionary alloc] init];
    NSLog(@"findFullSets called");
    NSMutableArray* imageObjects = [NSMutableArray arrayWithCapacity:0];
    if(selectedItems == nil){
        NSLog(@"Passed object is null");
        return nil;
    }
    NSLog(@"Number of series to process: %lu", [selectedItems count]);

    //make array of image objects to query series types
    for(DicomSeries* series in selectedItems){
        NSLog(@"Series name: %@", [series name]);
        DicomImage* temp = [series sortedImages][0];
        if(!temp){
            NSLog(@"DicomImage is null");
        }
            
        [imageObjects addObject:[DCMObject objectWithContentsOfFile:[temp completePath]
                                                  decodingPixelData:NO]];
    }
    NSLog(@"imageObjects populated");
    NSMutableDictionary* xrClassifications = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* usClassifications = [[NSMutableDictionary alloc] init];
    NSString* type, *modality;
    int i = 0;
    
    //populate 2 dictionaries with orientations as keys and dicomseries as objects
    for(DCMObject* obj in imageObjects){
        modality = [[obj attributeForTag:
                     [DCMAttributeTag tagWithGroup:0x08 element:0x60]] value];
        if([modality isEqualToString:@"US"]){
            NSLog(@"Ultrasound series found");
            NSArray* data =[[obj attributeForTag:
                    [DCMAttributeTag tagWithGroup:0x20 element:0x20]] values];
            type = [NSString stringWithFormat:@"%@%@", data[0], data[1]];
            NSLog(@"Type: %@", type);
            if([type isEqualToString:@"AR"]){
                NSLog(@"Found US-LCC");
                [usClassifications setObject:selectedItems[i] forKey:@"LCC"];
            }
            else if([type isEqualToString:@"PL"]){
                NSLog(@"Found US-RCC");
                [usClassifications setObject:selectedItems[i] forKey:@"RCC"];
            }
            else if([type isEqualToString:@"AFR"]){
                NSLog(@"Found US-LMLO");
                [usClassifications setObject:selectedItems[i] forKey:@"LMLO"];
            }
            else if([type isEqualToString:@"PFL"]){
                NSLog(@"Found US-RMLO");
                [usClassifications setObject:selectedItems[i] forKey:@"RMLO"];
            }
        }
        else if([modality isEqualToString:@"MG"]){
            NSLog(@"X-Ray series found");
            NSArray* data =[[obj attributeForTag:
                    [DCMAttributeTag tagWithGroup:0x20 element:0x20]] values];
            type = [NSString stringWithFormat:@"%@%@", data[0], data[1]];
            NSLog(@"Type: %@", type);
            if([type isEqualToString:@"AR"]){
                NSLog(@"Found XR-LCC");
                [xrClassifications setObject:selectedItems[i] forKey:@"LCC"];
            }
            else if([type isEqualToString:@"PL"]){
                NSLog(@"Found XR-RCC");
                [xrClassifications setObject:selectedItems[i] forKey:@"RCC"];
            }
            else if([type isEqualToString:@"AFR"]){
                NSLog(@"Found XR-LMLO");
                [xrClassifications setObject:selectedItems[i] forKey:@"LMLO"];
            }
            else if([type isEqualToString:@"PFL"]){
                NSLog(@"Found XR-RMLO");
                [xrClassifications setObject:selectedItems[i] forKey:@"RMLO"];
            }
        }
        i++;
    }
    //cycle through keys in us and see if same orientation exists for xr
    for(id key in usClassifications){
        if([xrClassifications objectForKey:key]){
            //create object to hold xr series and us series
            AFCompleteSet* complete = [[AFCompleteSet alloc] initWithXR:xrClassifications[key] andUS:usClassifications[key]];
            //dictionary with orientation as key and object as element
            [fullSets setObject:complete forKey:key];
        }
    }
    return fullSets;
}


@end
