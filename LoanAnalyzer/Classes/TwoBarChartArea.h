//
//  XAxisView.h
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoBarChart.h"
#import "ScheduleElement.h"

@interface TwoBarChartArea : UIView {
	TwoBarChart *chartModel; 
	int numOfBars;
}
- (id)initWithFrameChart:(CGRect)frame chart:(TwoBarChart *)chart;

@property(nonatomic, retain) TwoBarChart *chartModel;
@end
