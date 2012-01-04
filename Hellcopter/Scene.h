/*
 File: Scene.h
 Abstract:  A delegate object used by MyOpenGLView and MainController to 
 render a simple scene.
*/

#import <Cocoa/Cocoa.h>
#import "GameEngine.h"


@class Texture;




@interface Scene : NSObject {    
    float elapsed;
}

- (id)init;

- (void)setViewportRect:(NSRect)bounds;
- (void)render;

- (void)advanceTimeBy:(double)seconds;

- (GameEngine *)gameEngine;

@end
