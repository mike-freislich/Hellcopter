//
//  HellcopterTypes.h
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import <Cocoa/Cocoa.h>

struct Vector3f {
    GLfloat x;
    GLfloat y;
    GLfloat z;
};

struct Vector3d {
    GLdouble x;
    GLdouble y;
    GLdouble z;
};

struct Vector3i {
    GLint x;
    GLint y;
    GLint z;
};

struct TextureCoords2f {
    GLfloat u;
    GLfloat v;
};
