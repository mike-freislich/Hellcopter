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

-(void) Draw
{
    glLoadIdentity();
    glTranslatef(super.position.x, super.position.y, super.position.z);
    glRotatef(super.rotation.x, 1.0, 0.0, 0.0);
    glRotatef(super.rotation.y, 0.0, 1.0, 0.0);
    glRotatef(super.rotation.z, 0.0, 0.0, 1.0);
    
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
    [self rotateBy:degPerSec * elapsed :0.0f :0.0f];
}

-(void) DoPhysics: (double) elapsed
{
    [super DoPhysics:elapsed];
}
 

@end
