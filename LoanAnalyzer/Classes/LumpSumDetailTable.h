//
//  LumpSumDetailTable.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentFreqObj.h"
#import "NumberKeyPadSliderController.h"
#import "TableProtocols.h"
#import "StartDateTableViewCell.h"
#import "DateViewController.h"
#import "LumpSumFrequencyViewController.h"


@interface LumpSumDetailTable :  UIViewController <SlideItemTable, UITableViewDelegate, UITableViewDataSource>  {
	id <SimpleTableController>  delegate;		
	UITableView *tableView;
	NumberSliderKeyPadViewController *lumpSumValueController;
	DateViewController *startDateController, *endDateController;
	LumpSumFrequencyViewController *lumpsumFreqPeriodController;
	PopupViewController *selectedDelegate;
	
	StartDateTableViewCell *cellValue;
	StartDateTableViewCell *cellStart;
	StartDateTableViewCell *cellEnd;
	StartDateTableViewCell *cellPeriod;
	UINavigationItem *parentNavigationItem;
	UIBarButtonItem *oldLeftBarButton, *oldRightBarButton;
	int lumpsumidx;
	BOOL isAdd;
	UIBarButtonItem *saveButton, *resetButton, *cancelButton;
	NSIndexPath *selectedIndex;	
}

-(id)initWithLumpsum:(int)idx add:(BOOL) add;
-(void) setControls: (int) idx;
@property (nonatomic, assign) id <SimpleTableController>  delegate;
@property (nonatomic, assign) UITableView *tableView;
@property (nonatomic, assign) NSIndexPath *selectedIndex;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, assign) UIBarButtonItem *saveButton, *resetButton, *cancelButton;

@end
