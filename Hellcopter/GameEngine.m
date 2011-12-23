//
//  GameEngine.m
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import "GameEngine.h"

@implementation GameEngine

NSArray* friendlyBulletArray;
NSArray* enemyBulletArray;
NSArray* enemyArray;
Entity3d* player;

- (id)init {
    self = [super init];
    if (self) {
        player = [[Entity3d alloc] init];
    }
    return self;
}


@end
