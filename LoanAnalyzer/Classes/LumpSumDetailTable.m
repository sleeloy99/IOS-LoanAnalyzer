//
//  LumpSumDetailTable.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "LumpSumDetailTable.h"


@implementation LumpSumDetailTable

@synthesize delegate, tableView, isAdd, saveButton, resetButton, cancelButton, selectedIndex;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithLumpsum:(int) idx  add:(BOOL) add {
    if (self = [super init]) {
        lumpsumidx = idx;
        self.isAdd =add;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [selectedDelegate displaySelectedView: NO];
    [super viewWillDisappear: animated];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    self.view = [[UIView alloc] initWithFrame: CGRectMake(320, 100, 320, 300)];
    
    //create lump sum table
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 320, 255) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.opaque = YES;
    [self.view addSubview: tableView];
    
    self.saveButton = [[UIBarButtonItem alloc] initWithTitle: @"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    self.cancelButton = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    self.resetButton = [[UIBarButtonItem alloc] initWithTitle: @"Reset" style:UIBarButtonItemStyleBordered target:self action:@selector(reset:)];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (lumpSumChanged:) name:@"lumpsumchanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (startdatelumpsumChanged:) name:@"startdatelumpsumChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (enddatelumpsumChanged:) name:@"enddatelumpsumChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (lumpsumFreqChanged:) name:@"lumpsumFreqChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (closingkeypad:) name:@"closingkeypad" object:nil];
    
}

-(void) setControls: (int) idx{
    LumpSum *lumpsumVal = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: idx];
    
    [cellValue setData: lumpsumVal.value ];
    [cellStart setData: lumpsumVal.duration.startDate];
    [cellEnd setData: lumpsumVal.duration.endDate];
    [cellPeriod setData: lumpsumVal.lumpsumPeriod];
    lumpsumidx = idx;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
    static NSString *RootViewControllerCell = @"RootViewControllerCell";
    
    StartDateTableViewCell *cell = (StartDateTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
    if (cell == nil){
        cell = [[[StartDateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: RootViewControllerCell] autorelease];
        UIView *transparentBackground = [[UIView alloc] initWithFrame:CGRectZero];
        transparentBackground.backgroundColor = [UIColor clearColor];
        cell.backgroundView = transparentBackground;
        [transparentBackground release];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    LumpSum *lumpsum = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: lumpsumidx];
    switch (indexPath.row) {
        case 0:
            cellValue = cell;
            [cellValue resetData: @"Value" prop: lumpsum.value];
            break;
        case 1:
            cellStart = cell;
            [cellStart resetData: @"Start Date" prop: lumpsum.duration.startDate];
            break;
        case 2:
            cellEnd = cell;
            [cellEnd resetData: @"End Date" prop: lumpsum.duration.endDate];
            break;
        case 3:
            cellPeriod = cell;
            [cellPeriod resetData: @"Repeats" prop: lumpsum.lumpsumPeriod];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath{
    if (selectedDelegate != nil)
        [selectedDelegate displaySelectedView: NO];
    self.selectedIndex = [indexPath copy];
    LumpSum *lumpsum = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: lumpsumidx];
    switch (indexPath.row) {
        case 0:
            if (lumpSumValueController == nil){
                lumpSumValueController = [[NumberSliderKeyPadViewController alloc] initWithNibName:@"NumKeyPad" bundle:[NSBundle mainBundle] dollarObj: lumpsum.value];
                lumpSumValueController.view.frame = CGRectMake(0, 420, 320, 360);
                [lumpSumValueController.btnStatusBar setTitle:  @"Value" forState:UIControlStateNormal];
                [[self.delegate getContainerView] addSubview: lumpSumValueController.view];
            }
            [lumpSumValueController setControls: lumpsum.value];
            [lumpSumValueController displaySelectedView: YES];
            selectedDelegate = lumpSumValueController;
            [[self.delegate getContainerView] bringSubviewToFront: lumpSumValueController.view];
            
            break;
        case 1:
            if (startDateController == nil){
                startDateController = [[DateViewController alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
                startDateController.view.frame = CGRectMake(0, 420, 320, 236);
                [startDateController.btnStatusBar setTitle:  @"Start Date" forState:UIControlStateNormal];
                [[self.delegate getContainerView] addSubview: startDateController.view];
            }
            startDateController.datePicker.minimumDate = [[ModelObject instance].selectedObject.startDate getDateValue];
            [startDateController setControls: lumpsum.duration.startDate];
            [[self.delegate getContainerView] bringSubviewToFront: startDateController.view];
            selectedDelegate = startDateController;
            [selectedDelegate displaySelectedView: YES];
            break;
        case 2:
            if (endDateController == nil){
                endDateController = [[DateViewController alloc] initWithNibName:@"DatePicker" bundle:[NSBundle mainBundle]];
                endDateController.view.frame = CGRectMake(0, 420, 320, 236);
                [[self.delegate getContainerView] addSubview: endDateController.view];
                [endDateController.btnStatusBar setTitle:  @"End Date" forState:UIControlStateNormal];
            }
            endDateController.datePicker.minimumDate = lumpsum.duration.startDate.value;
            [endDateController setControls: lumpsum.duration.endDate];
            [[self.delegate getContainerView] bringSubviewToFront: endDateController.view];
            selectedDelegate = endDateController;
            [selectedDelegate displaySelectedView: YES];
            break;
        case 3:
            if (lumpsumFreqPeriodController == nil){
                lumpsumFreqPeriodController = [[LumpSumFrequencyViewController alloc] initWithNibNameLumpsumPeriod:@"LumpSumFreqPeriod" bundle:[NSBundle mainBundle] lumpsumPeriodVall: lumpsum.lumpsumPeriod];
                lumpsumFreqPeriodController.view.frame = CGRectMake(0, 420, 320, 70);
                [[self.delegate getContainerView] addSubview: lumpsumFreqPeriodController.view];
            }
            else
                [lumpsumFreqPeriodController setControls: lumpsum.lumpsumPeriod];
            [[self.delegate getContainerView] bringSubviewToFront: lumpsumFreqPeriodController.view];
            selectedDelegate = lumpsumFreqPeriodController;
            [selectedDelegate displaySelectedView: YES];
            
            break;
        default:
            break;
            
    }
    
    /*	[lumpSumController displaySelectedView: YES];
     LumpSum *lumpsum = [lumpsums objectAtIndex: indexPath.row];
     [lumpSumController setControls: lumpsum.value];
     [self.view bringSubviewToFront: lumpSumController.view];	*/
}

- (void) closingkeypad: (NSNotification *) notification{
    if (self.selectedIndex != nil){
        [self.tableView deselectRowAtIndexPath: self.selectedIndex animated: YES];
        self.selectedIndex = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) lumpSumChanged: (NSNotification *) notification
{
    LumpSum *lumpsum = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: lumpsumidx];
    
    [cellValue setData:  lumpsum.value ];
    parentNavigationItem.rightBarButtonItem = self.saveButton;
    parentNavigationItem.leftBarButtonItem = self.resetButton;
    //	[[NSNotificationCenter defaultCenter] postNotificationName: @"redrawChart" object: self];
}

- (void) startdatelumpsumChanged: (NSNotification *) notification
{
    LumpSum *lumpsum = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: lumpsumidx];
    [cellStart setData: lumpsum.duration.startDate];
    //check to see if start Date is after end date
    if ([lumpsum.duration.startDate.value compare: lumpsum.duration.endDate.value] == NSOrderedDescending){
        //need to update end date.  When we set the end date it will notify the redraw
        endDateController.datePicker.minimumDate = lumpsum.duration.startDate.value;
        [lumpsum.duration.endDate setDateValue: lumpsum.duration.startDate.value];
    }
    else{
        parentNavigationItem.rightBarButtonItem = self.saveButton;
        parentNavigationItem.leftBarButtonItem = self.resetButton;
        
        [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
    }
}

- (void) enddatelumpsumChanged: (NSNotification *) notification
{
    LumpSum *lumpsum = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: lumpsumidx];
    [cellEnd setData: lumpsum.duration.endDate];
    parentNavigationItem.rightBarButtonItem = self.saveButton;
    parentNavigationItem.leftBarButtonItem = self.resetButton;
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

- (void) lumpsumFreqChanged: (NSNotification *) notification
{
    LumpSum *lumpsum = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: lumpsumidx];
    [cellPeriod setData: lumpsum.lumpsumPeriod];
    parentNavigationItem.rightBarButtonItem = self.saveButton;
    parentNavigationItem.leftBarButtonItem = self.resetButton;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

-(UIView *) getTableView{
    return self.view;
}

-(void) setNavigation: (UINavigationItem*) navigationItemVal{
    parentNavigationItem = navigationItemVal;
}

-(void) beforePush{
    parentNavigationItem.title = @"Lump Sum";
    oldLeftBarButton = parentNavigationItem.leftBarButtonItem;
    oldRightBarButton = parentNavigationItem.rightBarButtonItem;
    
    if (self.isAdd){
        //set up navigation bar
        parentNavigationItem.leftBarButtonItem = self.cancelButton;
        parentNavigationItem.rightBarButtonItem = self.saveButton;
    }
    else{
        parentNavigationItem.leftBarButtonItem = oldLeftBarButton;
        parentNavigationItem.rightBarButtonItem = nil;
    }
}

-(void) beforePop{
    [selectedDelegate displaySelectedView: NO];
}


-(void) beforePeek{
    parentNavigationItem.title = @"Lump Sum";
    parentNavigationItem.rightBarButtonItem = oldRightBarButton;
    parentNavigationItem.leftBarButtonItem = oldLeftBarButton;
}

-(void) afterPush{
}

-(void) toggleEdit:(id)sender{
    if (self.tableView.editing){
        parentNavigationItem.rightBarButtonItem.title = @"Edit";
        parentNavigationItem.leftBarButtonItem = oldLeftBarButton;
    }
    else{
        parentNavigationItem.rightBarButtonItem.title = @"Done";
        UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
        parentNavigationItem.leftBarButtonItem = plusButton;
        [plusButton release];
    }
    [self.tableView setEditing: !self.tableView.editing animated:YES];
}

-(void) save:(id)sender{
    LumpSum *lumpsum = [[ModelObject instance].selectedObject.lumpSums objectAtIndex: lumpsumidx];
    
    lumpsumidx = [[ModelObject instance] saveLumpSum: lumpsum idx:lumpsumidx];
    parentNavigationItem.rightBarButtonItem = nil;
    parentNavigationItem.leftBarButtonItem = oldLeftBarButton;
    [selectedDelegate displaySelectedView: NO];
    //no longer is add mode
    self.isAdd = NO;
    //need to redrawChart
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

-(void) cancel:(id)sender{
    parentNavigationItem.rightBarButtonItem = nil;
    parentNavigationItem.leftBarButtonItem = oldLeftBarButton;
    [selectedDelegate displaySelectedView: NO];
    //remove current lump sum from table
    [[ModelObject instance] deleteLumpSumAt:lumpsumidx];
    
    //need to redrawChart
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];	
    //need to get main window
    [self.delegate popController];
}

-(void) reset:(id)sender{
    [[ModelObject instance] resetLumpSumAt: lumpsumidx];
    parentNavigationItem.rightBarButtonItem = nil;
    if (self.isAdd){
        parentNavigationItem.leftBarButtonItem = cancelButton;
    }
    else{
        parentNavigationItem.leftBarButtonItem = oldLeftBarButton;
    }
    [selectedDelegate displaySelectedView: NO];
    [self setControls: lumpsumidx];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

- (void)dealloc {
    if (self.selectedIndex != nil){
        [self.selectedIndex release];
    }
    if (lumpsumFreqPeriodController != nil){
        [lumpsumFreqPeriodController release];
    }
    if (lumpSumValueController != nil){
        [lumpSumValueController release];
    }
    if (lumpsumFreqPeriodController != nil){
        [lumpsumFreqPeriodController release];
    }
    if (startDateController != nil){
        [startDateController release];
    }
    [self.saveButton release];
    [self.cancelButton release];
    [super dealloc];
}

@end
