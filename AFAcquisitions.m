//
//  AFAcquisitions.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import "AFAcquisitions.h"

@implementation AFAcquisitions

@synthesize acqAtTimePoints;
@synthesize energyWindows;

- (id) init
{
    if (self = [super init]) {
        acqAtTimePoints = [[NSMutableDictionary alloc] init];
        energyWindows   = [[NSMutableOrderedSet alloc] init];
    }
    
    return self;
}

+ (AFAcquisitions*) setOfAcquisitions
{
    return [[[AFAcquisitions alloc] init] autorelease];
}

-(void) dealloc
{
    self.acqAtTimePoints = nil;
    self.energyWindows   = nil;
    
    [super dealloc];
}

- (void) addImage:(DicomImage*)dcmImage
{
    AFImage *image = [AFImage imageFromDicomImage:dcmImage];
    if (! image)
        return;
    
    NSDate *acqTime = image.acqTime;
    
    AFAcquisition *acqAtTimePoint = [acqAtTimePoints objectForKey:acqTime];
    if (! acqAtTimePoint) {
        acqAtTimePoint = [AFAcquisition acquisitionAt:acqTime];
        [acqAtTimePoints setObject:acqAtTimePoint forKey:acqTime];
    }
    
    AFEnergyWindow *energyWindow = [acqAtTimePoint addImage:image];
    if (! [energyWindows containsObject:energyWindow]) {
        [energyWindows addObject:energyWindow];
        [energyWindows sortUsingComparator:compareAFEnergyWindow];
    }
}

- (BOOL) performConsistencyChecks
{
    // Check if all energy windows were acquired at all time points
    // and if the same number of orientations is available for each energy window.
    
    NSUInteger numEnergyWindows = [energyWindows count];
    int numOrientations  = -1;
    
    BOOL returnValue = TRUE;
    
    for (AFAcquisition *acqAtTimePoint in [acqAtTimePoints allValues]) {
        returnValue &= (acqAtTimePoint.numEnergyWindows == numEnergyWindows);
        for (NSMutableArray *orientatations in [[acqAtTimePoint energyWindows] allValues]) {
            if (numOrientations == -1)
                numOrientations = [orientatations count];
            
            returnValue &= [orientatations count] == numOrientations;
        }
    }
    
    return returnValue;
}

- (NSUInteger) numberOfOrientations
{
    AFAcquisition *acqAtTimePoint = [[acqAtTimePoints objectEnumerator] nextObject];
    NSArray *orientations = [[[acqAtTimePoint energyWindows] objectEnumerator] nextObject];
    return [orientations count];
}

- (NSArray*) timePoints
{
    return [[acqAtTimePoints allKeys ] sortedArrayUsingComparator:^(id obj1, id obj2) {return [obj1 compare:obj2]; } ];
}

- (NSArray*) timeDifferences
{
    NSArray *timePoints = [self timePoints];
    NSDate *t0 = [timePoints objectAtIndex:0];
    
    NSMutableArray *dT = [[[NSMutableArray alloc] init] autorelease];
    for (NSDate *t in timePoints)
        [dT addObject:@([t timeIntervalSinceDate:t0])];
    
    return dT;
}

- (NSArray*) allAcquisitions
{
    NSMutableDictionary *notFoundMarker = [[[NSMutableDictionary alloc] init] autorelease];
    return [acqAtTimePoints objectsForKeys:[self timePoints] notFoundMarker:notFoundMarker];
}

- (NSArray*) imagesForEnergyWindow:(AFEnergyWindow*) energyWindow
{
    if (! [energyWindows containsObject:energyWindow])
        return nil;
    
    NSMutableArray *returnValue = [[[NSMutableArray alloc] init] autorelease];
    
    for (AFAcquisition *acquisition in [self allAcquisitions])
        [returnValue addObject:[acquisition imagesForEnergyWindow:energyWindow]];
    
    return returnValue;
}

- (NSArray *) imagesForEnergyWindow:(AFEnergyWindow *)energyWindow
                        orientation:(NSUInteger)orientation
{
    if (orientation >= [self numberOfOrientations])
        return nil;
    
    if (! [energyWindows containsObject:energyWindow])
        return nil;
    
    NSMutableArray *returnValue = [[[NSMutableArray alloc] init] autorelease];
    for (AFAcquisition *acquisition in [self allAcquisitions])
        [returnValue addObject:[acquisition imageForEnergyWindow:energyWindow
                                                     orientation:orientation]];
    
    return returnValue;
}

@end
