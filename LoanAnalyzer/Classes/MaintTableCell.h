//
//  MaintTableCell.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/11/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MaintTableCell : UITableViewCell {
	UILabel *nameLabel, *amortizationLabel, *loanAmtLabel, *paymentAmtLabel;
	UIImageView *rightDecorator;
}

-(UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold italic: (BOOL) italic;

@property (nonatomic, retain) UILabel *nameLabel, *amortizationLabel, *loanAmtLabel, *paymentAmtLabel;

@end
