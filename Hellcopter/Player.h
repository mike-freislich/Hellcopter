//
//  Player.h
//  Hellcopter
//
//  Created by Mike Freislich on 2012/01/04.
//  Copyright (c) 2012 Clue. All rights reserved.
//

#import "Entity3d.h"

@interface Player : Entity3d

-(void) Draw;
-(void) DoAI: (double) elapsed;
-(void) DoPhysics:(double)elapsed;

@end
