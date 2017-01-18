//
//  AFDCMImage.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import <Foundation/Foundation.h>
#import <HorosAPI/DicomImage.h>
#import <HorosAPI/DCMPix.h>
#import <HorosDCM/DCMObject.h>
#import <HorosDCM/DCMObject.h>
#import <HorosDCM/DCMAttributeTag.h>
#import <HorosDCM/DCMAttribute.h>

@interface AFDCMImage : NSObject

@property (retain) DCMObject *object;
@property (retain) DicomSeries *series;
@property (retain) DicomImage *imageRef;
@property (retain) DCMPix   *image;
@property long width;
@property long height;

-(id) initWithSeries: (DicomSeries*) series andObject:(DCMObject*) object;

-(id) initWithDicomImage:(DicomImage*) dicomImage;

-(void) populateObject;

-(void) populateDCMPix;

-(NSString*) getPatientID;

-(float) totalPixCount;

-(DCMPix*) getImage;

@end
