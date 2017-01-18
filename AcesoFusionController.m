//
//  AcesoFusionController.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import "AcesoFusionController.h"

@interface AcesoFusionController ()

@end

@implementation AcesoFusionController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void) configureImages{
    AFAcquisition  *acquisition = [acquisitions.allAcquisitions
                                    objectAtIndex:0];
    AFEnergyWindow *energy      = [acquisitions.energyWindows objectAtIndex:0];
    
    NSArray         *images      = [acquisition imagesForEnergyWindow:energy];
    
    DCMPix          *leftDCMPix  = [((AFImage*)[images objectAtIndex:0]) image];
    DCMPix          *rightDCMPix = [((AFImage*)[images objectAtIndex:1]) image];
    
    NSImage         *leftImage   = [leftDCMPix image];
    NSImage         *rightImage  = [rightDCMPix image];
    
    [leftImageView setImage:leftImage];
    [rightImageView setImage:rightImage];
}


@end
