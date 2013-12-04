//
//  BugButton.m
//  Thirstie
//
//  Created by Mason Silber on 11/23/13.
//  Copyright (c) 2013 Digital-Liquor-Delivery. All rights reserved.
//

#import "BugButton.h"

@interface BugButton ()
@property (nonatomic) BOOL isBeingDragged;
@end

@implementation BugButton

+ (instancetype)bugButton
{
    UIImage *bugImage = [UIImage imageNamed:@"Bug"];
    UIImage *bugHighlightedImage = [UIImage imageNamed:@"BugSelected"];
    
    BugButton *bugReportButton = [super buttonWithType:UIButtonTypeCustom];
    //Default bounds of button's center
    bugReportButton.minX = 40;
    bugReportButton.maxX = 290;
    bugReportButton.minY = 74;
    bugReportButton.maxY = 436;
    
    bugReportButton.frame = CGRectMake(240, 400, bugImage.size.width, bugImage.size.height);
    [bugReportButton setBackgroundImage:bugImage forState:UIControlStateNormal];
    [bugReportButton setBackgroundImage:bugHighlightedImage forState:UIControlStateHighlighted];
    
    //Add selectors
    [bugReportButton addTarget:bugReportButton action:@selector(_wasDragged:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [bugReportButton addTarget:bugReportButton action:@selector(_reportBug:) forControlEvents:UIControlEventTouchUpInside];
    [bugReportButton addTarget:bugReportButton action:@selector(_buttonTouched:) forControlEvents:UIControlEventTouchDown];
    [bugReportButton addTarget:bugReportButton action:@selector(_buttonTouchEnded:) forControlEvents:UIControlEventTouchCancel];
    
    return bugReportButton;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    self.isBeingDragged = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.isBeingDragged) {
        self.isBeingDragged = NO;
        [self touchesCancelled:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

- (void)_buttonTouched:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UIImage *bugButtonImage = [UIImage imageNamed:@"BugSelected"];
    CGRect buttonFrame = button.frame;
    buttonFrame.size = bugButtonImage.size;
    button.frame = buttonFrame;
    [button setBackgroundImage:bugButtonImage forState:UIControlStateNormal];
}

- (void)_buttonTouchEnded:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UIImage *bugButtonImage = [UIImage imageNamed:@"Bug"];
    CGRect buttonFrame = button.frame;
    buttonFrame.size = bugButtonImage.size;
    button.frame = buttonFrame;
    [button setBackgroundImage:bugButtonImage forState:UIControlStateNormal];
}

- (void)_wasDragged:(UIButton *)button withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForView:button] anyObject];
    BugButton *bugButton = (BugButton *)button;
    
	// get delta
	CGPoint previousLocation = [touch previousLocationInView:button];
	CGPoint location = [touch locationInView:button];
	CGFloat delta_x = location.x - previousLocation.x;
	CGFloat delta_y = location.y - previousLocation.y;
    
    CGFloat newLocationX = button.center.x + delta_x;
    CGFloat newLocationY = button.center.y + delta_y;
    
    if (newLocationX < bugButton.minX) {
        newLocationX = bugButton.minX;
    } else if (newLocationX > bugButton.maxX) {
        newLocationX = bugButton.maxX;
    }
    
    if (newLocationY < bugButton.minY) {
        newLocationY = bugButton.minY;
    } else if (newLocationY > bugButton.maxY) {
        newLocationY = bugButton.maxY;
    }
    
	// move button
	button.center = CGPointMake(newLocationX, newLocationY);
}

- (void)_reportBug:(BugButton *)sender
{
    UIImage *bugButtonImage = [UIImage imageNamed:@"Bug"];
    CGRect buttonFrame = sender.frame;
    buttonFrame.size = bugButtonImage.size;
    sender.frame = buttonFrame;
    [sender setBackgroundImage:bugButtonImage forState:UIControlStateNormal];
    [self.delegate reportBug:self];
}

- (NSData *)getScreenshot
{
    CGSize size =  [[UIScreen mainScreen] bounds].size;
    
    UIGraphicsBeginImageContext(size);
    [[UIApplication sharedApplication].delegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return UIImageJPEGRepresentation(newImage, 0.5);
}

- (NSString *)bugReportString
{
    NSString *baseString = @"Thanks for filing a bug!\n\nSummary:\n\nSteps to reproduce:\n\nExpected results:\n\nActual results:\n\n";

    UIDevice *device = [UIDevice currentDevice];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm:ss aa";
    NSString *deviceInfo = [NSString stringWithFormat:@"%@ %@\n%@\n%@", device.systemName, device.systemVersion, [self _appVersionNumber],[dateFormatter stringFromDate:[NSDate date]]];
    
    return [NSString stringWithFormat:@"%@\n%@", baseString, deviceInfo];
}

- (NSString *)_appVersionNumber
{
    return [NSString stringWithFormat:@"Version: %@", [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]];
}

@end
