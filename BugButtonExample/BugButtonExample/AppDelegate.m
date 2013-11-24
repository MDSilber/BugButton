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

@end
