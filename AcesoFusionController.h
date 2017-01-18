//
//  AcesoFusionController.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import <Cocoa/Cocoa.h>

#import "AFEnergyWindow.h"
#import "AFAcquisitions.h"

@interface AcesoFusionController : NSWindowController{
    NSImageView         *leftImageView;
    NSImageView         *rightImageView;
    AFAcquisitions      *acquisitions;
}

@property (retain) IBOutlet NSImageView *leftView;
@property (retain) IBOutlet NSImageView *rightView;
@property (retain, nonatomic) AFAcquisitions *acquisitions;


-(void) configureImages;

@end
