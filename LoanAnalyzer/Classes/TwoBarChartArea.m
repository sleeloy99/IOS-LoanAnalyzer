//
//  XAxisView.m
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "TwoBarChartArea.h"

@implementation TwoBarChartArea

@synthesize chartModel;

- (id)initWithFrameChart:(CGRect)frame chart:(TwoBarChart *)chart {
    if (self = [super initWithFrame:frame]) {
        self.chartModel = chart;
        numOfBars = 24;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    float width = [self.chartModel getX: [self.chartModel getXIncrementWidth]]/4;
    
    int count =0;
    int sampleRate = 1;
    if (self.chartModel.maxX > numOfBars){
        double fsampleRate;
        double fractpart = modf(( self.chartModel.maxX/numOfBars), &fsampleRate);
        sampleRate = (int)fsampleRate;
        if (fractpart > 0 )
            sampleRate++;
        width = [self.chartModel getX: sampleRate]/4;
    }
    
    int countSample = 0;
    for (int x = 0; x< [self.chartModel.sequence count]; x++){
        NSMutableArray *subseq = (NSMutableArray *)[self.chartModel.sequence objectAtIndex: x];
        for (int y = 0; y< [subseq count]; y++){
            if (countSample == 0){
                CGContextSetRGBFillColor(context, 0.0, 0.8059, 0.9078, 1.0);
                ScheduleElement *elem = (ScheduleElement *)[subseq objectAtIndex: y];
                float value  = (float)[elem getPrincipalAmt];
                if (value < 0){
                    value = 0;
                }
                float coordX = [self.chartModel getX: count ];
                float coordY = [self.chartModel getY: value ];
                
                if (coordY< 0){
                    coordY = 0;
                }
                //first bar chart
                CGRect bar = CGRectMake(coordX+width/2, coordY, width, self.frame.size.height);
                CGContextFillRect(context, bar);
                
                //second bar
                CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
                value  = (float)[elem getBalanceAmt];
                if (value < 0)
                    value = 0;
                coordX = [self.chartModel getX: count ];
                coordY = [self.chartModel getY: value ];
                
                //first bar chart
                bar = CGRectMake(coordX+5*width/2, coordY, width, self.frame.size.height);
                CGContextFillRect(context, bar);
                countSample = sampleRate;				
            }
            count++;
            countSample--;
        }
        
    }
    
}

- (void)dealloc {
    [chartModel release];
    [super dealloc];
}


@end
