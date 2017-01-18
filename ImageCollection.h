//
//  ImageCollection.h
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import <Foundation/Foundation.h>
#import "AFDCMImage.h"


@interface ImageCollection : NSObject

@property (retain) NSMutableArray *images;

-(id) init;

- (void) addImage:(DicomImage*) image;

- (AFDCMImage*) getImageAtFrame:(int) frame;


@end
