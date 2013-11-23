//
//  AppDelegate.h
//  BugButtonExample
//
//  Created by Mason Silber on 11/23/13.
//  Copyright (c) 2013 MasonSilber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "BugButton.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BugButtonDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
