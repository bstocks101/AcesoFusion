//
//  AFWindowController.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/10.
//
//

#import <Cocoa/Cocoa.h>
#import "AFDCMImage.h"
#import <HorosAPI/DCMPix.h>
#import <HorosAPI/PluginFilter.h>
#import <HorosDCM/DCMAttribute.h>
#import <HorosDCM/DCMAttributeTag.h>
#import <HorosAPI/DicomSeries.h>

@interface AFWindowController : ViewerController

@property (retain) IBOutlet DCMView *leftView;
@property (retain) IBOutlet NSImageView *rightView;
@property (retain) IBOutlet NSTextField *rightDetails;
@property (retain) IBOutlet NSTextField *leftDetails;


- (void) displayLeftImage: (AFDCMImage*) leftImage;
- (void) displayRightImage: (AFDCMImage*) rightImage;

@end
