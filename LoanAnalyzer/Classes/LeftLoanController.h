//
//  LeftLoanController.h
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanController.h"

@interface LeftLoanController : LoanController {
}
- (IBAction) hideTable: (id)sender;
- (void) rightObjectChanged: (NSNotification *) notification;

@end
