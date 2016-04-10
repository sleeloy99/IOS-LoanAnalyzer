//
//  RightLoanTable.h
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightLoanController.h"

@interface RightLoanTable :  UIViewController <UITableViewDelegate, UITableViewDataSource> {
	RightLoanController *rightLoanController;
	NSMutableArray *loans;
	UITableView *tableView;
	
}

- (void) showTable;
@property (nonatomic, retain) NSMutableArray *loans;	
@property (nonatomic, retain) UITableView *tableView;

@end
