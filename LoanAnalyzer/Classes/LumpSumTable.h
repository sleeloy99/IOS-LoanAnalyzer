//
//  LumpSumTable.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/27/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LumpSumTableViewCell.h"
#import "PaymentFreqObj.h"
#import "LumpSumDetailTable.h"
#import "TableProtocols.h"

@interface LumpSumTable : UIViewController <SlideItemTable, UITableViewDelegate, UITableViewDataSource> {
	id <SimpleTableController>  delegate;		
	UITableView *tableView;
	LumpSumDetailTable *lumpSumDetailController;
	UINavigationItem *parentNavigationItem;	
	UIBarButtonItem *oldLeftBarButton, *oldRightBarButton;
	UIButton *editButton;
	NSMutableArray *lumpSums;
	BOOL readOnly;
	CGRect viewFrame;
}
- (id)initWithFrame: (CGRect)frame readOnlyVal:(BOOL)readOnlyVal;
- (void)shouldHideEdit;

@property (nonatomic, assign) id <SimpleTableController>  delegate;
@property (nonatomic, assign) UITableView *tableView;
@property (nonatomic, assign) UIButton *editButton;
@property (nonatomic, retain) NSMutableArray *lumpSums;
@property BOOL readOnly;

@end
