//
//  UIHoldDownButton.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/2/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIHoldDownButton : UIButton {
	NSTimer *_timer;
	NSString *notificationName, *notificationNameTap;
}

- (void)doSomething:(NSTimer *)theTimer;
- (id)initWithFrameNotification:(CGRect)frame notificationStr: (NSString *)notificationStr notificationNameTapStr:(NSString *) notificationNameTapStr;

@property (nonatomic, retain) NSString *notificationName, *notificationNameTap;

@end
