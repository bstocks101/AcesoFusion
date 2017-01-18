//
//  AFController.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/18.
//
//

#import "AFController.h"

//@interface AFController ()
//
//@end

@implementation AFController

- (void)windowDidLoad {
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(id) initWithController:(ViewerController*) control{
    NSLog(@"Making AF Controller");
     self = (AFController*)control;
    NSLog(@"%@", [customXSpacing stringValue]);
    NSString* test = [[customXSpacing stringValue] stringByReplacingOccurrencesOfString:@"," withString:@"."];
    NSLog(@"%@", test);
    _myStr = test;
    [customXSpacing setStringValue:test];
    //self.customXSpacingString = [[self valueForKey:@"_customXSpacing"] stringValue];
    NSLog(@"Finished making AF Controller");
    return self;
}


-(void)correctXSpacing{
    [customXSpacing setStringValue:_myStr];
}

@end
