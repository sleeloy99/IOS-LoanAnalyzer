//
//  LeftLoanTable.h
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  CopyLeft 2009 cellinova inc. All Lefts reserved.
//

#import <UIKit/UIKit.h>
#import "LeftLoanController.h"
#import "LoanAnalyzerAppDelegate.h"
#import "UIPieChartViewController.h"

@interface LeftLoanTable :   UIViewController <UITableViewDelegate, UITableViewDataSource> {
	LeftLoanController *leftLoanController;
	UIPieChartViewController *selectedLoanViewController;	
	NSMutableArray *loans;
	UIImageView *imageView;
	UITableView *tableView;
	UIDeviceOrientation interfaceOrientationVar;
	UIImageView *imgView;
}

-(void) releaseTable;
- (void) showTable;
@property (nonatomic, retain) NSMutableArray *loans;	
@property (nonatomic, retain) UIImageView *imageView;	
@property (nonatomic, retain) UITableView *tableView;	
@property UIDeviceOrientation interfaceOrientationVar;

-(IBAction) addAction:(id)sender;
@end
