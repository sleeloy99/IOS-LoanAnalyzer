//
//  RootViewController.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "RootViewController.h"
#import "UIPieChartViewController.h"
#import "LoanAnalyzerAppDelegate.h"
#import "MaintTableCell.h"
#import "LeftLoanTable.h"
#import "MyNavigationController.h"

@implementation RootViewController
@synthesize loans, tableView;

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            );
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if(fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        self.navigationController.navigationBarHidden = YES;
    }
    else{
        if (rightLoanController != nil){
            [rightLoanController.view removeFromSuperview];
            rightLoanController = nil;
        }
        [leftLoanController releaseTable];
        if (view2 != nil){
            [view2 removeFromSuperview];
            view2 = nil;
        }
        self.navigationController.navigationBarHidden = NO;
    }
    leftLoanController.interfaceOrientationVar = self.interfaceOrientation;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    UIInterfaceOrientation toOrientation = interfaceOrientation;
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float navigationHeight = 64;
    
    if(toOrientation == UIInterfaceOrientationPortrait || toOrientation == UIInterfaceOrientationPortraitUpsideDown){
        view1.frame = CGRectMake(0, 0, 320, 430);
        leftLoanController.tableView.frame = CGRectMake(0, 0, 320, screenHeight-navigationHeight);
        leftLoanController.imageView.frame = CGRectMake(0, 0, 320, screenHeight-navigationHeight);
        
    }
    else{
        float midPoint = screenWidth/2;
        int offset = 0;
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            offset = 20;
        }
        if (view2 == nil){
            view2 = [[UIView alloc] initWithFrame:CGRectMake(midPoint, offset, midPoint, 315)];
            [self.view addSubview: view2];
        }
        rightLoanController = [[RightLoanTable alloc] initWithNibName:@"RightTableView" bundle:[NSBundle mainBundle]];
        rightLoanController.view.frame = CGRectMake(0, 0, midPoint, 315);
        [view2 addSubview: rightLoanController.view];
        
        view1.frame = CGRectMake(0, offset, midPoint, 315);
        
        leftLoanController.tableView.frame = CGRectMake(0, 0, midPoint, 315);
        leftLoanController.imageView.frame = CGRectMake(0, 0, midPoint, 315);
        
    }
}

- (void)viewWillAppear: (BOOL)animated{
    [super viewWillAppear: animated];
    [leftLoanController viewWillAppear: animated];
    [self addEditButton];
    [(MyNavigationController*)[self navigationController] setLandScapeOk: YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    self.title = @"Loans";
    self.loans = [ModelObject instance].loans;
    
    //set up navigation bar
    [self addEditButton];
    
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = plusButton;
    [plusButton release];
    
    //setup table view
    view1 = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 320, 410)];
    leftLoanController = [[LeftLoanTable alloc] initWithNibName:@"LeftTableView" bundle:[NSBundle mainBundle]];\
    leftLoanController.interfaceOrientationVar = self.interfaceOrientation;
    [view1 addSubview: leftLoanController.view];
    self.tableView = leftLoanController.tableView;
    [self.view addSubview: view1];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (loanDeleted:) name:@"loanDeleted" object:nil];
    
    [super viewDidLoad];
}

- (void) addEditButton{
    if (self.navigationItem.leftBarButtonItem == nil){
        if ([self.loans count] > 0){
            UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle: @"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEdit:)];
            self.navigationItem.leftBarButtonItem = editButton;
            [editButton release];
        }
    }
    else{
        //check to see if we have to remove the edit button
        if ([self.loans count] == 0){
            self.navigationItem.leftBarButtonItem = nil;
            //make sure that we have an add button
            if (self.navigationItem.rightBarButtonItem == nil){
                UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
                self.navigationItem.rightBarButtonItem = plusButton;
                [plusButton release];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

- (void)dealloc {
    [view1 release];
    [view2 release];
    [self.tableView release];
    [self.loans release];
    [[ModelObject instance] release];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [super dealloc];
}

- (IBAction) addAction:(id)sender{
    [leftLoanController addAction: sender];
}

- (IBAction) toggleEdit:(id)sender{
    if (self.tableView.editing){
        self.navigationItem.leftBarButtonItem.title = @"Edit";
        //if done add back edit button
        UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
        self.navigationItem.rightBarButtonItem = plusButton;
        [plusButton release];
    }
    else{
        self.navigationItem.leftBarButtonItem.title = @"Done";
        //if in edit mode then user should not add
        self.navigationItem.rightBarButtonItem = nil;
    }
    [self.tableView setEditing: !self.tableView.editing animated:YES];
}

- (void) loanDeleted: (NSNotification *) notification{
    [self addEditButton];
}

@end
