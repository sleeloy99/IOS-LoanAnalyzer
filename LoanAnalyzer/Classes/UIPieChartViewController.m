//
//  UIPieChartViewController.m
//  
//
//  Created by Sheldon Lee-Loy on 2/10/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "UIPieChartViewController.h"
#import "LoanAnalyzerAppDelegate.h"
#import "MyNavigationController.h"

@implementation UIPieChartViewController
@synthesize detailView, mainTableView;
@synthesize pieChartView, interestAmtLbl, principalAmtLbl;
@synthesize isAdd, selectedIndex;

- (NumberSliderKeyPadViewController*) getLoanAmountController{
    if (loanAmountController == nil){
        loanAmountController = [[NumberSliderKeyPadViewController alloc] initWithNibName:@"NumKeyPad" bundle:[NSBundle mainBundle] dollarObj: [ModelObject instance].selectedObject.loanAmount];
        loanAmountController.view.frame = CGRectMake(0, 420, 320, 360);
        [loanAmountController.btnStatusBar setTitle:  @"Loan Amount" forState:UIControlStateNormal];
        [self.detailView addSubview: loanAmountController.view];
    }
    return loanAmountController;
}

- (NumberKeyPadSliderController*) getPaymentAmountController{
    if (paymentAmountController == nil){
        paymentAmountController = [[NumberKeyPadSliderController alloc] initWithNibName:@"NumKeyPadSlider" bundle:[NSBundle mainBundle] dollarObj: [ModelObject instance].selectedObject.paymentAmount];
        paymentAmountController.view.frame = CGRectMake(0, 420, 320, 360);
        [paymentAmountController.btnStatusBar setTitle:  @"Payment Amt" forState:UIControlStateNormal];
        [self.detailView addSubview: paymentAmountController.view];
    }
    return paymentAmountController;
}

- (PercentKeyPadViewController*) getInterestRateController{
    if (interestRateController == nil){
        interestRateController = [[PercentKeyPadViewController alloc] initWithNibName:@"PercentKeyPad" bundle:[NSBundle mainBundle]];
        interestRateController.view.frame = CGRectMake(0, 420, 320, 360);
        [self.detailView addSubview: interestRateController.view];
    }
    return interestRateController;
}

- (PaymentFreqKeyPadViewController*) getPaymentFreqController{
    if (paymentFreqController == nil){
        paymentFreqController = [[PaymentFreqKeyPadViewController alloc] initWithNibName:@"PaymentFreqKeyPad" bundle:[NSBundle mainBundle]];
        paymentFreqController.view.frame = CGRectMake(0, 420, 320, 70);
        [self.detailView addSubview: paymentFreqController.view];
    }
    return paymentFreqController;
}

- (AmortizationKeyPadViewController*) getAmortizationController{
    
    if (amortizationController == nil){
        amortizationController = [[AmortizationKeyPadViewController alloc] initWithNibName:@"AmortizationKeyPad" bundle:[NSBundle mainBundle]];
        amortizationController.view.frame = CGRectMake(0, 420, 320, 110);
        [self.detailView addSubview: amortizationController.view];
    }
    return amortizationController;
}

