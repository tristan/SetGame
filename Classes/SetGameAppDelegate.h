//
//  SetGameAppDelegate.h
//  SetGame
//
//  Created by Tristan King on 28/07/08.
//  Copyright Information Technology & Resources 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SetGameViewController;

@interface SetGameAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	UIViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIViewController *viewController;

//- (IBAction)newGame:(id)sender;
//- (IBAction)noSet:(id)sender;

@end

