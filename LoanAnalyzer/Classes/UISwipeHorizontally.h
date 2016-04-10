//
//  UISwipeHorizontally.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/1/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UISwipeHorizontally
- (void)swipeLeft: (NSNotification *) notification;
- (void)swipeRight: (NSNotification *) notification;
- (void)swipe: (double) offset;
- (void)doubleTap;
@end
