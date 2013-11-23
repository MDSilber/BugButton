//
//  BugButton.h
//  Thirstie
//
//  Created by Mason Silber on 9/21/13.
//  Copyright (c) 2013 Digital-Liquor-Delivery. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BugButtonDelegate
- (void)reportBug:(id)sender;
@end

@interface BugButton : UIButton
@property (nonatomic, weak) id<BugButtonDelegate> delegate;
@property (nonatomic) CGFloat minX, maxX, minY, maxY;
+(instancetype)bugButton;
-(NSData *)getScreenshot;
@end
