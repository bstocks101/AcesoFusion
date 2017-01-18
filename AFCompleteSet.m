//
//  AFCompleteSet.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/16.
//
//

#import "AFCompleteSet.h"

@implementation AFCompleteSet

-(id) initWithXR: (DicomSeries*) xr andUS: (DicomSeries*) us{
    self.xrSeries = xr;
    self.usSeries = us;
    return self;
}

@end
