//
//  GameEngine.m
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import "GameEngine.h"
#import "Terrain.h"
#import <OpenGL/gl.h>

@implementation GameEngine

@synthesize gameMode;
@synthesize elapsed;

NSMutableArray* friendlyBulletArray;
NSMutableArray* enemyBulletArray;
NSMutableArray* enemyArray;

Terrain* terrain;
Player* player;
EnumGameMode previousGameMode;

- (id)init {
    self = [super init];
    if (self) {
        player = [[Player alloc] init];
        
        self.gameMode = gmLevelInPlay;
        previousGameMode = self.gameMode;
        
        self.elapsed = 0;
        terrain = [[Terrain alloc] init];
        
        [self InitLighting];
    }
    return self;
} 

-(void) render
{
    [self InitLighting];
    
    glEnable(GL_DEPTH_TEST);
	//glPolygonMode( GL_FRONT_AND_BACK, GL_LINE );
    //glEnable(GL_CULL_FACE);
    //glEnable(GL_DEPTH);
	//glEnable(GL_TEXTURE_2D);
    glEnable(GL_COLOR_MATERIAL);
    glShadeModel(GL_SMOOTH);
    
    
    switch (gameMode) {
            
        case gmSplashScreen:
            glClearColor(1, 0, 0, 0);
                glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
            break;
            
        case gmMainMenu:
            glClearColor(0, 1, 0, 0);
                glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
            break;
            
        case gmLevelIntro:
            glClearColor(0, 0, 1, 0);
            glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
            break;
            
        case gmLevelInPlay:
            [self doAI];
            [self doPhysics];
            [self renderLevel];
            break;
            
        case gmLevelCompleted:
            glClearColor(0, 1, 1, 0);
            break;
            
        case gmGamePaused:
            self.elapsed = 0;
            [self renderLevel];
            //TODO: overlay a transparent black rectangle over the screen to show that the game is paused
            //TODO: print "GAME PAUSED" over the screen
            //TODO: Pause the music (when there is a jukebox object
            break;
    }    
    
}

-(void) renderLevel
{
    glClearColor(0.3, 0.3, 0.8, 0);
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    glLoadIdentity();
    [player Draw];   
    
    glLoadIdentity();
    [terrain Rotate: 0: elapsed * 10: 0];
    [terrain Draw];    
    
    /*
     // Upload the texture
     // Since we are sharing OpenGL objects between the full-screen and non-fullscreen contexts, we only need to do this once
     if (!textureName) {
     NSString *path = [[NSBundle mainBundle] pathForResource:@"Earth" ofType:@"jpg"];
     texture = [[Texture alloc] initWithPath:path];
     textureName = [texture textureName];
     }
     
     // Set up texturing parameters
     glBindTexture(GL_TEXTURE_2D, textureName);
     glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
     
     
     // Set up our single directional light (the Sun!)
     float lightDirection[3];
     lightDirection[0] = cos(dtor(sunAngle));
     lightDirection[2] = sin(dtor(sunAngle));
     glLightfv(GL_LIGHT0, GL_POSITION, lightDirection);
     
     glPushMatrix();
     
     
     // Back the camera off a bit
     glTranslatef(0.0, 0.0, -1.5);
     
     // Draw the Earth!
     quadric = gluNewQuadric();
     if (wireframe)
        gluQuadricDrawStyle(quadric, GLU_LINE);
     
     gluQuadricTexture(quadric, GL_TRUE);
     glMaterialfv(GL_FRONT, GL_AMBIENT, materialAmbient);
     glMaterialfv(GL_FRONT, GL_DIFFUSE, materialDiffuse);
     glRotatef(rollAngle, 1.0, 0.0, 0.0);
     glRotatef(-23.45, 0.0, 0.0, 1.0); // Earth's axial tilt is 23.45 degrees from the plane of the ecliptic
     glRotatef(animationPhase * 360.0, 0.0, 1.0, 0.0);
     glRotatef(-90.0, 1.0, 0.0, 0.0);
     gluSphere(quadric, radius, 48, 24);
     gluDeleteQuadric(quadric);
     quadric = NULL;
     
     glPopMatrix();
     
     glBindTexture(GL_TEXTURE_2D, 0);
     */
}

-(void) InitLighting
{
    float colorBlack[]  = {0.0f,0.0f,0.0f,1.0f};
    float colorWhite[]  = {1.0f,1.0f,1.0f,1.0f};
    float colorGray[]   = {0.6f,0.6f,0.6f,1.0f};
    float colorRed[]    = {1.0f,0.0f,0.0f,1.0f};
    float colorBlue[]   = {0.0f,0.0f,0.1f,1.0f};
    float colorGreen[]   = {0,1,0,1};
    float colorYellow[] = {1.0f,1.0f,0.0f,1.0f};
    float colorLightYellow[] = {.5f,.5f,0.0f,1.0f};
    
    // First Switch the lights on.
    glEnable(GL_LIGHTING);
    glDisable(GL_LIGHT0);
    glEnable(GL_LIGHT1);
    glDisable(GL_LIGHT2);
    
    // Light 1.
    float posLight1[] = { 0, 40, 20, 1 };
    float spotDirection[] = { 0, 0, 0 };
    glLightfv( GL_LIGHT1, GL_POSITION, posLight1 );
    //glLightf( GL_LIGHT1, GL_SPOT_CUTOFF, 100.0f );
    //glLightfv( GL_LIGHT1, GL_SPOT_DIRECTION, spotDirection );
    
    glLightfv( GL_LIGHT1, GL_AMBIENT, colorBlack);
    glLightfv( GL_LIGHT1, GL_DIFFUSE, colorGreen );
    glLightfv( GL_LIGHT1, GL_SPECULAR, colorWhite );
    glLightf( GL_LIGHT1, GL_CONSTANT_ATTENUATION, 0.8f );
    
    
    //
    // Light 2.
    //
    // Position and direction
    float posLight2[] = { .5f, 1.f, 3.f, 0.0f };
    glLightfv( GL_LIGHT2, GL_POSITION, posLight2 );
    //
    glLightfv( GL_LIGHT2, GL_AMBIENT, colorBlack );
    glLightfv( GL_LIGHT2, GL_DIFFUSE, colorGray );
    glLightfv( GL_LIGHT2, GL_SPECULAR, colorWhite );
    //
    glLightf( GL_LIGHT2, GL_CONSTANT_ATTENUATION, 0.8f );
}

-(void) doAI
{
    [player DoAI:elapsed];
    
}

-(void) doPhysics
{
    [player DoPhysics:elapsed];
}



@end
