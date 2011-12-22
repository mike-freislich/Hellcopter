/*
 File: Scene.m
 Abstract:  A delegate object used by MyOpenGLView and MainController to 
 render a simple scene.
*/

#import "Scene.h"
#import "Texture.h"
#import <OpenGL/glu.h>


@implementation Scene

- (id) init
{
    self = [super init];
    if (self) {
        gameMode = SplashScreen; 
    } 
    return self;
}

- (void)dealloc
{
    [super dealloc];
}


- (void)advanceTimeBy:(float)seconds
{
    elapsed = seconds - floor(seconds);
    
    switch (gameMode) {
    
        case SplashScreen:
            break;
        
        case MainMenu:
            break;
            
        case LevelIntro:
            break;
            
        case LevelInPlay:
            break;
            
        case LevelCompleted:
            break;
            
        case GamePaused:
            break;
            
    }
}

- (void)setGameMode:(EnumGameMode)newGameMode
{
    gameMode = newGameMode;
}


- (void)setViewportRect:(NSRect)bounds
{
	glViewport(0, 0, bounds.size.width, bounds.size.height);
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(30, bounds.size.width / bounds.size.height, 1.0, 1000.0);
	glMatrixMode(GL_MODELVIEW);
}


- (void)render
{		
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glEnable(GL_TEXTURE_2D);

    glClearColor(0, 0, 0.2, 0);
    
    switch (gameMode) {
            
        case SplashScreen:
            glClearColor(1, 0, 0, 0);
            break;
            
        case MainMenu:
            glClearColor(0, 1, 0, 0);
            break;
            
        case LevelIntro:
            glClearColor(0, 0, 1, 0);
            break;
            
        case LevelInPlay:
            glClearColor(1, 1, 0, 0);
            break;
            
        case LevelCompleted:
            glClearColor(0, 1, 1, 0);
            break;
            
        case GamePaused:
            glClearColor(1, 1, 1, 0);
            break;
            
    }    
    
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
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

@end
