//
//  RightLoanController.m
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "RightLoanController.h"
#import "LoanObject.h"

@implementation RightLoanController

- (IBAction) hideTable: (id)sender{
    if (lumpSumTableController != nil)
        [self popController];
    else{
        [[ModelObject instance] setRightLoan: nil];
        CGRect frame =  CGRectMake(self.view.bounds.size.width, 0,  self.view.bounds.size.width, self.view.bounds.size.height);
        [self hideTableWithFrame: frame];
    }
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView{
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (leftObjectChanged:) name:@"leftObjectChanged" object:nil];
    
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float midPoint = screenWidth / 2;
    
    CGRect frame =  CGRectMake(screenWidth+midPoint, 0, midPoint, self.view.bounds.size.height);
    
    [self buildView:NSTextAlignmentRight valueAlignment:NSTextAlignmentLeft backImageStr:@"rightback" frame: frame];
}

- (void)setData:(LoanObject *)loanObject{
    [[ModelObject instance] setRightLoan: loanObject];
    [super setData: loanObject];
    [self leftObjectChanged: nil];
}

- (void) leftObjectChanged: (NSNotification *) notification{
    LoanObject *left = [[ModelObject instance] getRightLoan];
    LoanObject *right = [[ModelObject instance] getLeftLoan];
    [self compareObjectChanged: right left: left];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [super dealloc];
}

@end
