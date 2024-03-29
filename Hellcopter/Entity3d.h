//
//  Entity3d.h
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "HellcopterTypes.h"
#import "IPhysics.h"

@interface Entity3d : NSObject <IPhysics> {

}

@property struct Vector3f position;
@property struct Vector3f rotation;

-(void) Draw;
-(void) DoAI: (double) elapsed;
-(void) DoPhysics:(double)elapsed;


-(void) setPosition: (float) x: (float) y: (float)z;
-(void) Move: (float) x: (float) y: (float)z;

-(void) setRotation: (float) angleX: (float) angleY: (float) angleZ;
-(void) Rotate: (float) angleX: (float) angleY: (float) angleZ;


@end
