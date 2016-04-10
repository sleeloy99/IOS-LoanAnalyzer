//
//  XAxisView.m
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "YAxisView.h"

@implementation YAxisView

@synthesize chartModel, axisWidth;

- (id)initWithFrameChart:(CGRect)frame chart:(ChartModel *)chart axisWidthVal: (float) axisWidthVal {
    if (self = [super initWithFrame:frame]){
        self.chartModel = chart;
        axisWidth = axisWidthVal;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    float tickerWidth = 10;
    float lblWidth = 30;
    float lblHeight = 20;
    float xCoord = axisWidth-3;
    
    //draw main line
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
    CGContextMoveToPoint(context, xCoord, 0);
    CGContextAddLineToPoint(context, xCoord, self.frame.size.height);
    CGContextStrokePath(context);
    
    NSMutableArray *increments = [self.chartModel getYIncrements];
    NSMutableArray *incrementsLbls = [self.chartModel getYIncrementsLbls];
    
    for (int x = 0; x< [increments count]; x++){
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
        
        NSNumber* value  = [increments objectAtIndex: x] ;
        float coord = [self.chartModel getY: [value floatValue] ];
        CGContextMoveToPoint(context, xCoord, coord);
        CGContextAddLineToPoint(context, xCoord-tickerWidth, coord);
        CGContextStrokePath(context);
        
        UILabel *tickLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:9.0 bold:NO];
        tickLbl.frame = CGRectMake(xCoord-tickerWidth-3-lblWidth, coord-(lblHeight/2), lblWidth, lblHeight);
        tickLbl.text = [incrementsLbls objectAtIndex: x];
        tickLbl.textAlignment = NSTextAlignmentRight;
        [self addSubview: tickLbl];
        [tickLbl release];
        
        //draw gradients
        CGFloat dash[] = {5.0, 5.0};
        CGContextSetRGBStrokeColor(context, .6, .6, .6, 1.0);
        
        CGContextSetLineDash(context, 0.0, dash, 2);
        CGContextMoveToPoint(context, axisWidth, coord);
        CGContextAddLineToPoint(context, self.frame.size.width, coord);
        CGContextStrokePath(context);
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
