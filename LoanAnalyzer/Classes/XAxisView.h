//
//  XAxisView.h
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"

@interface XAxisView : UIView {
	ChartModel *chartModel; 
}
- (id)initWithFrameChart:(CGRect)frame chart:(ChartModel *)chart;
- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@property(nonatomic, retain) ChartModel *chartModel;
@end
