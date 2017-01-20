//
//  AcesoFusionFilter.h
//  AcesoFusion
//
//  Copyright (c) 2016 Roland Baasch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HorosAPI/PluginFilter.h>
#import <HorosAPI/BrowserController.h>
#import <HorosAPI/DicomSeries.h>
#import <HorosAPI/DicomStudy.h>
#import <HorosAPI/DicomImage.h>
#import <HorosDCM/DCMObject.h>
#import <HorosDCM/DCMAttribute.h>
#import <HorosDCM/DCMAttributeTag.h>
#import <HorosDCM/DCMSequenceAttribute.h>
#import <HorosDCM/DCMCalendarDate.h>
#import <HorosAPI/DCMPix.h>
#import <HorosAPI/dicomFile.h>
#import <HorosAPI/OrthogonalMPRController.h>
#import <HorosAPI/OrthogonalMPRViewer.h>

#import "ImageCollection.h"
#import "AFDCMImage.h"
#import "AFWindowController.h"
//#import "OrthogonalReslice.h"
#import "AFCompleteSet.h"
#import "AFSelectionController.h"
#import "AFViewController.h"
#import "AFController.h"
#import "AFOrthogonalMPRController.h"

@interface AcesoFusionFilter : PluginFilter

@property bool executing;
@property int xrCount;
@property int usCount;
@property bool validSelection;
@property (retain) ImageCollection *collection;
@property (retain) NSMutableArray* pix;
@property (retain) NSMutableArray* files;
@property (retain) NSString* selectedTitle;
@property (retain) NSDictionary* availableSets;
@property (retain) BrowserController* currentBrowser;
@property (retain) AFViewController* mprViewer;
@property (retain) ViewerController* viewControl;
@property (retain) NSMutableArray* points;
@property (retain) NSMutableArray* roiSeriesList;
@property (retain) NSMutableArray* roiImageList;
@property (retain) ROI* newROI;
@property double xrOriginX, xrOriginY, usOriginX, usOriginY, xrPixelSpacingX, xrPixelSpacingY, usPixelSpacingX, usPixelSpacingY;


- (long) filterImage:(NSString*) menuName;




-(void) dealloc;



@end
