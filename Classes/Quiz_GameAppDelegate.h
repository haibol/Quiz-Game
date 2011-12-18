//
//  Quiz_GameAppDelegate.h
//  Quiz Game
//
//  Created by Kevin Anderson
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Quiz_GameViewController;

@interface Quiz_GameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Quiz_GameViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Quiz_GameViewController *viewController;

@end

