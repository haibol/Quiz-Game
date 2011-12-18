//
//  Quiz_GameAppDelegate.m
//  Quiz Game
//
//  Created by Kevin Anderson
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Quiz_GameAppDelegate.h"
#import "Quiz_GameViewController.h"

@implementation Quiz_GameAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
