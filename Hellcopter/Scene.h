/*
 File: Scene.h
 Abstract:  A delegate object used by MyOpenGLView and MainController to 
 render a simple scene.
*/

#import <Cocoa/Cocoa.h>

@class Texture;

@interface Scene : NSObject {
	
	Texture *texture;
	GLuint textureName;
	
    float animationPhase;
    float rollAngle;
    float sunAngle;
    BOOL wireframe;
}

- (id)init;

- (void)setViewportRect:(NSRect)bounds;
- (void)render;

- (void)advanceTimeBy:(float)seconds;
- (void)setAnimationPhase:(float)newAnimationPhase;

- (float)rollAngle;
- (void)setRollAngle:(float)newRollAngle;

- (float)sunAngle;
- (void)setSunAngle:(float)newSunAngle;

- (void)toggleWireframe;

@end
