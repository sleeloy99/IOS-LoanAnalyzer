//
//  YAxisView.h
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"

@interface YAxisView : UIView {
	ChartModel *chartModel; 
	float axisWidth;
}
- (id)initWithFrameChart:(CGRect)frame chart:(ChartModel *)chart axisWidthVal:(float)axisWidthVal;
- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@property(nonatomic, retain) ChartModel *chartModel;
@property float axisWidth;
@end
