//
//  AFDCMImage.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import "AFDCMImage.h"

@implementation AFDCMImage

-(id) initWithSeries: (DicomSeries*) series andObject:(DCMObject*) object{
    self.series = series;
    self.object = object;
    return self;
}

-(id) initWithDicomImage:(DicomImage *)dicomImage{
    self.imageRef = dicomImage;
//    self.object = [[DCMObject alloc]
//                   initWithContentsOfFile: [dicomImage completePath]
//                   decodingPixelData: false];
    
    return self;
}

-(void) populateDCMPix{
    long frameNo = 0;
    if(_imageRef.frameID){
        frameNo = [_imageRef.frameID longValue];
    }
    
    self.image = [[DCMPix alloc] initWithPath:_imageRef.completePath :0 :1
                                                    :nil :frameNo :0
                                           isBonjour:NO imageObj:_imageRef];
    if((!_image) || _image.isRGB){
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:@"No image data"];
        [alert runModal];
        return;
    }
    
    _width = _image.pwidth;
    _height = _image.pheight;
}

-(void) populateObject{
    self.object = [[DCMObject alloc]
                   initWithContentsOfFile: [self.imageRef completePath]
                                      decodingPixelData: false];
}

-(NSString*) getPatientID{
    DCMAttribute* patientAttr = [self.object attributeForTag:
                           [DCMAttributeTag tagWithGroup:0x10 element:0x20]];
    return (NSString*)patientAttr;
    
}

-(float) totalPixCount{
    long nPixels = _width * _height;
    float* pixVal = _image.fImage;
    float total = 0;
    
    for(int i = 0; i < nPixels ; i++, pixVal++){
        total += (*pixVal);
    }
    return total;
}

-(DCMPix*) getImage{
    return self.image;
}

@end
