/*
 File: Texture.h
 Abstract:  A help class that loads an OpenGL texture from an image path.
*/

#import <Cocoa/Cocoa.h>

@interface Texture : NSObject {
	
	GLuint texId;
	GLuint pboId;
	GLubyte	*data;
}

- (id) initWithPath:(NSString*)path;
- (GLuint) textureName;

@end