- (DateViewController*) getStartDateController{
    if (startDateController == nil){
        startDateController = [[DateViewController alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
        startDateController.view.frame = CGRectMake(0, 420, 320, 236);
        [self.detailView addSubview: startDateController.view];
    }
    return startDateController;
}

- (UILabel*) getDiffprincipalAmtLbl{
    if (diffprincipalAmtLbl == nil){
        diffprincipalAmtLbl = [[UILabel alloc] initWithFrame:CGRectMake(165, 32, 120, 20) ];
        diffprincipalAmtLbl.backgroundColor = [UIColor clearColor];
        diffprincipalAmtLbl.textAlignment = NSTextAlignmentLeft;
        diffprincipalAmtLbl.textColor = [UIColor colorWithRed:0.0 green:0.1059 blue:0.2078 alpha:1.0];
        diffprincipalAmtLbl.font = [UIFont systemFontOfSize:10.0];
        [pieChartView addSubview: diffprincipalAmtLbl];
    }
    return diffprincipalAmtLbl;
}

- (UILabel*) getDiffinterestAmtLbl{
    if (diffinterestAmtLbl == nil){
        diffinterestAmtLbl = [[UILabel alloc] initWithFrame:CGRectMake(165, 64, 120, 20) ];
        diffinterestAmtLbl.backgroundColor = [UIColor clearColor];
        diffinterestAmtLbl.textAlignment = NSTextAlignmentLeft;
        diffinterestAmtLbl.textColor = [UIColor colorWithRed:0.0863	green:0.3922 blue:0.6784 alpha:1.0];
        diffinterestAmtLbl.font = [UIFont systemFontOfSize:10.0];
        [pieChartView addSubview: diffinterestAmtLbl];
    }
    return diffinterestAmtLbl;
}

- (UIImageView*) getParrowDown{
    if (parrowDown == nil){
        parrowDown = [[UIImageView alloc] init];
        parrowDown.frame = CGRectMake(280, 20, 12, 19);
        NSString *path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        parrowDown.image = image;
        parrowDown.hidden = YES;
        [image release];
        [pieChartView addSubview: parrowDown];
    }
    return parrowDown;
}

- (UIImageView*) getParrowUp{
    if (parrowUp == nil){
        parrowUp = [[UIImageView alloc] init];
        parrowUp.frame = CGRectMake(280, 20, 12, 19);
        NSString *path=[[NSBundle mainBundle] pathForResource: @"uparrow" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        parrowUp.image = image;
        parrowUp.hidden = YES;
        [image release];
        [pieChartView addSubview: parrowUp];
    }
    return parrowUp;
}

- (UIImageView*) getIarrowDown{
    if (iarrowDown == nil){
        iarrowDown = [[UIImageView alloc] init];
        iarrowDown.frame = CGRectMake(280, 52, 12, 19);
        NSString *path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        iarrowDown.image = image;
        iarrowDown.hidden = YES;
        [image release];
        [pieChartView addSubview: iarrowDown];
    }
    return iarrowDown;
}

- (UIImageView*) getIarrowUp{
    if (iarrowUp == nil){
        iarrowUp = [[UIImageView alloc] init];
        iarrowUp.frame = CGRectMake(280, 52, 12, 19);
        NSString *path=[[NSBundle mainBundle] pathForResource: @"uparrow" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        iarrowUp.image = image;
        iarrowUp.hidden = YES;
        [image release];
        [pieChartView addSubview: iarrowUp];
    }
    return iarrowUp;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    int navigationHeight = 44;
    int startusBarHeight = 20;
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    int offset = 0;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        CGRect origFrame = 	self.detailView.frame;
        offset = 20;
        CGRect frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+navigationHeight+offset, origFrame.size.width, screenHeight-offset-navigationHeight);
        self.detailView.frame = frame;
        origFrame = 	self.mainTableView.frame;
        frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-navigationHeight+startusBarHeight-offset, origFrame.size.width, origFrame.size.height);
        self.mainTableView.frame = frame;
    }
    
    NSString *path=[[NSBundle mainBundle] pathForResource: @"LoanAnalyzerBkg" ofType:@"png"];
    UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
    self.detailView.image = image;
    [image release];
    
    viewStack = [[StackStructure alloc] init];
    [viewStack push: self];
    
    UILabel *principalAmtLbll = [[UILabel alloc] initWithFrame:CGRectMake(60, 18, 100, 20) ];
    principalAmtLbll.backgroundColor = [UIColor clearColor];
    principalAmtLbll.textAlignment = NSTextAlignmentRight;
    principalAmtLbll.textColor = [UIColor colorWithRed:0.0 green:0.1059 blue:0.2078 alpha:1.0];
    principalAmtLbll.text = @"Principal";
    principalAmtLbll.font = [UIFont systemFontOfSize:12.0];
    [pieChartView addSubview: principalAmtLbll];
    [principalAmtLbll release];
    
    UILabel *interestAmtLbll = [[UILabel alloc] initWithFrame:CGRectMake(60, 50, 100, 20) ];
    interestAmtLbll.backgroundColor = [UIColor clearColor];
    interestAmtLbll.textAlignment = NSTextAlignmentRight;
    interestAmtLbll.textColor = [UIColor colorWithRed:0.0863	green:0.3922 blue:0.6784 alpha:1.0];
    interestAmtLbll.text = @"Interest";
    interestAmtLbll.font = [UIFont systemFontOfSize:12.0];
    [pieChartView addSubview: interestAmtLbll];
    [interestAmtLbll release];
    
    principalAmtLbl = [[UILabel alloc] initWithFrame:CGRectMake(165, 18, 120, 20) ];
    principalAmtLbl.backgroundColor = [UIColor clearColor];
    principalAmtLbl.textAlignment = NSTextAlignmentLeft;
    principalAmtLbl.textColor = [UIColor colorWithRed:0.0 green:0.1059 blue:0.2078 alpha:1.0];
    principalAmtLbl.font = [UIFont systemFontOfSize:16.0];
    [pieChartView addSubview: principalAmtLbl];
    [principalAmtLbl release];
    
    interestAmtLbl = [[UILabel alloc] initWithFrame:CGRectMake(165, 50, 120, 20) ];
    interestAmtLbl.backgroundColor = [UIColor clearColor];
    interestAmtLbl.textAlignment = NSTextAlignmentLeft;
    interestAmtLbl.textColor = [UIColor colorWithRed:0.0863	green:0.3922 blue:0.6784 alpha:1.0];
    interestAmtLbl.font = [UIFont systemFontOfSize:16.0];
    [pieChartView addSubview: interestAmtLbl];
    [interestAmtLbl release];
    
    pieChartView.backgroundColor = [UIColor clearColor];
    pieChartView.opaque = NO;
    
    [self.detailView bringSubviewToFront: pieChartView];
    
    selectedView = self.detailView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self closeSelectedView];
    if (self.selectedIndex != nil){
        [mainTableView deselectRowAtIndexPath: self.selectedIndex animated: YES];
        self.selectedIndex = nil;
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    cellName.clearBtn.hidden = YES;
    
    [self slideDetailTableDown: 200];
    [ModelObject instance].selectedObject.name = textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    cellName.clearBtn.hidden = NO;
    
    [self slideDetailTableUp: 200];
}

-(void) slideDetailTableUp: (double) offset{
    CGRect origFrame = mainTableView.frame;
    CGRect frame = CGRectMake(origFrame.origin.x, origFrame.origin.y-offset, origFrame.size.width, origFrame.size.height);
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.3f];
    mainTableView.frame = frame;
    [UIView commitAnimations];
}

