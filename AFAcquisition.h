//
//  AFAcquisition.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import <Foundation/Foundation.h>
#import "AFEnergyWindow.h"
#import "AFImage.h"

@interface AFAcquisition : NSObject{
NSDate *acqTime;
NSMutableDictionary *energyWindows;
}

@property (retain) NSDate *acqTime;
@property (retain) NSMutableDictionary *energyWindows;

- (id) init;

+ (AFAcquisition*) acquisitionAt:(NSDate*)dateTime;

- (void) dealloc;

- (AFEnergyWindow*) addImage:(AFImage*)image;

- (NSUInteger) numEnergyWindows;

- (NSArray*) imagesForEnergyWindow:(AFEnergyWindow*) energyWindow;

- (AFImage*) imageForEnergyWindow:(AFEnergyWindow *)energyWindow
                       orientation:(NSUInteger)orientation;

- (NSString*) description;

@end
