//
//  Player.m
//  Hellcopter
//
//  Created by Mike Freislich on 2012/01/04.
//  Copyright (c) 2012 Clue. All rights reserved.
//

#import "Player.h"
#import <OpenGl/gl.h>

@implementation Player

-(id) init
{
    [super init];
    [self setPosition:0: 0: -6];
    
    return self;
}

-(void) Draw
{
    
    [super Draw];
    
    glBegin( GL_TRIANGLES );             
    glVertex3f(  0.0f,  1.0f, 0.0f );    // Top
    glVertex3f( -1.0f, -1.0f, 0.0f );    // Bottom left
    glVertex3f(  1.0f, -1.0f, 0.0f );    // Bottom right
    glEnd();                             // Done with the triangle
}

-(void) DoAI: (double) elapsed
{
    [super DoAI:elapsed];

    float degPerSec = 30; 
    [self Rotate:degPerSec * elapsed :0.0f :0.0f];
}

-(void) DoPhysics: (double) elapsed
{
    [super DoPhysics:elapsed];
}
 

@end
