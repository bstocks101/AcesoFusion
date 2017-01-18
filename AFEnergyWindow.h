//
//  AFEnergyWindow.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import <Foundation/Foundation.h>

@interface AFEnergyWindow : NSObject <NSCopying> {
    float lowerLimit;
    float upperLimit;
}

@property float lowerLimit;
@property float upperLimit;

- (id) initWithLowerLimit:(float)ll upperLimit:(float) ul;

+ (AFEnergyWindow *) energyWindowWithLowerLimit:(float)ll upperLimit:(float)ul;

- (id) copyWithZone:(NSZone *)zone;

- (BOOL) isEqual:(id)object;

- (NSUInteger) hash;

- (NSString *)description;

- (float) center;

@end

static NSComparator compareAFEnergyWindow = ^(id obj1, id obj2) {
    if ((! [obj1 isKindOfClass:[AFEnergyWindow class]]) &&
        (! [obj1 isKindOfClass:[AFEnergyWindow class]])) {
        [NSException raise:@"Comparison on invalid objects"
                    format:@"%@ or %@ are not of class MFPEnergyWindow",
         obj1, obj2];
    }
    
    return (NSComparisonResult)[@([(AFEnergyWindow*)obj1 center])
                                compare:@([(AFEnergyWindow*)obj2 center])];
};
