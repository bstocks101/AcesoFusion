//
//  AFOrthogonalMPRController.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/18.
//
//

#import "AFOrthogonalMPRController.h"

@implementation AFOrthogonalMPRController

-(id) initWithController:(OrthogonalMPRController*) controller{
    self = (AFOrthogonalMPRController*)controller;
    [self addObserver:self forKeyPath:@"xReslicedCrossPositionX" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    NSLog(@"AFOrthogonalMPRController created");
    NSLog(@"X position: %f", xReslicedCrossPositionX);
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"xReslicedCrossPositionX"]){
        NSLog(@"Pointer moved X: %@", change);
    }
}

-(float) getCrossX{
    return xReslicedCrossPositionX;
}

@end
