//
//  RootViewController.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPieChartViewController.h"
#import "ModelObject.h"
#import "RightLoanTable.h"
#import "LeftLoanTable.h"


@interface RootViewController : UIViewController {
	NSMutableArray *loans;
	UITableView *tableView;
	UIView *view2, *view1;
	RightLoanTable *rightLoanController;
	LeftLoanTable *leftLoanController;
}

- (IBAction) toggleEdit:(id)sender;
- (IBAction) addAction:(id)sender;
- (void) addEditButton;
- (void) loanDeleted: (NSNotification *) notification;

@property (nonatomic, retain) NSMutableArray *loans;
@property (nonatomic, retain) UITableView *tableView;

@end
