//
//  AFViewController.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/17.
//
//

#import "AFViewController.h"

@interface AFViewController ()

@end

@implementation AFViewController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(id) initWithPixList:(NSMutableArray *)pix :(NSArray *)files :(NSData *)vData :(ViewerController *)vC :(ViewerController *)bC{
    
    self = [super initWithPixList:pix :files :vData :vC :bC];
    //self = [super initWithWindowNibName:@"AFViewController"];
    _visible = YES;
    return self;
}

-(void) showWindow:(id)sender{
    [super showWindow:sender];
    
}

-(void) showOriginalPix{
    [self.mprController.originalView setPixList:self.mprController.originalDCMPixList :self.mprController.originalDCMFilesList];
}

-(void) showXrImage:(NSMutableArray*) pix : (NSArray*)files{
    [self.xrView setPixList:pix :files];
}

-(void) dealloc{
    _visible = NO;
    [super dealloc];
}

@end
