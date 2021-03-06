//
//  AFViewController.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/17.
//
//

#import <HorosAPI/OrthogonalMPRViewer.h>

@interface AFViewController : OrthogonalMPRViewer

@property (retain) IBOutlet OrthogonalMPRController* mprController;
@property (retain) IBOutlet DCMView* xrView;
@property bool visible;
 
-(id) initWithPixList:(NSMutableArray *)pixList :(NSArray *)filesList :(NSData *)vData :(ViewerController *)vC :(ViewerController *)bC;

-(void) showOriginalPix;

-(void) showXrImage:(NSMutableArray*) pix : (NSArray*)files;

-(void) dealloc;

-(void) dealloc2;


@end
