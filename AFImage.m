//
//  AFImage.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import "AFImage.h"

@implementation AFImage

@synthesize dbImageRef;
@synthesize acqTime;
@synthesize energyWindow;

- (id) initWithDicomImage:(DicomImage*)dicomImage {
    if (! (self = [super init]))
        return nil;
    
        dbImageRef = dicomImage;
        
        if (! [self parseDicomImage])
            return nil;
        
        long frameNo = 0;
        if(dicomImage.frameID)
            frameNo = [dicomImage.frameID longValue];
        
        image = [[DCMPix alloc] initWithPath:dicomImage.completePath :0 :1 :nil :frameNo
                                            :0 isBonjour:NO imageObj:dicomImage];
        
        
    if((!image) || image.isRGB)
        return nil;
    
    width = image.pwidth;
    height = image.pheight;
    
    return self;
}

- (void) dealloc {
    self.acqTime      = nil;
    self.energyWindow = nil;
    self.image = nil;
    
    [super dealloc];
}

+ (AFImage*) imageFromDicomImage:(DicomImage*)dicomImage {
    return [[[AFImage alloc] initWithDicomImage:dicomImage] autorelease];
}

- (BOOL) parseDicomImage {
    // Load DICOM Object
    DCMObject *dcmObject  = [DCMObject objectWithContentsOfFile:[dbImageRef completePath]
                                              decodingPixelData:false];
    
    // Acquistion Date & Time
    DCMCalendarDate *acqDateTime = [[dcmObject attributeForTag:
                                     [DCMAttributeTag tagWithGroup:0x8
                                                           element:0x2A]] value];
    if (acqDateTime == nil) {
        DCMCalendarDate *date = [[dcmObject attributeForTag:
                                  [DCMAttributeTag tagWithGroup:0x8
                                                        element:0x22]] value];
        DCMCalendarDate *time = [[dcmObject attributeForTag:
                                  [DCMAttributeTag tagWithGroup:0x8
                                                        element:0x32]] value];
        
        acqDateTime = [DCMCalendarDate dicomDateTimeWithDicomDate:date
                                                        dicomTime:time];
    }
    
    // convert to NSDate because DCMCalendarDate might not adhere to NSCopying,
    // which we need to able to use it as a dictionary key
    self.acqTime = [NSDate dateWithTimeIntervalSince1970:
                    [acqDateTime timeIntervalSince1970]];
    
    // Get information on energy windows
    int energyWindowUsed = 0;
    
    NSArray *energyWinVec = [[dcmObject attributeForTag:
                              [DCMAttributeTag tagWithGroup:0x54
                                                    element:0x10]] values];
    
    if (energyWinVec != nil) {
        int frameNo = 0;
        if ([dbImageRef frameID] != nil)
            frameNo = [[dbImageRef frameID] intValue];
        
        if (frameNo >= [energyWinVec count])
            frameNo = 0;
        
        energyWindowUsed = [[energyWinVec objectAtIndex:frameNo] intValue]-1;
    }
    
    
    // Energy Window Information Sequence
    DCMSequenceAttribute *energyWinInfoSeq =
    (DCMSequenceAttribute*) [dcmObject attributeForTag:
                             [DCMAttributeTag tagWithGroup:0x54
                                                   element:0x12]];
    if (! energyWinInfoSeq)
        return FALSE;
    
    DCMObject *energyWinInfoItem = [[energyWinInfoSeq sequence]
                                    objectAtIndex:energyWindowUsed];
    if (! energyWinInfoItem)
        return FALSE;
    
    DCMSequenceAttribute *energyWinRangeSeq =
    (DCMSequenceAttribute*) [energyWinInfoItem attributeForTag:
                             [DCMAttributeTag tagWithGroup:0x54
                                                   element:0x13]];
    
    // if there are more than one energy windows in the sequence this is strange
    // in this case we use only the first window
    DCMObject *energyWinRangeItem = [[energyWinRangeSeq sequence]
                                     objectAtIndex:0];
    if (! energyWinRangeItem)
        return FALSE;
    
    NSNumber *lowerLimit = [[energyWinRangeItem attributeForTag:
                             [DCMAttributeTag tagWithGroup:0x54
                                                   element:0x14]] value];
    NSNumber *upperLimit = [[energyWinRangeItem attributeForTag:
                             [DCMAttributeTag tagWithGroup:0x54
                                                   element:0x15]] value];
    self.energyWindow = [AFEnergyWindow energyWindowWithLowerLimit:[lowerLimit floatValue]
                                                         upperLimit:[upperLimit floatValue]];
    
    return TRUE;
}

-(float) totalCounts{
    long nPixels = width*height;
    float *pixValue = image.fImage;
    float totalCounts = 0;
    
    for (long i=0; i < nPixels; i++,pixValue++)
        totalCounts += (*pixValue);
    
    return totalCounts;
}

@end
