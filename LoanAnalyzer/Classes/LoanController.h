//
//  LoanController.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/26/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanObject.h"
#import "ModelObject.h"
#import "TableProtocols.h"
#import "LumpSumTable.h"

@interface LoanController : UIViewController<SimpleTableController> {
	UIImageView *imgView, *principalArrow, *paymentAmtArrow, *interestRateArrow, *amoritizationArrow, *interestAmtArrow;
	UILabel *titleLabel, *principlaAmtLbl, *principalDiff, *interestAmtLbl, *interestRateLbl, *interestRateDiff, *interestAmtDiff, *paymentAmtLbl, *paymentAmtDiff, *amoritizationLbl, *amoritizationDiff;
	UIButton *backButton, *lumpButton;
	UIImageView *arrordecorator;
	UIImageView *llineView;
	LumpSumTable *lumpSumTableController;	
	LoanObject *loanObj;
	UIView *detailView;
	BOOL isLeft;
}
- (void)buildView: (NSTextAlignment) lblAlignment valueAlignment: (NSTextAlignment) valueAlignment backImageStr: (NSString *) backImageStr frame: (CGRect) frame;
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
- (void)setData:(LoanObject *)loanObject;
- (void) hideTableWithFrame: (CGRect)frame;
- (void) compareObjectChanged: (LoanObject *) right left: (LoanObject *) left;
@end
