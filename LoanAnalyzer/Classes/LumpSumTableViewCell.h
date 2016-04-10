//
//  LumpSumTableViewCell.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/27/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentFreqObj.h"

@interface LumpSumTableViewCell : UITableViewCell {
	UILabel *dateLabel;
	UILabel *valueLabel;
	UILabel *freqLabel;
	BOOL isReadOnly;
	
}
- (void)setData: (LumpSum *) lumpsum;
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
- (id)initWithStyleRO:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier readOnly:(BOOL) readOnly;

@end
