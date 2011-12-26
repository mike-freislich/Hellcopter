//
//  GameEngine.h
//  Hellcopter
//
//  Created by Mike Freislich on 2011/12/23.
//  Copyright (c) 2011 Clue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity3d.h"

typedef enum {
    gmSplashScreen,
    gmMainMenu,
    gmLevelIntro,
    gmLevelInPlay,
    gmLevelCompleted,
    gmGamePaused
} EnumGameMode;

@interface GameEngine : NSObject{;
    //EnumGameMode gameMode;
}

@property EnumGameMode gameMode;
//-(void) setGameMode:(EnumGameMode)gameMode;

-(void) render;

@end