-(void) slideDetailTableDown: (double) offset{
    CGRect origFrame = mainTableView.frame;
    CGRect frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+offset, origFrame.size.width, origFrame.size.height);
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.3f];
    mainTableView.frame = frame;
    [UIView commitAnimations];
}

- (void)viewWillAppear: (BOOL)animated{
    
    frequencyChanged = NO;
    self.navigationItem.title = [ModelObject instance].selectedObject.name;
    self.navigationItem.rightBarButtonItem = listButton;
    if (cellLoanAmount != nil){
        [cellLoanAmount resetData: @"Loan Amount" prop:[ModelObject instance].selectedObject.loanAmount];
        [cellInterestRate resetData: @"Interest Rate" prop:[ModelObject instance].selectedObject.interestRate prop2:[ModelObject instance].selectedObject.compoundPeriod];
        [cellAmortization resetData: @"Amortization" prop:[ModelObject instance].selectedObject.amortization];
        [cellPaymentAmt resetData: @"Payment Amt" prop:[ModelObject instance].selectedObject.paymentAmount prop2:[ModelObject instance].selectedObject.paymentFreq];
        [cellStartdate resetData: @"Start Date" prop:[ModelObject instance].selectedObject.startDate];
        cellName.editingTextField.text = [ModelObject instance].selectedObject.name;
        float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
        [self updateChart: rate];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (paymentAmtAndUpdateChartChanged:) name:@"paymentAmtAndUpdateChartChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (rateAndUpdateChartChanged:) name:@"rateAndUpdateChartChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (rateModelChanged:) name:@"rateChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (loanAmtModelChanged:) name:@"loanAmtChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (paymentAmtModelChanged:) name:@"paymentAmtChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (yearModelChanged:) name:@"yearChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (monthModelChanged:) name:@"monthChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (compoundPeriodModelChanged:) name:@"compoundPeriodChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (paymentFreqModelChanged:) name:@"paymentFreqChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (nameChanged:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (startdateChanged:) name:@"startdateChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (redrawChart:) name:@"redrawChart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (closingkeypad:) name:@"closingkeypad" object:nil];
    
    if (self.isAdd){
        self.navigationItem.rightBarButtonItem = saveButton;
        self.navigationItem.leftBarButtonItem = cancelButton;
    }
    else{
        self.navigationItem.rightBarButtonItem = listButton;
    }
    
    if (selectedView == scheduleController.view){
        [self swapList: nil];
        [(MyNavigationController*)[self navigationController] setLandScapeOk: YES];
    }
    else {
        [(MyNavigationController*)[self navigationController] setLandScapeOk: NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [self closeSelectedView];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [super viewWillDisappear: animated];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    cancelButton = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style: UIBarButtonItemStyleDone target:self action :@selector(cancel:)];
    listButton= [[UIBarButtonItem alloc] initWithTitle: @"Schedule" style: UIBarButtonItemStyleDone target:self action :@selector(swapList:)];
    backButton= [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStyleDone target:self action :@selector(back:)];
    resetButton= [[UIBarButtonItem alloc] initWithTitle: @"Reset" style: UIBarButtonItemStyleDone target:self action :@selector(reset:)];
    saveButton= [[UIBarButtonItem alloc] initWithTitle: @"Save" style: UIBarButtonItemStyleDone target:self action :@selector(save:)];
    
    float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    
    [self updateChart: rate];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (selectedView == scheduleController.view){
        return (interfaceOrientation == UIInterfaceOrientationPortrait ||
                interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
                interfaceOrientation == UIInterfaceOrientationLandscapeLeft
                );
    }
    return false;
}

- (BOOL)shouldAutorotate
{
    return (selectedView == scheduleController.view);
}

/* ios 6 rotation methods */
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    if (selectedView == scheduleController.view){
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if(fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        self.navigationController.navigationBarHidden = YES;
    }
    else{
        self.navigationController.navigationBarHidden = NO;
    }
}

-(void)animationDone:(NSString*) animationID finished:(NSNumber *)finished context:(void *)context{
    if (selectedView != detailView){
        [scheduleController resetView];
    }
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration{
    if (selectedView == scheduleController.view){
        [scheduleController willAnimateRotationToInterfaceOrientation: interfaceOrientation duration:duration];
    }
}

- (IBAction) swapList: (id)sender{
    /*	if (selectedView == detailView){
     LoanAnalyzerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
     }
     */
    if (selectedView == nil){
        selectedView = detailView;
    }
    [selectedView removeFromSuperview];
    if (selectedView == detailView){
        if (scheduleController == nil){
            scheduleController = [[ScheduleViewViewController alloc] initWithNibName:@"ScheduleViewViewController" bundle:[NSBundle mainBundle] ];
        }
        
        [self.view addSubview: scheduleController.view];
        selectedView = scheduleController.view;
        [(MyNavigationController *)[self navigationController] setLandScapeOk: YES];
        [scheduleController.progressIndicator startAnimating];
        [scheduleController.view bringSubviewToFront: scheduleController.progressIndicator];
        
        listButton.title = @"Details";
    }
    else{
        [self.view addSubview: detailView];
        selectedView = detailView;
        [(MyNavigationController *)[self navigationController] setLandScapeOk: NO];
        listButton.title = @"Schedule";
    }
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: 0.6];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector: @selector(animationDone:finished:context:)];
    
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView: self.view cache: YES];
    [UIView commitAnimations];
}

