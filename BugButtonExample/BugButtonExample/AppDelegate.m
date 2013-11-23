//
//  AppDelegate.m
//  BugButtonExample
//
//  Created by Mason Silber on 11/23/13.
//  Copyright (c) 2013 MasonSilber. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate {
    BugButton *bugButton;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *viewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    bugButton = [BugButton bugButton];
    bugButton.delegate = self;
    [self.window addSubview:bugButton];
    return YES;
}

- (void)reportBug:(BugButton *)sender
{
    NSLog(@"BUG REPORT");
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView *cannotEmailAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"This device is not set up to send email."
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil, nil];
        [cannotEmailAlert show];
        return;
    }
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    [mailViewController setMailComposeDelegate:self];
    [mailViewController setToRecipients:@[@"bug-reports@myapp.com"]];
    [mailViewController setSubject:@"Bug Report"];
    [mailViewController setMessageBody:[sender bugReportString] isHTML:NO];
    [mailViewController addAttachmentData:[sender getScreenshot] mimeType:@"image/jpeg" fileName:@"screenshot"];
    [self.window.rootViewController presentViewController:mailViewController animated:YES completion:nil];
    [sender removeFromSuperview];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [self.window addSubview:bugButton];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
