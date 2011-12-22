/*
 File: Scene.h
 Abstract:  A delegate object used by MyOpenGLView and MainController to 
 render a simple scene.
*/

#import <Cocoa/Cocoa.h>


@class Texture;

typedef enum {
    SplashScreen,
    MainMenu,
    LevelIntro,
    LevelInPlay,
    LevelCompleted,
    GamePaused
} EnumGameMode;


@interface Scene : NSObject {

    EnumGameMode gameMode;

    float elapsed;
}

- (id)init;

- (void)setViewportRect:(NSRect)bounds;
- (void)render;

- (void)advanceTimeBy:(float)seconds;

- (void)setGameMode:(EnumGameMode)newGameMode;


@end
