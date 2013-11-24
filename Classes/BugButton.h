//
//  BugButton.h
//  Thirstie
//
//  Created by Mason Silber on 11/23/13.
//  Copyright (c) 2013 Digital-Liquor-Delivery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BugButton;

@protocol BugButtonDelegate
- (void)reportBug:(BugButton *)sender;
@end

@interface BugButton : UIButton

@property (nonatomic, weak) id<BugButtonDelegate> delegate;
//These are used to set the bounds where the bug button can be dragged
@property (nonatomic) CGFloat minX, maxX, minY, maxY;

+ (instancetype)bugButton;
- (NSData *)getScreenshot;
- (NSString *)bugReportString;

@end