- (void) toggleView{
    if (selectedView != detailView){
        [self swapList: nil];
    }
}

- (IBAction) save: (id)sender{
    if (self.isAdd){
        [[ModelObject instance] persistLoan];
        //no longer in add mode
        self.isAdd = NO;
    }
    else{
        [[ModelObject instance] saveSelected];
    }
    [cellName.editingTextField resignFirstResponder];
    [cellLoanAmount resetData];
    [cellInterestRate resetData];
    [cellAmortization resetData];
    [cellPaymentAmt resetData];
    [cellStartdate resetData];
    //need update chart
    float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    [self updateChart: rate];
    
    [self closeSelectedView];
    
}

- (IBAction) cancel: (id)sender{
    [[ModelObject instance] cancelLoan];
    LoanAnalyzerAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navController popViewControllerAnimated: YES];
}

- (IBAction) back: (id)sender{
    [self popController];
}

- (IBAction) reset: (id)sender{
    [[ModelObject instance] resetSelected];
    [self setControls];
    [cellName.editingTextField resignFirstResponder];
    [self closeSelectedView];
    
}

- (void) setControls{
    [cellLoanAmount resetData: @"Loan Amount" prop:[ModelObject instance].selectedObject.loanAmount];
    [cellInterestRate resetData: @"Interest Rate" prop:[ModelObject instance].selectedObject.interestRate prop2:[ModelObject instance].selectedObject.compoundPeriod];
    [cellAmortization resetData: @"Amortization" prop:[ModelObject instance].selectedObject.amortization];
    [cellPaymentAmt resetData: @"Payment Amt" prop:[ModelObject instance].selectedObject.paymentAmount  prop2:[ModelObject instance].selectedObject.paymentFreq];
    [cellStartdate resetData: @"Start Date" prop:[ModelObject instance].selectedObject.startDate];
    cellName.editingTextField.text = [ModelObject instance].selectedObject.name;
    [self updateChart: [[ModelObject instance].selectedObject.interestRate getPercentValue]];
}

- (void) loanValueChanged{
    id <SlideItemTable> parentTableController = ( id <SlideItemTable>)[viewStack peek];
    
    if (parentTableController == self) {
        self.navigationItem.rightBarButtonItem = saveButton;
        self.navigationItem.leftBarButtonItem = resetButton;
    }
    //need to disable selection for lumpsum
}

- (void) closingkeypad: (NSNotification *) notification{
    if ((selectedDelegate != nil) && (selectedDelegate == startDateController))
        [self slideDetailTableDown: 236];
    selectedDelegate = nil;
    if (self.selectedIndex != nil){
        [mainTableView deselectRowAtIndexPath: self.selectedIndex animated: YES];
        self.selectedIndex = nil;
    }
    
}


- (void) rateModelChanged: (NSNotification *) notification
{
    //	if (selectedDelegate == interestRateController){
    //		float modelRate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    //		[[ModelObject instance].selectedObject calculatePaymentAmt];
    //		[self updateChart: modelRate];
    //	}
    [cellInterestRate setPropDiff: [ModelObject instance].selectedObject.interestRate orgin:[ModelObject instance].selectedOriginalObject.interestRate];
    [self loanValueChanged];
}

