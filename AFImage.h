//
//  AFImage.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import <Foundation/Foundation.h>
#import <HorosAPI/DicomImage.h>
#import <HorosAPI/DCMPix.h>
#import <HorosDCM/DCMObject.h>
#import <HorosDCM/DCMAttribute.h>
#import <HorosDCM/DCMAttributeTag.h>
#import <HorosDCM/DCMSequenceAttribute.h>
#import <HorosDCM/DCMCalendarDate.h>

#import "AFEnergyWindow.h"


@interface AFImage : NSObject{
    DicomImage      *dbImageRef;
    NSDate          *acqTime;
    AFEnergyWindow *energyWindow;
    DCMPix *image;
    long width, height;
}

@property (retain) NSDate          *acqTime;
@property (retain) AFEnergyWindow *energyWindow;
@property (retain) DicomImage      *dbImageRef;
@property (retain) DCMPix          *image;
@property long                      width;
@property long                      height;

- (id) initWithDicomImage:(DicomImage*)dicomImage;
- (void) dealloc;

+ (AFImage*) imageFromDicomImage:(DicomImage*)dicomImage;

- (BOOL) parseDicomImage;

- (float) totalCounts;
@end
