//
//  UIPieChartViewController.h
//  
//
//  Created by Sheldon Lee-Loy on 2/10/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPieChartView.h"
#import "ModelObject.h"
#import "Property.h"
#import "PropertyTableViewCell.h"
#import "UIGradientView.h"
#import "NumberSliderKeyPadViewController.h"
#import "PercentKeyPadViewController.h"
#import "PaymentFreqKeyPadViewController.h"
#import "AmortizationKeyPadViewController.h"
#import "ScheduleViewViewController.h"
#import "EditablePropertyTableViewCell.h"
#import "NumberKeyPadSliderController.h"
#import "LumpSumTableCellView.h"
#import "LumpSumTable.h"
#import "StartDateTableViewCell.h"
#import "DateViewController.h"
#import "StackStructure.h"
#import "TableProtocols.h"

@interface UIPieChartViewController : UIViewController<SlideItemTable, SimpleTableController, UITableViewDelegate, UITableViewDataSource, UIToggleLockPressed, UITextFieldDelegate> {
	NumberSliderKeyPadViewController *loanAmountController;
	PercentKeyPadViewController *interestRateController;
	PaymentFreqKeyPadViewController *paymentFreqController;
	AmortizationKeyPadViewController *amortizationController;
	NumberKeyPadSliderController *paymentAmountController;
	ScheduleViewViewController *scheduleController;
	LumpSumTable *lumpSumTableController;
	DateViewController *startDateController;
	
	IBOutlet UILabel *interestAmtLbl;
	IBOutlet UILabel *principalAmtLbl;
	UILabel *diffprincipalAmtLbl, *diffinterestAmtLbl;
	IBOutlet UIPieChartView *pieChartView;
	IBOutlet UIImageView *detailView;
	UIImageView *iarrowDown, *parrowDown, *iarrowUp, *parrowUp;
	IBOutlet UIView *selectedView;
	UIBarButtonItem *saveButton, *resetButton, *listButton, *backButton, *cancelButton;
	UIBarButtonItem *oldLeftBarButtonItem, *oldRightBarButtonItem;

	PopupViewController *selectedDelegate;
	UITableView *mainTableView;
	BOOL isLoaded;
	BOOL isAdd;
	BOOL frequencyChanged;
	NSIndexPath *selectedIndex;
	
	//UI References
	LumpSumTableCellView *cellLumpSum;
	PropertyTableViewCell *cellAmortization;
	PropertyTableViewCell *cellLoanAmount;
	PropertyTableViewCell *cellInterestRate;
	PropertyTableViewCell *cellPaymentAmt;	
	StartDateTableViewCell *cellStartdate;
	EditablePropertyTableViewCell *cellName;
	StackStructure *viewStack;
}

- (void) toggleView;
- (void) updateChart: (float) rate;
- (void) closeSelectedView;
- (IBAction) cancel: (id)sender;
- (IBAction) back: (id)sender;
- (IBAction) save: (id)sender;
- (IBAction) swapList: (id)sender;
- (IBAction) reset: (id)sender;
- (void) setControls;
-(void) slideDetailTableUp: (double) offset;
-(void) slideDetailTableDown: (double) offset;
	
@property (nonatomic, retain) IBOutlet UIPieChartView *pieChartView;
@property (nonatomic, retain) IBOutlet UIImageView *detailView;
@property (nonatomic, retain) IBOutlet UITableView *mainTableView;
@property (nonatomic, retain) IBOutlet UILabel *interestAmtLbl;
@property (nonatomic, retain) IBOutlet UILabel *principalAmtLbl;
@property (nonatomic, retain) NSIndexPath *selectedIndex;
@property BOOL isAdd;

@end
