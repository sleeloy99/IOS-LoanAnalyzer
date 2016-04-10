//
//  ComparisonViewController.h
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright cellinova inc 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftLoanTable.h"
#import "RightLoanTable.h"

@interface ComparisonViewController : UIViewController {
	IBOutlet UIView *view1;
	IBOutlet UIView *view2;
	LeftLoanTable *leftLoanController;
	RightLoanTable *rightLoanController;
}

@property (nonatomic,retain) IBOutlet UIView *view1;
@property (nonatomic,retain) IBOutlet UIView *view2;
@end

