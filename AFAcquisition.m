//
//  AFAcquisition.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import "AFAcquisition.h"

@implementation AFAcquisition

@synthesize acqTime;
@synthesize energyWindows;

- (id) init
{
    if (self = [super init]) {
        energyWindows = [[NSMutableDictionary alloc] init];
        acqTime  = nil;
    }
    
    return self;
}

+ (AFAcquisition*) acquisitionAt:(NSDate *)dateTime
{
    AFAcquisition *acquisition = [[[AFAcquisition alloc] init] autorelease];
    acquisition.acqTime = dateTime;
    
    return acquisition;
}

-(void) dealloc
{
    self.energyWindows = nil;
    self.acqTime = nil;
    
    [super dealloc];
}

- (AFEnergyWindow*) addImage:(AFImage*)image
{
    AFEnergyWindow *energyWindow = image.energyWindow;
    NSMutableArray *orientations = [energyWindows objectForKey:energyWindow];
    if (! orientations) {
        orientations = [[[NSMutableArray alloc] init] autorelease];
        [energyWindows setObject:orientations forKey:energyWindow];
    }
    [orientations addObject:image];
    
    return energyWindow;
}


- (NSUInteger) numEnergyWindows
{
    return [energyWindows count];
}

- (NSArray*) imagesForEnergyWindow:(AFEnergyWindow*) energyWindow
{
    return [energyWindows objectForKey:energyWindow];
}

- (AFImage *) imageForEnergyWindow:(AFEnergyWindow *)energyWindow
                        orientation:(NSUInteger)orientation
{
    return [[energyWindows objectForKey:energyWindow] objectAtIndex:orientation];
}

- (NSString*) description
{
    return energyWindows.description;
}

@end

