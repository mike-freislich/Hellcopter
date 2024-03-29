/*
 File: Texture.m
 Abstract:  A help class that loads an OpenGL texture from an image path.
*/

#import "Texture.h"
#import <OpenGL/glu.h>

#define TEXTURE_WIDTH		1024
#define TEXTURE_HEIGHT		512

@interface Texture (PrivateMethods)

- (BOOL) getImageDataFromPath:(NSString*)path;
- (void) loadTexture;

@end

@implementation Texture

- (id) initWithPath:(NSString*)path
{	
	if (self = [super init]) {
		if ([self getImageDataFromPath:path])
			[self loadTexture];
	}
	return self;
}

- (GLuint) textureName
{
	return texId;
}

- (BOOL) getImageDataFromPath:(NSString*)path
{
	NSUInteger				width, height;
	NSURL					*url = nil;
	CGImageSourceRef		src;
	CGImageRef				image;
	CGContextRef			context = nil;
	CGColorSpaceRef			colorSpace;
	
	data = (GLubyte*) calloc(TEXTURE_WIDTH * TEXTURE_HEIGHT * 4, sizeof(GLubyte));
	
	url = [NSURL fileURLWithPath: path];
	src = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
	
	if (!src) {
		NSLog(@"No image");
		free(data);
		return NO;
	}
	image = CGImageSourceCreateImageAtIndex(src, 0, NULL);
	CFRelease(src);
	
	width = CGImageGetWidth(image);
	height = CGImageGetHeight(image);
	
	colorSpace = CGColorSpaceCreateDeviceRGB();
	context = CGBitmapContextCreate(data, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host);
	CGColorSpaceRelease(colorSpace);
	
	// Core Graphics referential is upside-down compared to OpenGL referential
	// Flip the Core Graphics context here
	// An alternative is to use flipped OpenGL texture coordinates when drawing textures
	CGContextTranslateCTM(context, 0.0, height);
	CGContextScaleCTM(context, 1.0, -1.0);
	
	// Set the blend mode to copy before drawing since the previous contents of memory aren't used. This avoids unnecessary blending.
	CGContextSetBlendMode(context, kCGBlendModeCopy);
	
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
	
	CGContextRelease(context);
	CGImageRelease(image);
	
	return YES;
}

- (void) loadTexture
{
	glGenTextures(1, &texId);
	glGenBuffers(1, &pboId);
	
	// Bind the texture
	glBindTexture(GL_TEXTURE_2D, texId);
	
	// Bind the PBO
	glBindBuffer(GL_PIXEL_UNPACK_BUFFER, pboId);
	
	// Upload the texture data to the PBO
	glBufferData(GL_PIXEL_UNPACK_BUFFER, TEXTURE_WIDTH * TEXTURE_HEIGHT * 4 * sizeof(GLubyte), data, GL_STATIC_DRAW);
	
	// Setup texture parameters
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glPixelStorei(GL_UNPACK_ROW_LENGTH, 0);
	
	// OpenGL likes the GL_BGRA + GL_UNSIGNED_INT_8_8_8_8_REV combination
	// Use offset instead of pointer to indictate that we want to use data copied from a PBO		
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, TEXTURE_WIDTH, TEXTURE_HEIGHT, 0, 
				 GL_BGRA, GL_UNSIGNED_INT_8_8_8_8_REV, 0);
	
	// We can delete the application copy of the texture data now
	free(data);
	
	glBindTexture(GL_TEXTURE_2D, 0);
	glBindBuffer(GL_PIXEL_UNPACK_BUFFER, 0);
}

- (void) dealloc
{
	glDeleteTextures(1, &texId);
	glDeleteBuffers(1, &pboId);
	[super dealloc];
}

@end
