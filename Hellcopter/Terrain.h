//
//  Terrain.h
//  Hellcopter
//
//  Created by Mike Freislich on 2012/01/06.
//  Copyright (c) 2012 Clue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Terrain : NSObject
{
    
}

-(void) LoadHeightMapFromRAW; //: (NSString *) filename;-(void) ComputeValues: (int) width: (int) height;
-(void) LoadVertexBuffer;
-(void) Draw;

@end
