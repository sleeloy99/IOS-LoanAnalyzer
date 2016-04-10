//
//  UIHorizontalView.m
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/24/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "UIHorizontalView.h"
#import "ScheduleModel.h"


@implementation UIHorizontalView

@synthesize detailController;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		isListMove = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect: rect];
}

- (void)dealloc {
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint newTouchPosition = [touch locationInView: self];
	
	if (gestureStartPoint.x != newTouchPosition.x || gestureStartPoint.y != newTouchPosition.y){
		isListMove = NO;
	}
	
	if ([touch tapCount] ==2)
		[detailController doubleTap];

	gestureStartPoint = [touch locationInView: self];
	gestureMovePoint = gestureStartPoint;
	[super touchesBegan: touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self];

	double diffx = gestureStartPoint.x - currentTouchPosition.x + 0.1;
	double diffy = gestureStartPoint.y - currentTouchPosition.y + 0.1;
	if (fabs(diffx/diffy) > 1 && fabs(diffx) > HORIZ_SWIPE_DRAG_MIN){
		if (isListMove){
			return;
		}
		
		if (gestureStartPoint.x < currentTouchPosition.x){
			isListMove = YES;
			if ([[ScheduleModel instance] canMoveLeft])
				[detailController swipeLeft: nil];
			return;
		}
		else{
			isListMove = YES;
			if ([[ScheduleModel instance] canMoveRight])
				[detailController swipeRight: nil];
			return;
		}
	}
	else if (fabs(diffy/diffx) > 1){
		isListMove = YES;
		[super touchesMoved: touches withEvent:event];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	isListMove = NO;
	[super touchesEnded: touches withEvent: event];
}

@end
