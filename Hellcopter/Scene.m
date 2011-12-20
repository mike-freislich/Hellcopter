/*
 File: Scene.m
 Abstract:  A delegate object used by MyOpenGLView and MainController to 
 render a simple scene.
*/

#import "Scene.h"
#import "Texture.h"
#import <OpenGL/glu.h>

static double dtor( double degrees )
{
    return degrees * M_PI / 180.0;
}

@implementation Scene

- (id) init
{
    self = [super init];
    if (self) {
		textureName = 0;
        animationPhase = 0.0;
        rollAngle = 0.0;
        sunAngle = 135.0;
        wireframe = NO;
    } 
    return self;
}

- (void)dealloc
{
	[texture release];
    [super dealloc];
}

- (float)rollAngle
{
    return rollAngle;
}

- (void)setRollAngle:(float)newRollAngle
{
    rollAngle = newRollAngle;
}

- (float)sunAngle
{
    return sunAngle;
}

- (void)setSunAngle:(float)newSunAngle
{
    sunAngle = newSunAngle;
}

- (void)advanceTimeBy:(float)seconds
{
    float phaseDelta = seconds - floor(seconds);
    float newAnimationPhase = animationPhase + 0.015625 * phaseDelta;
    newAnimationPhase = newAnimationPhase - floor(newAnimationPhase);
    [self setAnimationPhase:newAnimationPhase];
}

- (void)setAnimationPhase:(float)newAnimationPhase
{
    animationPhase = newAnimationPhase;
}

- (void)toggleWireframe
{
    wireframe = !wireframe;
}

- (void)setViewportRect:(NSRect)bounds
{
	glViewport(0, 0, bounds.size.width, bounds.size.height);
	
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(30, bounds.size.width / bounds.size.height, 1.0, 1000.0);
	glMatrixMode(GL_MODELVIEW);
}

// This method renders our scene.
// We could optimize it in any of several ways, including factoring out the repeated OpenGL initialization calls and 
// hanging onto the GLU quadric object, but the details of how it's implemented aren't important here. 
// The main thing to note is that we've factored the drawing code out of the NSView subclass so that
// the full-screen and non-fullscreen views share the same states for rendering 
// (and MainController can use it when rendering in full-screen mode on pre-10.6 systems).
- (void)render
{	
	static GLfloat lightDirection[] = { -0.7071, 0.0, 0.7071, 0.0 };
    static GLfloat radius = 0.25;
    static GLfloat materialAmbient[4] = { 0.0, 0.0, 0.0, 0.0 };
    static GLfloat materialDiffuse[4] = { 1.0, 1.0, 1.0, 1.0 };
    GLUquadric *quadric = NULL;
	
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glEnable(GL_TEXTURE_2D);

    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
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
}

@end
