//
//  UIGradientView.m
//  
//
//  Created by Sheldon Lee-Loy on 2/14/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "UIGradientView.h"

@implementation UITwoModeGradientView
@synthesize minHeight, maxHeight;

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        maxHeight=250;
        minHeight=85;
    }
    return self;
}

- (void) displaySelectedView: (BOOL) show{
    
    CGRect rec = self.frame;
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    float windowHieght = screenHeight - 64.0f;
    
    if (show){
        rec.origin.y = windowHieght - minHeight;
    }
    else{
        rec.origin.y = windowHieght + minHeight;
    }
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    self.frame = CGRectMake(rec.origin.x, rec.origin.y, rec.size.width, rec.size.height);
    [UIView commitAnimations];	
}

@end
