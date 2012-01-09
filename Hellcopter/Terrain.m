//
//  Terrain.m
//  Hellcopter
//
//  Created by Mike Freislich on 2012/01/06.
//  Copyright (c) 2012 Clue. All rights reserved.
//

#import "Terrain.h"
#import <OpenGL/gl.h>
#import "HellcopterTypes.h"

@implementation Terrain

#define MAP_MAXX 512
#define MAP_MAXY 512

int elevationMap[MAP_MAXX][MAP_MAXY];
int vertexCount;

struct TextureCoords2f* texCoords = nil;
struct Vector3f* vertices = nil;
float rotation = 0;

GLubyte	*data;

-(id) init
{
    if (self)
    {
        [self setPosition: 0: -10: -50];
        [self setRotation: 0: 0: 0];
        [self LoadHeightMapFromRAW];
    }
    return self;
}

- (BOOL) getImageDataFromPath:(NSString*)path
{
	NSUInteger				width, height;
	NSURL					*url = nil;
	CGImageSourceRef		src;
	CGImageRef				image;
	CGContextRef			context = nil;
	CGColorSpaceRef			colorSpace;
	
	data = (GLubyte*) calloc(MAP_MAXX * MAP_MAXY * 4, sizeof(GLubyte));
	
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


-(void) LoadHeightMapFromRAW
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"terrain" ofType:@"gif"];
    
    if (!path || ![self getImageDataFromPath:path])
        return;
    
    for (int x = 0; x < MAP_MAXX; x ++)
    {
        for (int y = 0; y < MAP_MAXY; y ++)
        {
            elevationMap[x][y] = [self PointHeight:x :y];
        }
    }
     
    [self LoadVertexBuffer];
}

-(void) LoadVertexBuffer
{
    int width = MAP_MAXX;
    int height = MAP_MAXY;
    
    vertexCount = width * height * 6;
    
    if (vertices) free(vertices);
    if (texCoords) free(texCoords);
    vertices = malloc(vertexCount * sizeof(struct Vector3f));
    texCoords = malloc(vertexCount * sizeof(struct TextureCoords2f));

    float flx, flz;
    int index = 0;
    int xoffset;
    int zoffset;
    for ( int x = 0; x < width-1; x++ )
    {
        for ( int z = 0; z < height-1; z++ )
        {
            
            for( int tri = 0; tri < 6; tri++ )
            {
                xoffset = ( tri == 2 || tri == 3 || tri == 5 ) ? 1 : 0;
                zoffset = ( tri == 0 || tri == 2 || tri == 3 ) ? 1 : 0;
                flx = (float) x + xoffset;
                flz = (float) z + zoffset;
                
                // Set The Data, Using PtHeight To Obtain The Y Value
                vertices[index].x = flx - (width / 2);
                vertices[index].z = flz - (height / 2);
                vertices[index].y = (float)elevationMap[x + xoffset][z + zoffset] / 5;
                
                // Stretch The Texture Across The Entire Mesh
                texCoords[index].u = flx / width;
                texCoords[index].v = flz / height;
                
                index++;
            }
            
        }
    }
}

-(float) PointHeight: (int) x: (int) y
{
    
    int width = MAP_MAXX;
    int height = MAP_MAXY;
    
    // Calculate The Position In The Texture, Careful Not To Overflow
    int pos = ( (x % width)  + ( (y % height) * width ) ) * 4;
    float r = (float) data[ pos + 1 ];
    float g = (float) data[ pos + 2 ];
    float b = (float) data[ pos + 3 ];
    return ( 0.299f * r + 0.587f * g + 0.114f * b ) / 2.0f - 10.0f;    
}

-(void) Draw
{    
    [super Draw];
    
    [self setMaterial];
    
    // Draw without Vertex Buffer Objects (slow and simple to start)
    glEnableClientState( GL_VERTEX_ARRAY );               
    glEnableClientState( GL_TEXTURE_COORD_ARRAY ); 
    
    glVertexPointer( 3, GL_FLOAT, 0, vertices ); 
    glTexCoordPointer( 2, GL_FLOAT, 0, texCoords );
    glDrawArrays( GL_TRIANGLES, 0, vertexCount );
    
    glDisableClientState( GL_VERTEX_ARRAY );                
    glDisableClientState( GL_TEXTURE_COORD_ARRAY );  
}

-(void) setMaterial
{
    float colorWhite[] = { 1,0, 1.0, 1.0, 0.0 };
    float colorBlack[] = { 0.0, 0.0, 0.0, 0.0 };
    
    glMaterialfv( GL_FRONT_AND_BACK, GL_AMBIENT, colorBlack );
    glMaterialfv( GL_FRONT_AND_BACK, GL_DIFFUSE, colorWhite );
    glMaterialfv( GL_FRONT_AND_BACK, GL_SPECULAR, colorWhite );
    glMateriali( GL_FRONT_AND_BACK, GL_SHININESS, 4 );
    glMaterialfv( GL_FRONT_AND_BACK, GL_EMISSION, colorBlack );
}


@end
