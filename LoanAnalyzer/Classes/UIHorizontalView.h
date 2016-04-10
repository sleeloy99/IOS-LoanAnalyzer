//
//  UIHorizontalView.h
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/24/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISwipeHorizontally.h"

#define HORIZ_SWIPE_DRAG_MIN 100

@interface UIHorizontalView : UITableView {
	CGPoint gestureStartPoint;
	CGPoint gestureMovePoint;
	id <UISwipeHorizontally>  detailController;
	BOOL isListMove;
}

@property (nonatomic, assign) id <UISwipeHorizontally> detailController;

@end
