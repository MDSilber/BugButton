BugButton
=========

What is it?
---------
Have you ever beta tested an app before? If you have, you know that one of the most important things is for users to be able to report bugs they find. BugButton makes it almost effortless for beta testers to report bugs. There are no dependencies except UIKit, so you simply need to drop the BugButton classes and resources into your project and you're ready to go!

How to get it
--------
There are two ways:  
1.  Download the source and drag it into your project  
2.  Add `pod 'BugButton'` to your Podfile and run `pod install`  
    Note: If you don't have CocoaPods integrated in your projects, you can find out how to add it at [cocoapods.org](http://cocoapods.org/ "CocoaPods")

How to use it
--------
1.  Go to your App Delegate's header file, and import "BugButton.h"
2.  Make your App Delegate a BugButtonDelegate
3.  Go to your App Delegate's implementation, and add the `- (void)reportBug:(BugButton *)sender` delegate method. This is where you customize what you want to happen when a user taps the bug button.

Features
--------
- Draggable button present on all screens of the app
- Contains built in screenshot generation to send with diagnostic reports

Example usage
--------
In this example (from the included example project), tapping the bug button will bring up an email form that the user can fill out. It also attaches a screenshot of the current state of the app, as well as the device model, OS version, and app version for diagnostics.

AppDelegate.h:
```
#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "BugButton.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BugButtonDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
```

AppDelegate.m
```
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

@end
```

Feel free to get in touch with me with any questions or any (ironic) bugs you find by emailing me at <mdsilber1@gmail.com>
