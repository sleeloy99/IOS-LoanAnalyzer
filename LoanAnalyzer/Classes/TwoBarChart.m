//
//  TwoBarChart.m
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "TwoBarChart.h"


@implementation TwoBarChart

@synthesize sequence;

- (id)init{
    if (self = [super init]){
        numOfYIncrements = 5;
        minY = 0;
        minX = 0;
        maxY = 0;
        maxX = 0;
        coordMinY = 0;
        coordMinX = 0;
        coordMaxY = 0;
        coordMaxX = 0;
        
        xLabelGenerator = [[XAxisLabelGenerator alloc] init];
        
    }
    return self;
}

-(void) initialize{
    [super initialize];
    [xLabelGenerator initialize: self];
}

- (void)dealloc {
    [sequence release];
    [super dealloc];
}

@end
