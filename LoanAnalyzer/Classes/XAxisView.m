//
//  XAxisView.m
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "XAxisView.h"


@implementation XAxisView

@synthesize chartModel;

- (id)initWithFrameChart:(CGRect)frame chart:(ChartModel *)chart {
    if (self = [super initWithFrame:frame]){
        self.chartModel = chart;
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    float tickerWidth = 10;
    float lblWidth = 40;
    float lblHeight = 20;
    float yCoord = 3;
    
    //draw main line
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
    CGContextMoveToPoint(context, 0, yCoord);
    CGContextAddLineToPoint(context, self.frame.size.width, yCoord);
    CGContextStrokePath(context);
    
    NSMutableArray *increments = [self.chartModel getXIncrements];
    NSMutableArray *incrementsLbls = [self.chartModel getXIncrementsLbls];
    float width = [self.chartModel getX: [self.chartModel getXIncrementWidth]]/2;
    
    for (int x = 0; x< [increments count]; x++){
        NSNumber* value  = [increments objectAtIndex: x] ;
        float coord = [self.chartModel getX: [value floatValue] ]+width;
        
        CGContextMoveToPoint(context, coord, yCoord);
        CGContextAddLineToPoint(context, coord, yCoord+tickerWidth);
        CGContextStrokePath(context);
        
        UILabel *tickLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:9.0 bold:NO];
        tickLbl.frame = CGRectMake(coord-lblWidth/2, yCoord+tickerWidth, lblWidth, lblHeight);
        tickLbl.text = [incrementsLbls objectAtIndex: x];
        tickLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview: tickLbl];
        [tickLbl release];
    }
}

- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold{
    UIFont *font;
    if (bold){
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    else{
        font = [UIFont systemFontOfSize:fontSize];
    }
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    newLabel.backgroundColor = [UIColor clearColor];
    newLabel.opaque = YES;
    newLabel.textColor = primaryColor;
    newLabel.highlightedTextColor = selectedColor;
    newLabel.font = font;
    
    return newLabel;
}

- (void)dealloc {
    [chartModel release];
    [super dealloc];
}

@end
