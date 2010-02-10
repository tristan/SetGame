//
//  SetGameAppDelegate.m
//  SetGame
//
//  Created by Tristan King on 28/07/08.
//  Copyright Information Technology & Resources 2008. All rights reserved.
//

#import "SetGameAppDelegate.h"

@implementation SetGameAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	UIViewController *aViewController = [[UIViewController alloc] initWithNibName:@"SetBoardView" bundle:[NSBundle mainBundle]];
	self.viewController = aViewController;
	[aViewController release];
	
	UIView *controllersView = [viewController view];
	[controllersView updateScoreLabel];
	[[controllersView label] setText:@""];
	[window addSubview:controllersView];
    [window makeKeyAndVisible];
}
/*
- (void)applicationWillTerminate:(UIApplication *)application {
	[super applicationWillTerminate];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[super applicationDidReveiveMemoryWarning];
}*/

- (void)dealloc {
	[viewController release];
	[window release];
	[super dealloc];
}

- (IBAction)newGame:(id)sender {
	//[label setText:@"New Game!"];
	//NSString st = @"SIZE: %d x %d";
}
- (IBAction)noSet:(id)sender {
	//[label setText:@"No Set!"];
}

@end
