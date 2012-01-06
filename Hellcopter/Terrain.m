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

const int MAP_MAXX=200, MAP_MAXY=200;
int elevationMap[MAP_MAXX][MAP_MAXY];
int vertexCount;

struct TextureCoords2f* texCoords = nil;
struct Vector3f* vertices = nil;


-(void) LoadHeightMapFromRAW //: (NSString *) filename
{
    for (int x = 0; x < MAP_MAXX; x ++)
    {
        for (int y = 0; y < MAP_MAXY; y ++)
        {
            int z = rand() % 256;
            elevationMap[x][y] = z + 1;
        }
    }
 
    [self LoadVertexBuffer];
}

-(void) LoadVertexBuffer
{
    int width = MAP_MAXX;
    int height = MAP_MAXY;
    
    if (vertices) free(vertices);
    if (texCoords) free(texCoords);
    
    vertexCount = width * height * 6;
    vertices = malloc(vertexCount * sizeof(struct Vector3f));
    texCoords = malloc(vertexCount * sizeof(struct TextureCoords2f));

    float flx, flz;
    int index = 0;
    for ( int z = 0; z < height; z++ )
    {
        for ( int x = 0; x < width; x++ )
        {
            for( int nTri = 0; nTri < 6; nTri++ )
            {
                // Using This Quick Hack, Figure The X,Z Position Of The Point
                flx = (float) x + ( ( nTri == 1 || nTri == 2 || nTri == 5 ) ? 1.0f : 0.0f );
                flz = (float) z + ( ( nTri == 2 || nTri == 4 || nTri == 5 ) ? 1.0f : 0.0f );
                
                // Set The Data, Using PtHeight To Obtain The Y Value
                vertices[index].x = flx - (width / 2);
                vertices[index].z = flz - (height / 2);
                vertices[index].y = (float)elevationMap[x][z] / 256.0f;
                
                // Stretch The Texture Across The Entire Mesh
                texCoords[index].u = flx / width;
                texCoords[index].v = flz / height;
                
                // Increment Our Index
                index++;
            }
        }
    }
}

-(void) Draw
{
    glLoadIdentity();
    //2glPolygonMode( GL_FRONT_AND_BACK, GL_LINE );

    glTranslatef( 0.0f, -10.0f, -10.0f );
    glRotatef( 15.0f, 1.0f, 0.0f, 0.5f );
   
    // Draw without Vertex Buffer Objects (slow and simple to start)
    glEnableClientState( GL_VERTEX_ARRAY );               
    glEnableClientState( GL_TEXTURE_COORD_ARRAY ); 
    glVertexPointer( 3, GL_FLOAT, 0, vertices ); 
    glTexCoordPointer( 2, GL_FLOAT, 0, texCoords );
    glDrawArrays( GL_TRIANGLES, 0, vertexCount );
    glDisableClientState( GL_VERTEX_ARRAY );                // Disable Vertex Arrays
    glDisableClientState( GL_TEXTURE_COORD_ARRAY );  
}

@end
