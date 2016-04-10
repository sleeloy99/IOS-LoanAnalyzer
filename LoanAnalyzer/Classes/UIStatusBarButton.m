//
//  UIStatusBarButton.m
//  
//
//  Created by Sheldon Lee-Loy on 2/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "UIStatusBarButton.h"


@implementation UIStatusBarButton

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
		[self.titleLabel setFont: [UIFont boldSystemFontOfSize: 12.0f]];
   }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();	
	
	//status bar
	CGRect currentFrame = self.frame;
	CGPoint topCenter;
	CGPoint midCenter;
	CGGradientRef glossGradient;
	CGColorSpaceRef rgbColorspace;
	size_t num_location = 2;	
	//content section
	CGFloat contentLocations[2] = {0.0 , 1.0};
	CGFloat components[8] = {.926, .957, .965, 1, 
	.738, .77, .785, 1};
	
	rgbColorspace = CGColorSpaceCreateDeviceRGB();
	glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, contentLocations, num_location);
	
	topCenter = CGPointMake(CGRectGetMidX(currentFrame), 0);
	midCenter = CGPointMake(CGRectGetMidX(currentFrame), currentFrame.size.height);
	CGContextDrawLinearGradient(context, glossGradient, topCenter, midCenter, 0);
	
	CGGradientRelease(glossGradient);
	CGColorSpaceRelease(rgbColorspace);	
	
	CGContextSetLineWidth(context, 1.0);	
	CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
	CGContextMoveToPoint(context, 0.0f, 0.0f);
	CGContextAddLineToPoint(context, currentFrame.size.width,  0.0f );
	CGContextStrokePath(context);
	
	CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
	CGContextMoveToPoint(context, 0.0f, 1.0f);
	CGContextAddLineToPoint(context, currentFrame.size.width,  1.0f);
	CGContextStrokePath(context);	
	
	CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
	CGContextMoveToPoint(context, 0.0f, currentFrame.size.height);
	CGContextAddLineToPoint(context, currentFrame.size.width,  currentFrame.size.height);
	CGContextStrokePath(context);	
	
	[super drawRect:rect];
}
@end
