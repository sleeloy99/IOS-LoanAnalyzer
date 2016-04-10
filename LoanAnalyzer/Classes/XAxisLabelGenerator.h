//
//  XAxisLabelGenerator.h
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LabelGenerator.h"
#import "ScheduleElement.h"

@interface XAxisLabelGenerator : NSObject<ILabelGenerator> {

	NSMutableArray *labels;
}

@end
