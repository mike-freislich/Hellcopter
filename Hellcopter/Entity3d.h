//
//  Entity3d.h
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "HellcopterTypes.h"
#import "IPhysics.h"

@interface Entity3d : NSObject <IPhysics> {

}

-(void) Draw;
-(void) DoAI: (double) elapsed;


@end
