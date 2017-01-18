//
//  ImageCollection.m
//  AcesoFusion
//
//  Created by Bradley Stocks on 2017/01/09.
//
//

#import "ImageCollection.h"

@implementation ImageCollection

-(id) init{
    self.images = [[[NSMutableArray alloc] init] autorelease];
    return self;
}


-(void) addImage:(DicomImage*)image{
    [self.images addObject:[[AFDCMImage alloc] initWithDicomImage:image]];
}

- (AFDCMImage*) getImageAtFrame:(int) frame{
    AFDCMImage* image = (AFDCMImage*)[self.images objectAtIndex:frame];
    if(image == nil){
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        NSString *message = [NSString stringWithFormat:@"No image at frame %i", frame];
        [alert setMessageText:message];
        [alert runModal];
    }
    return image;
}


@end
