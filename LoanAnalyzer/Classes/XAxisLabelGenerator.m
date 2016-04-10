//
//  XAxisLabelGenerator.m
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "XAxisLabelGenerator.h"
#import "TwoBarChart.h"


@implementation XAxisLabelGenerator


- (id)init{
    if (self = [super init]){
    }
    return self;
}

- (void) initialize: (id)chartModel{
    TwoBarChart *twoChartModel = (TwoBarChart *)chartModel;
    if (labels != nil){
        [labels release];
    }
    labels = [[NSMutableArray alloc] init];
    int count =0;
    int sampleRate = 1;
    if (twoChartModel.maxX > 12){
        double fsampleRate;
        double fractpart = modf((twoChartModel.maxX/6), &fsampleRate);
        sampleRate = (int)fsampleRate;
        if (fractpart > 0 ){
            sampleRate++;
        }
    }
    
    int countSample = 0;
    for (int x = 0; x< [twoChartModel.sequence count]; x++){
        NSMutableArray *subseq = (NSMutableArray *)[twoChartModel.sequence objectAtIndex: x];
        for (int y = 0; y< [subseq count]; y++){
            if (countSample == 0){
                ScheduleElement *elem = (ScheduleElement *)[subseq objectAtIndex: y];
                [labels addObject: [elem getShortDateDisplay]];
                countSample = sampleRate;
            }
            count++;
            countSample--;
        }
        
    }	
}

- (NSMutableArray *) getLabels{
    return labels;
}

- (void)dealloc {
    [labels release];
    [super dealloc];
}

@end
