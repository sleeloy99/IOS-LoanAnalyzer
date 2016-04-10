//
//  LeftLoanTable.m
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyleft 2009 cellinova inc. All lefts reserved.
//

#import "LeftLoanTable.h"
#import "LeftLoanController.h"
#import "ModelObject.h"
#import "MaintTableCell.h"

@implementation LeftLoanTable

@synthesize loans ,tableView , imageView, interfaceOrientationVar;

- (void)viewDidLoad {
    [super viewDidLoad];
    //set up selected loan view
    selectedLoanViewController = [[UIPieChartViewController alloc] initWithNibName:@"SecondView" bundle:[NSBundle mainBundle]];
    
    self.loans = [ModelObject instance].loans;
}

- (void)viewWillAppear: (BOOL)animated{
    [super viewWillAppear: animated];
    [self.tableView reloadData];
}

- (void)loadView{
    [super loadView];
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float navigationHeight = 64;
    float statusBarHeight = 0;
    
    imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 320, screenHeight-navigationHeight-statusBarHeight)];
    NSString *path=[[NSBundle mainBundle] pathForResource: @"LoanAnalyzerBkg" ofType:@"png"];
    UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
    self.imageView.image = image;
    [image release];
    [self.view addSubview: self.imageView];
    
    UILabel *loanAnalyzerLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, 300, 40) ];
    loanAnalyzerLbl.backgroundColor = [UIColor clearColor];
    loanAnalyzerLbl.textAlignment = NSTextAlignmentCenter;
    loanAnalyzerLbl.textColor = [UIColor whiteColor];
    loanAnalyzerLbl.text = @"Loan Analyzer";
    loanAnalyzerLbl.font = [UIFont italicSystemFontOfSize:30.0];
    [self.imageView  addSubview: loanAnalyzerLbl];
    
    UILabel *companyLbl = [[UILabel alloc] initWithFrame:CGRectMake(25, 210, 200, 40) ];
    companyLbl.backgroundColor = [UIColor clearColor];
    companyLbl.textAlignment = NSTextAlignmentCenter;
    companyLbl.textColor =  [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    companyLbl.text = @"www.cellinova.com";
    companyLbl.font = [UIFont italicSystemFontOfSize:14.0];
    [self.imageView  addSubview: companyLbl];
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 320, screenHeight-navigationHeight-statusBarHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = YES;
    self.tableView.backgroundView = nil;
    [self.view addSubview: self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
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
    UIInterfaceOrientation toOrientation = self.interfaceOrientationVar;
    
    if(UIInterfaceOrientationIsPortrait(toOrientation)){
        [[ModelObject instance] assingSelected: [self.loans objectAtIndex:[indexPath row]]];
        LoanAnalyzerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        selectedLoanViewController.isAdd = NO;
        [delegate.navController pushViewController:selectedLoanViewController animated:YES];
    }
    else{
        [self showTable];
        [leftLoanController setData: [self.loans objectAtIndex:[indexPath row]]];
    }
    
    [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
    
}

-(void) addAction:(id)sender{
    [[ModelObject instance] assignNew];
    LoanAnalyzerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    selectedLoanViewController.isAdd = YES;
    [delegate.navController pushViewController:selectedLoanViewController animated:YES];
    //make sure that we go to the detail view
    [selectedLoanViewController toggleView];
}

-(void) releaseTable{
    [leftLoanController.view removeFromSuperview];
    leftLoanController = nil;
}

- (void) showTable{
    
    if (leftLoanController == nil){
        leftLoanController = [[LeftLoanController alloc] initWithNibName:@"CompareLeftView" bundle:nil];
        
        [self.view addSubview: leftLoanController.view];
    }
    
    CGRect frame =  CGRectMake(0, 0,  leftLoanController.view.bounds.size.width, leftLoanController.view.bounds.size.height);
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    leftLoanController.view.frame = frame;
    [UIView commitAnimations];
}

-(void)tableView:(UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath{
    NSUInteger index = [indexPath row];
    [[ModelObject instance] deleteObjectAtIndex: (int)index];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //if no elements in the table then get out of editing mode
    if ([self.loans count] == 0){
        self.tableView.editing = NO;
    }
    //notify that a delete occured
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loanDeleted" object: self];
}

- (void)dealloc {
    [self.loans release];
    [self.imageView release];
    [self.tableView release];
    [imgView release];
    [selectedLoanViewController release];
    if (leftLoanController != nil)
        [leftLoanController release];
    [super dealloc];
}

@end