- (void) yearModelChanged: (NSNotification *) notification
{
    //	if (selectedDelegate == amortizationController){
    //		float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    //		[[ModelObject instance].selectedObject calculatePaymentAmt];
    //		[self updateChart: rate];
    //	}
    [cellAmortization setPropDiff:[ModelObject instance].selectedObject.amortization orgin:[ModelObject instance].selectedOriginalObject.amortization];
    [self loanValueChanged];
}

- (void) redrawChart: (NSNotification *) notification{
    float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    [self updateChart: rate];
}

- (void) nameChanged: (NSNotification *) notification{
    self.navigationItem.title = cellName.editingTextField.text;
    [ModelObject instance].selectedObject.name = cellName.editingTextField.text;
    [self loanValueChanged];
}

- (void) paymentAmtAndUpdateChartChanged:(NSNotification *) notification{
    [[ModelObject instance].selectedObject calculateAmortization];
    float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    [[ModelObject instance].selectedObject calculatePrincipalInterestAmt];
    [self updateChart: rate];
}

- (void) rateAndUpdateChartChanged:(NSNotification *) notification{
    float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    [[ModelObject instance].selectedObject calculatePaymentAmt];
    [[ModelObject instance].selectedObject calculatePrincipalInterestAmt];
    [self updateChart: rate];
}

- (void) monthModelChanged: (NSNotification *) notification
{
    //	if (selectedDelegate == amortizationController){
    //		float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    //		[[ModelObject instance].selectedObject calculatePaymentAmt];
    //		[self updateChart: rate];
    //	}
    [cellAmortization setPropDiff: [ModelObject instance].selectedObject.amortization orgin: [ModelObject instance].selectedOriginalObject.amortization];
    
    [self loanValueChanged];
}

- (void) paymentFreqModelChanged: (NSNotification *) notification
{
    if (selectedDelegate == paymentAmountController){
        frequencyChanged = YES;
        //		float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
        //		[[ModelObject instance].selectedObject calculatePaymentAmt];
        //need to update slider with new payment value
        paymentAmountController.minLimit = [[ModelObject instance].selectedObject.loanAmount getDollarValue]*[[ModelObject instance].selectedObject.ratePerPeriod getPercentValue]/100.0f ;
        paymentAmountController.maxLimit = [[ModelObject instance].selectedObject.loanAmount getDollarValue];
        [paymentAmountController setControls: [ModelObject instance].selectedObject.paymentAmount];
        
        //		[self updateChart: rate];
    }
    else{
        frequencyChanged = NO;
    }
    [cellPaymentAmt setSecondProp: [ModelObject instance].selectedObject.paymentFreq];
    [self loanValueChanged];
}

- (void) compoundPeriodModelChanged: (NSNotification *) notification{
    //	if (selectedDelegate == interestRateController){
    //		float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    //		[[ModelObject instance].selectedObject calculatePaymentAmt];
    //		[self updateChart: rate];
    //	}
    [cellInterestRate setSecondProp: [ModelObject instance].selectedObject.compoundPeriod];
    [self loanValueChanged];
}

- (void) loanAmtModelChanged: (NSNotification *) notification{
    
    //	if (selectedDelegate == loanAmountController){
    //		float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    //		[[ModelObject instance].selectedObject calculatePaymentAmt];
    //		[self updateChart: rate];
    //	}
    [cellLoanAmount setPropDiff: [ModelObject instance].selectedObject.loanAmount orgin:[ModelObject instance].selectedOriginalObject.loanAmount];
    [self loanValueChanged];
    
}

- (void) startdateChanged: (NSNotification *) notification{
    [cellStartdate setData: [ModelObject instance].selectedObject.startDate];
    [self loanValueChanged];
}


- (void) paymentAmtModelChanged: (NSNotification *) notification{
    if (selectedDelegate == paymentAmountController){
        //		if (![ModelObject instance].selectedObject.paymentAmount.loanAmtLock)
        //			[[ModelObject instance].selectedObject calculateLoanAmt];
        //		else
        //don't update if frequenceChanged
        //		if (!(frequencyChanged)){
        //			[[ModelObject instance].selectedObject calculateAmortization];
        //			float rate = [[ModelObject instance].selectedObject.interestRate getPercentValue];
        //			[self updateChart: rate];
        //		}
    }
    //reset flag
    frequencyChanged = NO;
    [cellPaymentAmt setPropDiff:[ModelObject instance].selectedObject.paymentAmount orgin:[ModelObject instance].selectedOriginalObject.paymentAmount];
    [self loanValueChanged];
}



