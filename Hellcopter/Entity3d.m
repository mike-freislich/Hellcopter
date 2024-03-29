//
//  Entity3d.m
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import "Entity3d.h"
#import "HellcopterTypes.h"
#import <OpenGl/gl.h>

@implementation Entity3d

float maxVelocity;
@synthesize position;
@synthesize rotation;

- (id)init {
    self = [super init];
    if (self) {
        [self setRotation: 0: 0: 0];       
        [self setPosition: 0: 0: 0];
    }
    return self;
}
    

-(void) DoPhysics: (double) elapsed
{
    //TODO: base Physics here
}

-(void) DoAI: (double) elapsed
{
    //TODO: base AI here
}

-(void) Draw
{
    glTranslatef(position.x, position.y, position.z);
    glRotatef(rotation.x, 1, 0, 0);
    glRotatef(rotation.y, 0, 1, 0);
    glRotatef(rotation.z, 0, 0, 1);
}

-(void) Move: (float) x: (float) y: (float)z
{
    position.x += x;
    position.y += y;
    position.z += z;
}

-(void) setPosition: (float) x: (float) y: (float)z
{
    position.x = x;
    position.y = y;
    position.z = z;    
}

-(void) setRotation: (float) angleX: (float) angleY: (float) angleZ
{
    rotation.x = angleX;
    rotation.y = angleY;
    rotation.z = angleZ;
}

-(void) Rotate: (float) angleX: (float) angleY: (float) angleZ
{
    rotation.x += angleX;
    rotation.y += angleY;
    rotation.z += angleZ;
}

@end
