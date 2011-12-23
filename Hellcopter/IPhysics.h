//
//  IPhysics.h
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPhysics <NSObject>
    -(void) DoPhysics: (double) elapsed;
@end
