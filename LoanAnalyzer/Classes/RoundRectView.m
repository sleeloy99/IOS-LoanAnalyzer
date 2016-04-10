//
//  RoundRectView.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 4/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "RoundRectView.h"

@implementation RoundRectView

- (id)initWithFrameColor:(CGRect)frame red:(CGFloat) red green:(CGFloat) green blue:(CGFloat)blue alpha:(CGFloat) alpha{
    if (self = [super initWithFrame:frame]) {
        r = red;
        g = green;
        b = blue;
        a = alpha;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBFillColor(context, r, g, b, a);
    CGContextSetLineWidth(context, 3.0);
    
    // If you were making this as a routine, you would probably accept a rectangle
    // that defines its bounds, and a radius reflecting the "rounded-ness" of the rectangle.
    CGRect rrect = self.frame;
    rrect.origin.x = 0;
    rrect.origin.y = 0;
    CGFloat radius = 2.0;
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    
    CGContextMoveToPoint(context, minx, midy);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    // Close the path
    CGContextClosePath(context);
    // Fill & stroke the path
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, minx, midy);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    // Close the path
    CGContextClosePath(context);	
    CGContextStrokePath(context);
}

- (void)dealloc {
    [super dealloc];
}

@end
