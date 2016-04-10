//
//  StartDateTableViewCell.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentFreqObj.h"

@interface StartDateTableViewCell : UITableViewCell {
	UILabel *nameLabel, *valueLabel;
}

- (void)setData:(id<FormatObject>)prop ;
- (void)resetData;
- (void)resetData:(NSString*) name;
- (void)resetData:(NSString*) name prop:(id<FormatObject>)prop ;
- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *valueLabel;

@end
