//
//  TwoBarChart.h
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartModel.h"
#import "LabelGenerator.h"
#import "XAxisLabelGenerator.h"

@interface TwoBarChart : ChartModel {
	NSMutableArray *sequence;
}

@property (nonatomic, retain) 	NSMutableArray *sequence;

@end
