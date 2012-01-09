//
//  Terrain.h
//  Hellcopter
//
//  Created by Mike Freislich on 2012/01/06.
//  Copyright (c) 2012 Clue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "Entity3d.h"

@interface Terrain : Entity3d
{
    
}

-(void) LoadHeightMapFromRAW; //: (NSString *) filename;-(void) ComputeValues: (int) width: (int) height;
-(void) LoadVertexBuffer;
-(void) Draw;
-(void) setMaterial;
-(float) PointHeight: (int) x: (int) y;

@end
