//
//  UIHoldDownButton.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/2/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "UIHoldDownButton.h"


@implementation UIHoldDownButton
@synthesize notificationName, notificationNameTap;

- (id)initWithFrameNotification:(CGRect)frame notificationStr: (NSString *)notificationStr notificationNameTapStr:(NSString *)notificationNameTapStr {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		notificationName = notificationStr;
		notificationNameTap = notificationNameTapStr;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc {
    if (_timer != nil){
		[_timer release];
    }
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if (_timer != nil){
			[_timer release];
	}
	[self setHighlighted: YES];
	_timer = [[NSTimer scheduledTimerWithTimeInterval: 1 target:self selector: @selector(doSomething:) userInfo:nil repeats:NO] retain];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if ([_timer isValid]){
		[_timer invalidate];
		[super touchesMoved:touches withEvent:event];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName: @"continousEnd" object: self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	[self setHighlighted: NO];
	if ([_timer isValid]){
		[_timer invalidate];
		[[NSNotificationCenter defaultCenter] postNotificationName: notificationNameTap object: self];
		[super touchesEnded:touches withEvent:event];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName: @"continousEnd" object: self];	
}

- (void)doSomething:(NSTimer *)theTimer{
    if ([_timer isValid]){
		[_timer invalidate];
    }
	[[NSNotificationCenter defaultCenter] postNotificationName: notificationName object: self];
}

@end
