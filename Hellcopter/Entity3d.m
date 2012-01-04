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
        rotation.x = 0;
        rotation.y = 0;
        rotation.z = 0;
        
        [self setPosition:0.0f :0.0f :-3.0f];
    }
    return self;
}
    

-(void) DoPhysics: (double) elapsed
{
}

-(void) DoAI: (double) elapsed
{
    float degPerSec = 60; 
    
    [self rotateBy:degPerSec * elapsed :0.0f :0.0f];
}

-(void) Draw
{

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

-(void) rotateBy: (float) angleX: (float) angleY: (float) angleZ
{
    rotation.x += angleX;
    rotation.y += angleY;
    rotation.z += angleZ;
}

@end
