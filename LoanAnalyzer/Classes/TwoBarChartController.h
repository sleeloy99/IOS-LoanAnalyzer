//
//  ChartAppViewController.h
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "YAxisView.h"
#include "XAxisView.h"
#include "TwoBarChart.h"
#include "TwoBarChartArea.h"
#include "RoundRectView.h"

@interface TwoBarChartController : UIViewController {
    YAxisView *yaxis;
    XAxisView *xaxis;
    TwoBarChartArea *chartArea;
    TwoBarChart *chartObj;
    UIImageView *imageView, *headerView;
}

-(void) layoutChart:(CGRect) frame;
@property(nonatomic, retain) TwoBarChart *chartObj;
- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@end

