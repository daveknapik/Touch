//
//  TouchAppDelegate.m
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TouchAppDelegate.h"

@implementation TouchAppDelegate

@synthesize window;
@synthesize rootController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[window addSubview:rootController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[rootController release];
    [window release];
    [super dealloc];
}


@end
