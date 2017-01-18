//
//  AFController.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/18.
//
//

#import <Foundation/Foundation.h>
#import <HorosAPI/ViewerController.h>

@interface AFController : ViewerController

@property NSString* myStr;

-(id) initWithController:(ViewerController*) control;

-(void)correctXSpacing;


@end
