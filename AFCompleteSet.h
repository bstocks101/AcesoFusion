//
//  AFCompleteSet.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/16.
//
//

#import <Foundation/Foundation.h>
#import <HorosAPI/PluginFilter.h>

@interface AFCompleteSet : NSObject

@property (retain) DicomSeries* xrSeries;
@property (retain) DicomSeries* usSeries;

-(id) initWithXR: (DicomSeries*) xr andUS: (DicomSeries*) us;

@end
