//
//  AFAcquisitions.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import <Foundation/Foundation.h>

#import "AFEnergyWindow.h"
#import "AFImage.h"
#import "AFAcquisition.h"

@interface AFAcquisitions : NSObject {
    NSMutableDictionary *acqAtTimePoints;
    NSMutableOrderedSet *energyWindows;
}

@property (retain) NSMutableDictionary *acqAtTimePoints;
@property (retain) NSMutableOrderedSet *energyWindows;

- (id) init;

+ (AFAcquisitions*) setOfAcquisitions;

- (void) dealloc;

- (void) addImage:(DicomImage*)dcmImage;

- (BOOL) performConsistencyChecks;

- (NSUInteger) numberOfOrientations;

- (NSArray*) timePoints;

- (NSArray *) timeDifferences;

- (NSArray *) allAcquisitions;

- (NSArray *) imagesForEnergyWindow:(AFEnergyWindow*) energyWindow;

- (NSArray *) imagesForEnergyWindow:(AFEnergyWindow *)energyWindow
                        orientation:(NSUInteger)orientation;

@end
