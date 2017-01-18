/*=========================================================================
  Program:   OsiriX

  Copyright (c) OsiriX Team
  All rights reserved.
  Distributed under GNU - LGPL
  
  See http://www.osirix-viewer.com/copyright.html for details.

     This software is distributed WITHOUT ANY WARRANTY; without even
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE.
 ---------------------------------------------------------------------------
 
 This file is part of the Horos Project.
 
 Current contributors to the project include Alex Bettarini and Danny Weissman.
 
 Horos is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation,  version 3 of the License.
 
 Horos is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with Horos.  If not, see <http://www.gnu.org/licenses/>.

 

 
 ---------------------------------------------------------------------------
 
 This file is part of the Horos Project.
 
 Current contributors to the project include Alex Bettarini and Danny Weissman.
 
 Horos is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation,  version 3 of the License.
 
 Horos is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with Horos.  If not, see <http://www.gnu.org/licenses/>.

=========================================================================*/



#import <Cocoa/Cocoa.h>

#ifdef __cplusplus
#define id Id
	#include "itkImage.h"
	#include "itkImportImageFilter.h"
#undef id
#import "ITK.h"
#else
@class ITK;
#endif

#include "DCMView.h" // for ToolMode

@class ViewerController;


/** \brief ITK based segmentation for region growing
*/
@interface ITKSegmentation3D : NSObject {

	ITK		*itkImage;
	BOOL	_resampledData;
	
}

#ifdef id
#define redefineID
#undef id
#endif

+ (NSArray*) fastGrowingRegionWithVolume: (float*) volume width:(long) w height:(long) h depth:(long) depth seedPoint:(long*) seed from:(float) from pixList:(NSArray*) pixList;
- (id) initWith :(NSMutableArray*) pix :(float*) volumeData  :(long) slice;
- (id) initWithPix :(NSMutableArray*) pix volume:(float*) volumeData  slice:(long) slice resampleData:(BOOL)resampleData;
- (void) regionGrowing3D:(ViewerController*) srcViewer :(ViewerController*) destViewer :(long) slice :(NSPoint) startingPoint :(int) algorithmNumber :(NSArray*) parameters :(BOOL) setIn :(float) inValue :(BOOL) setOut :(float) outValue :(ToolMode) roiType :(long) roiResolution :(NSString*) newname :(BOOL) mergeWithExistingROIs;
// extract lumen for Centerline calculation
//- (NSArray *)endoscopySegmentationForViewer:(ViewerController*) srcViewer seeds:(NSArray *)seeds;
+ (NSMutableArray*) extractContour:(unsigned char*) map width:(long) width height:(long) height;
+ (NSMutableArray*) extractContour:(unsigned char*) map width:(long) width height:(long) height numPoints:(long) numPoints;
+ (NSMutableArray*) extractContour:(unsigned char*) map width:(long) width height:(long) height numPoints:(long) numPoints largestRegion:(BOOL) largestRegion;

#ifdef redefineID
#define id Id
#undef redefineID
#endif

@end
