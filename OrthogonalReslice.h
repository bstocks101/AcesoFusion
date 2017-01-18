//
//  OrthogonalReslice.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/12.
//
//

#import <Foundation/Foundation.h>
#import <HorosAPI/PluginFilter.h>

@interface OrthogonalReslice : NSObject

//@property (retain) IBOutlet	NSWindow		*window;
//
//@property (retain) IBOutlet	NSMatrix		*direction;
//
//@property (retain) ViewerController* viewerController;
//
//@property (retain) IBOutlet	NSButton		*squarePixels;
//
//@property (retain) IBOutlet	NSButton		*newWindow;
//
//@property (retain) NSMutableArray* pix;
//
//@property (retain) NSMutableArray* files;


+(void) executeReslice:(ViewerController*) pix :(long) directionm :(BOOL) square :(BOOL) newViewer;

@end
