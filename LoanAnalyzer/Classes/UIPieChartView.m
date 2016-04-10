//
//  UIPieChartView.m
//  
//
//  Created by Sheldon Lee-Loy on 2/10/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "UIPieChartView.h"
#import <math.h>

@implementation UIPieChartView

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        percent = 1;
        radius = 33;
        xOffset = 18;
        yOffset = 18;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    [self addRoundedRectToPath: context rect: CGRectMake(10, 10, 3000, 800) ovalWidth: 10 ovalHeight: 10];
    CGContextFillPath(context);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 0.0863, 0.3922, 0.6784, 1.0);
    [self addRoundedRectToPath: context rect: CGRectMake(10, 10, 3000, 800) ovalWidth: 10 ovalHeight: 10];
    CGContextStrokePath(context);
    
    // And draw with a blue fill color
    CGContextSetRGBFillColor(context, 0.0, 0.1059, 0.2078, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 4.0);
    
    // Fill rect convenience equivalent to AddEllipseInRect(); FillPath();
    CGContextFillEllipseInRect(context, CGRectMake(xOffset, yOffset, radius*2, radius*2));
    
    CGContextMoveToPoint(context, radius+xOffset, radius+yOffset);
    //CGContextAddLineToPoint(context, 155, 155);
    CGContextAddArc(context, radius+xOffset, radius+yOffset, radius, -M_PI/4, M_PI*2*percent -M_PI/4, false);
    CGContextClosePath(context);
    CGContextSetRGBFillColor(context, 0.0863, 0.3922, 0.6784, 1.0);
    CGContextFillPath(context);
}

-(void) addRoundedRectToPath: (CGContextRef) context rect:(CGRect) rect ovalWidth:(float) ovalWidth ovalHeight: (float) ovalHeight{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0){
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    
    fw = CGRectGetWidth(rect) / ovalWidth;
    
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 10);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 10);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 10);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 10);
    CGContextClosePath(context);
    
    CGContextRestoreGState(context);
}

- (void) setPercent: (float) percentAttr{
    percent = percentAttr;
}

- (void)dealloc {
    [super dealloc];
}

@end
