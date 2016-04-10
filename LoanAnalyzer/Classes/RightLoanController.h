//
//  RightLoanController.h
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanController.h"

@interface RightLoanController : LoanController {
}
- (IBAction) hideTable: (id)sender;
- (void) leftObjectChanged: (NSNotification *) notification;

@end
