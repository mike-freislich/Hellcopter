//
//  GameEngine.h
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

typedef enum {
    gmSplashScreen,
    gmMainMenu,
    gmLevelIntro,
    gmLevelInPlay,
    gmLevelCompleted,
    gmGamePaused
} EnumGameMode;

@interface GameEngine : NSObject{
}

@property double elapsed;
@property EnumGameMode gameMode;

-(void) render;
-(void) renderLevel;
-(void) doAI;
-(void) doPhysics;
-(void) InitLighting;


@end
