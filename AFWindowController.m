//
//  AFWindowController.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/10.
//
//

#import "AFWindowController.h"

@interface AFWindowController ()

@end

@implementation AFWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void) displayLeftImage:(AFDCMImage *)leftImage{
    [leftImage populateDCMPix];
    NSImage* im = [[leftImage getImage] image];
    if(im == nil){
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:@"NSImage is null"];
        [alert runModal];
    }
    [self.leftDetails setStringValue:@"Patient: Person"];
    //    DCMPix *leftDCMPix = [[DCMPix alloc] initWithPath:
//                          [[(DicomImage*)images[0] completePath]
//                           :0 :1 :nil :frameNo :0 isBonjour:false
//                           imageObj:leftSeries]];
//    NSImage *leftDisplayImage = [leftDCMPix image];
//    [_leftView setImage:leftDisplayImage];
//    NSString *patientID = [[leftObject attributeForTag:
//                            [DCMAttributeTag tagWithGroup:0x10 element:0x20]] value];
//    [self.leftDetails setStringValue:patientID];
    
}

-(void) displayRightImage:(AFDCMImage *)rightImage{
    
}

@end