- (void) updateChart: (float)rate{
    
    float interestPercent = [[ModelObject instance].selectedObject.interestAmt getDollarValue]/([[ModelObject instance].selectedObject.interestAmt getDollarValue]+[[ModelObject instance].selectedObject.loanAmount getDollarValue]);
    [pieChartView setPercent: interestPercent];
    [pieChartView setNeedsDisplay];
    
    //update label
    double diff = [[ModelObject instance].selectedObject.interestAmt getDiff: [ModelObject instance].selectedOriginalObject.interestAmt];
    if (diff > 0){
        [self getDiffinterestAmtLbl].textColor = [UIColor redColor];
        [self getIarrowDown].hidden = YES;
        [self getIarrowUp].hidden = NO;
    }
    else if (diff < 0){
        [self getDiffinterestAmtLbl].textColor = [UIColor greenColor];
        [self getIarrowDown].hidden = NO;
        [self getIarrowUp].hidden = YES;
    }
    else{
        if (iarrowUp != nil)
            [self getIarrowUp].hidden = YES;
        if (iarrowDown != nil)
            [self getIarrowDown].hidden = YES;
    }
    diffinterestAmtLbl.text = [[ModelObject instance].selectedObject.interestAmt displayDiffString: [ModelObject instance].selectedOriginalObject.interestAmt];
    
    diff = [[ModelObject instance].selectedObject.loanAmount getDiff: [ModelObject instance].selectedOriginalObject.loanAmount];
    if (diff > 0){
        [self getDiffprincipalAmtLbl].textColor = [UIColor redColor];
        [self getParrowDown].hidden = YES;
        [self getParrowUp].hidden = NO;
    }
    else if (diff < 0){
        [self getDiffprincipalAmtLbl].textColor = [UIColor greenColor];
        [self getParrowDown].hidden = NO;
        [self getParrowUp].hidden = YES;
    }
    else{
        if (parrowUp != nil)
            [self getParrowUp].hidden = YES;
        if (parrowDown != nil)
            [self getParrowDown].hidden = YES;
    }
    
    [self getDiffprincipalAmtLbl].text = [[ModelObject instance].selectedObject.loanAmount displayDiffString: [ModelObject instance].selectedOriginalObject.loanAmount];
    
    
    //format string
    interestAmtLbl.text = [[ModelObject instance].selectedObject.interestAmt displayString];
    principalAmtLbl.text = [[ModelObject instance].selectedObject.loanAmount displayString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) closeSelectedView{
    if (selectedDelegate != nil)
        [selectedDelegate displaySelectedView: NO];
    if (self.navigationItem.rightBarButtonItem != nil)
        self.navigationItem.rightBarButtonItem = listButton;
    if (self.navigationItem.leftBarButtonItem != nil){
        //check to see if we're in add mode
        //		if (self.isAdd)
        //			self.navigationItem.leftBarButtonItem = cancelButton;
        //		else
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [lumpSumTableController release];
    [paymentAmountController release];
    [loanAmountController release];
    [interestRateController release];
    [paymentFreqController release];
    [amortizationController release];
    [startDateController release];
    
    [listButton release];
    [resetButton release];
    [backButton release];
    [cancelButton release];
    [saveButton release];
    [pieChartView release];
    [interestAmtLbl release];
    [principalAmtLbl release];
    [mainTableView release];
    [selectedDelegate release];
    
    [cellName release];
    [cellLoanAmount release];
    [cellAmortization release];
    [cellInterestRate release];
    [cellLumpSum release];
    [cellPaymentAmt release];
    [cellStartdate release];
    
    [iarrowDown release];
    [parrowDown release];
    [iarrowUp release];
    [parrowUp release];
    
    [diffprincipalAmtLbl release];
    [diffinterestAmtLbl release];
    
    [viewStack release];
    
    if (scheduleController != nil){
        [scheduleController release];
    }
    if (self.selectedIndex != nil){
        [self.selectedIndex release];
    }
    
    [super dealloc];
}

-(void) toggleLockPressed: (id) sender{
    
    if (sender == cellLoanAmount.lock){
        if (!cellAmortization.lock.hidden){
            [cellAmortization setLockVal: !cellLoanAmount.isLock];
        }
        if (!cellPaymentAmt.lock.hidden){
            [cellPaymentAmt setLockVal: !cellLoanAmount.isLock];
        }
        if (selectedDelegate == amortizationController){
            [ModelObject instance].selectedObject.amortization.paymentAmtLock  = !cellLoanAmount.isLock;
        }
        else if (selectedDelegate == paymentAmountController){
            [ModelObject instance].selectedObject.paymentAmount.loanAmtLock  = cellLoanAmount.isLock;
        }
    }
    else if (sender == cellPaymentAmt.lock){
        if (!cellAmortization.lock.hidden){
            [cellAmortization setLockVal: !cellPaymentAmt.isLock];
        }
        if (!cellLoanAmount.lock.hidden){
            [cellLoanAmount setLockVal: !cellPaymentAmt.isLock];
        }
        if (selectedDelegate == loanAmountController){
            [ModelObject instance].selectedObject.loanAmount.paymentAmtLock  = cellPaymentAmt.isLock;
        }
        else if (selectedDelegate == amortizationController){
            [ModelObject instance].selectedObject.amortization.paymentAmtLock  = cellPaymentAmt.isLock;
        }
    }
    else if (sender == cellAmortization.lock){
        if (!cellLoanAmount.lock.hidden){
            [cellLoanAmount setLockVal: !cellAmortization.isLock];
        }
        if (!cellPaymentAmt.lock.hidden){
            [cellPaymentAmt setLockVal: !cellAmortization.isLock];
        }
        if (selectedDelegate == loanAmountController){
            [ModelObject instance].selectedObject.loanAmount.paymentAmtLock  = !cellAmortization.isLock;
        }
        else if (selectedDelegate == paymentAmountController){
            [ModelObject instance].selectedObject.paymentAmount.loanAmtLock  = !cellAmortization.isLock;
        }
    }
}

/********************
 *Table Methods
 ********************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    if (indexPath.section == 0){
        UITableViewCell *propCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (propCell == nil){
            switch (indexPath.row){
                case 0:
                case 2:
                    propCell = [[[PropertyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier hasVal:NO canLockVal: NO hasDiffVal:YES] autorelease];
                    ((PropertyTableViewCell *)propCell).delegate = self;
                    break;
                case 3:
                case 1:
                    propCell = [[[PropertyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier hasVal:YES canLockVal: NO hasDiffVal:YES] autorelease];
                    ((PropertyTableViewCell *)propCell).delegate = self;
                    break;
                case 4:
                    propCell = [[[LumpSumTableCellView alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:CellIdentifier] autorelease];
                    break;
                case 5:
                    propCell = [[[EditablePropertyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                    ((EditablePropertyTableViewCell *)propCell).editingTextField.delegate = self;
                    
                    break;
                case 6:
                    propCell = [[[StartDateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                    break;
                    
                default:
                    propCell = [[[PropertyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier hasVal:NO canLockVal: NO hasDiffVal:YES] autorelease];
                    ((PropertyTableViewCell *)propCell).delegate = self;
            }
            UIView *transparentBackground = [[UIView alloc] initWithFrame:CGRectZero];
            transparentBackground.backgroundColor = [UIColor clearColor];
            propCell.backgroundView = transparentBackground;
            propCell.backgroundColor = [UIColor clearColor];
            [transparentBackground release];
            
        }
        
        switch (indexPath.row){
            case 0:
                [(PropertyTableViewCell *)propCell resetData: @"Loan Amount" prop:[ModelObject instance].selectedObject.loanAmount];
                cellLoanAmount = (PropertyTableViewCell *)propCell;
                break;
            case 1:
                [(PropertyTableViewCell *)propCell resetData: @"Interest Rate" prop:[ModelObject instance].selectedObject.interestRate prop2:[ModelObject instance].selectedObject.compoundPeriod];
                cellInterestRate = (PropertyTableViewCell *)propCell;
                break;
            case 2:
                [(PropertyTableViewCell *)propCell resetData: @"Amortization" prop:[ModelObject instance].selectedObject.amortization];
                cellAmortization = (PropertyTableViewCell *)propCell;
                break;
            case 3:
                [(PropertyTableViewCell *)propCell resetData: @"Payment Amt" prop:[ModelObject instance].selectedObject.paymentAmount  prop2:[ModelObject instance].selectedObject.paymentFreq];
                cellPaymentAmt = (PropertyTableViewCell *)propCell;
                break;
            case 4:
                ((LumpSumTableCellView *)propCell).nameLabel.text = @"Lump Sum";
                cellLumpSum = (LumpSumTableCellView *)propCell;
                break;
            case 5:
                cellName = (EditablePropertyTableViewCell *)propCell;
                [((EditablePropertyTableViewCell *)propCell) setData: @"Name" prop:[ModelObject instance].selectedObject.name];
                break;
            case 6:
                [((StartDateTableViewCell *)propCell) resetData: @"Start Date" prop:[ModelObject instance].selectedObject.startDate];
                cellStartdate = (StartDateTableViewCell *)propCell;
                break;
        }
        
        cell = propCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        
        //dont do anything if we're editing name
        if (cellName.clearBtn.hidden == NO){
            return;
        }
        
        if (selectedDelegate != nil){
            [selectedDelegate displaySelectedView: NO];
        }
        selectedDelegate = nil;
        if (indexPath.row == 0){
            selectedDelegate = [self getLoanAmountController];
            [loanAmountController setControls: [ModelObject instance].selectedObject.loanAmount];
        }
        else if (indexPath.row == 1){
            selectedDelegate = [self getInterestRateController];
            [selectedDelegate setControls];
        }
        else if (indexPath.row == 2){
            selectedDelegate = [self getAmortizationController];
            [selectedDelegate setControls];
        }
        else if (indexPath.row == 3){
            selectedDelegate =[self getPaymentAmountController];
            paymentAmountController.minLimit = [[ModelObject instance].selectedObject.loanAmount getDollarValue]*[[ModelObject instance].selectedObject.ratePerPeriod getPercentValue]/100.0f ;
            paymentAmountController.maxLimit = [[ModelObject instance].selectedObject.loanAmount getDollarValue];
            [paymentAmountController setControls: [ModelObject instance].selectedObject.paymentAmount];
            
            //need to limit the min value
        }
        else if (indexPath.row == 4){
            //slide lump sum table
            if (lumpSumTableController == nil){
                lumpSumTableController = [[LumpSumTable alloc] initWithFrame:CGRectMake(320, 100, 320, 300) readOnlyVal: NO];
                lumpSumTableController.delegate = self;
                [self.detailView addSubview: lumpSumTableController.view];
            }
            [mainTableView deselectRowAtIndexPath: indexPath animated: YES];
            oldLeftBarButtonItem = self.navigationItem.leftBarButtonItem;
            oldRightBarButtonItem = self.navigationItem.rightBarButtonItem;
            [self pushController:lumpSumTableController];
            
        }
        else if (indexPath.row == 6){
            selectedDelegate = [self getStartDateController];
            [startDateController setControls: [ModelObject instance].selectedObject.startDate];
            
            [self slideDetailTableUp: 236];
            
        }
        
        if (selectedDelegate != nil){
            self.selectedIndex = indexPath;
            [selectedDelegate displaySelectedView: YES];
            [self.detailView bringSubviewToFront: selectedDelegate.view];
        }
    }
    
}

-(UIView *) getContainerView{
    return self.detailView;
}

-(UIView *) getTableView{
    return mainTableView;
}

-(void) setNavigation: (UINavigationItem*) navigationItemVal{
}

-(void) beforePush{
    self.navigationItem.title =  [ModelObject instance].selectedObject.name;
}

-(void) beforePeek{
    self.navigationItem.title =  [ModelObject instance].selectedObject.name;
    self.navigationItem.leftBarButtonItem = oldLeftBarButtonItem;
    self.navigationItem.rightBarButtonItem = oldRightBarButtonItem;
    /*	if (self.isAdd){
     self.navigationItem.leftBarButtonItem = oldLeftBarButtonItem;
     self.navigationItem.rightBarButtonItem = oldRightBarButtonItem;
     }
     else{
     self.navigationItem.leftBarButtonItem = nil;
     self.navigationItem.rightBarButtonItem = listButton;
     }*/
}

-(void) beforePop{
}

-(void) afterPush{
}

-(void) pushController: (id) pushedTable{
    id <SlideItemTable>  pushedController  = (id <SlideItemTable>) pushedTable;
    
    [pushedController setNavigation: self.navigationItem];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [pushedController beforePush];
    id <SlideItemTable> parentController = ( id <SlideItemTable>)[viewStack peek];
    [viewStack push:pushedTable];
    UIView *parentTable = [parentController getTableView];
    UIView *pushedView = [pushedController getTableView];
    CGRect frame =  CGRectMake(0, pushedView.frame.origin.y, pushedView.bounds.size.width, pushedView.bounds.size.height);
    CGRect tframe =  CGRectMake(-1*parentTable.frame.size.width, parentTable.frame.origin.y, parentTable.frame.size.width, parentTable.frame.size.height);
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    pushedView.frame = frame;
    parentTable.frame = tframe;
    [UIView commitAnimations];
    [pushedController afterPush];
}

-(void) popController{
    id <SlideItemTable>  popedTableController = ( id <SlideItemTable>)[viewStack pop];
    id <SlideItemTable> parentTableController = ( id <SlideItemTable>)[viewStack peek];
    [parentTableController beforePeek];
    [popedTableController beforePop];
    UIView *popedTable = (UIView *)[popedTableController getTableView];
    UIView *parentTable = (UIView *)[parentTableController getTableView];
    
    /*	if (parentTableController == self){
     if (self.isAdd)
     self.navigationItem.leftBarButtonItem = cancelButton;
     else
     self.navigationItem.leftBarButtonItem = nil;
     }*/
    CGRect frame =  CGRectMake(popedTable.frame.size.width, popedTable.frame.origin.y, popedTable.bounds.size.width, popedTable.frame.size.height);
    CGRect tframe =  CGRectMake(0, parentTable.frame.origin.y, parentTable.frame.size.width, parentTable.frame.size.height);
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    popedTable.frame = frame;
    parentTable.frame = tframe;
    [UIView commitAnimations];
    
}

@end
