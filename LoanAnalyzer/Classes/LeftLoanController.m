//
//  LeftLoanController.m
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//
#import "LeftLoanController.h"

@implementation LeftLoanController

- (IBAction) hideTable: (id)sender{
    if (lumpSumTableController != nil){
        [self popController];
    }
    else{
        [[ModelObject instance] setLeftLoan: nil];
        CGRect frame =  CGRectMake(0-self.view.bounds.size.width, 0,  self.view.bounds.size.width, self.view.bounds.size.height);
        [self hideTableWithFrame: frame];
    }
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (rightObjectChanged:) name:@"rightObjectChanged" object:nil];
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float midPoint = screenWidth / 2;
    
    CGRect frame =  CGRectMake(0-midPoint, 0, midPoint, self.view.bounds.size.height);
    
    [self buildView:NSTextAlignmentLeft valueAlignment:NSTextAlignmentRight backImageStr:@"leftback" frame: frame];
}

- (void)setData:(LoanObject *)loanObject{
    [[ModelObject instance] setLeftLoan: loanObject];
    [super setData: loanObject];
    [self rightObjectChanged: nil];
    
}

- (void) rightObjectChanged: (NSNotification *) notification{
    LoanObject *right = [[ModelObject instance] getRightLoan];
    LoanObject *left = [[ModelObject instance] getLeftLoan];
    [self compareObjectChanged: right left: left];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [super dealloc];
}

@end
