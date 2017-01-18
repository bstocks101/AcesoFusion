//
//  AFEnergyWindow.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import "AFEnergyWindow.h"

@implementation AFEnergyWindow

@synthesize lowerLimit;
@synthesize upperLimit;


- (id) initWithLowerLimit:(float)ll upperLimit:(float) ul {
    if (self = [super init]) {
        lowerLimit = ll;
        upperLimit = ul;
    }
    
    return self;
}

+ (AFEnergyWindow *) energyWindowWithLowerLimit:(float)ll upperLimit:(float)ul {
    return [[[AFEnergyWindow alloc] initWithLowerLimit:ll upperLimit:ul] autorelease];
}

- (id) copyWithZone:(NSZone *)zone {
    AFEnergyWindow *copiedObject = [[AFEnergyWindow allocWithZone:zone] init];
    copiedObject.lowerLimit = lowerLimit;
    copiedObject.upperLimit = upperLimit;
    
    return copiedObject;
}

- (BOOL) isEqual:(id)object {
    if (! [object isKindOfClass:[AFEnergyWindow class]])
        return NO;
    
    AFEnergyWindow *other = (AFEnergyWindow *) object;
    
    return lowerLimit == other.lowerLimit && upperLimit == other.upperLimit;
}

- (NSUInteger) hash {
    NSUInteger returnValue=0;
    
    returnValue  = @(lowerLimit).hash;
    returnValue ^= @(upperLimit).hash;
    
    return returnValue;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[%f,%f]", lowerLimit, upperLimit];
}

- (float) center
{
    return (upperLimit+lowerLimit)/2.;
}

@end
