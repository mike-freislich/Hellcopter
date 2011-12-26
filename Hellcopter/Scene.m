/*
 File: Scene.m
 Abstract:  A delegate object used by MyOpenGLView and MainController to 
 render a simple scene.
*/

#import "Scene.h"
#import "Texture.h"
#import <OpenGL/glu.h>


@implementation Scene

GameEngine * gameEngine;

- (id) init
{
    self = [super init];
    if (self) {
        gameEngine = [[GameEngine alloc] init];
        gameEngine.gameMode = gmSplashScreen;
    } 
    return self;
}

- (void)dealloc
{
    if (gameEngine)
        [gameEngine dealloc];

    [super dealloc];
}


- (void)advanceTimeBy:(float)seconds
{
    elapsed = seconds - floor(seconds);
}

- (void)setViewportRect:(NSRect)bounds
{
	glViewport(0, 0, bounds.size.width, bounds.size.height);
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(30, bounds.size.width / bounds.size.height, 1.0, 1000.0);
	glMatrixMode(GL_MODELVIEW);
}

-(GameEngine *)gameEngine
{
    return gameEngine;
}


- (void)render
{		
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glEnable(GL_TEXTURE_2D);

    glClearColor(0, 0, 0.2, 0);
    
    [gameEngine render];
    
}

@end
