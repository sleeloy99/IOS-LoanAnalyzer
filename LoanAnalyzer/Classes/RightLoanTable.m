//
//  RightLoanTable.m
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "RightLoanTable.h"
#import "ModelObject.h"
#import "MaintTableCell.h"

@implementation RightLoanTable

@synthesize loans, tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loans = [ModelObject instance].loans;
}

- (void)loadView{
    [super loadView];
    float screenHeight = [[UIScreen mainScreen] bounds].size.width;
    float midPoint = screenHeight / 2;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, midPoint, 315)];
    NSString *path=[[NSBundle mainBundle] pathForResource: @"LoanAnalyzerBkg" ofType:@"png"];
    UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
    imageView.image = image;
    [image release];
    [self.view addSubview: imageView];
    [imageView release];
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, midPoint, 315) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.opaque = YES;
    [self.view addSubview: self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return [self.loans count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.0f;
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    static NSString *RootViewControllerCell = @"RootViewControllerCell";
    
    MaintTableCell *cell = ((MaintTableCell *)[self.tableView dequeueReusableCellWithIdentifier:RootViewControllerCell]);
    if (cell == nil){
        cell = [[[MaintTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: RootViewControllerCell] autorelease];
    }
    LoanObject *row = [self.loans objectAtIndex:[indexPath row]];
    cell.nameLabel.text = row.name;
    cell.amortizationLabel.text = [row.amortization displayStringShort];
    cell.loanAmtLabel.text = [NSString stringWithFormat: @"%@ @ %@", [row.loanAmount displayString] ,[row.interestRate displayString]];
    cell.paymentAmtLabel.text =  [NSString stringWithFormat: @"%@/%@", [row.paymentAmount displayString], [row.paymentFreq displayString]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    [self showTable];
    [rightLoanController setData: [self.loans objectAtIndex:[indexPath row]]];
}

- (void) showTable{
    if (rightLoanController == nil){
        rightLoanController = [[RightLoanController alloc] initWithNibName:@"CompareRightView" bundle:nil];
        
        [self.view addSubview: rightLoanController.view];
    }
    
    CGRect frame =  CGRectMake(0, 0,  rightLoanController.view.bounds.size.width, rightLoanController.view.bounds.size.height);
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    rightLoanController.view.frame = frame;
    [UIView commitAnimations];
}

- (void)dealloc {
    [self.loans release];
    [self.tableView release];
    if (rightLoanController != nil)
        [rightLoanController release];		
    [super dealloc];
}

@end

