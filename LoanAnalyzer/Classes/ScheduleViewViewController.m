//
//  ScheduleViewViewController.m
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright cellinova inc 2009. All rights reserved.
//

#import "ScheduleViewViewController.h"
#import "ScheduleModel.h"
#import "CellSlide.h"

@implementation ScheduleViewViewController
@synthesize delegate, progressIndicator, headerView;

- (id)initWithNibNameTableModel:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        tableModel = [ScheduleModel instance];
        stillPressed = NO;
    }
    return self;
}

/* ios 6 rotation methods */
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

/* ios 5 rotation methods */
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            );
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        if (chartController == nil){
            chartController = [[TwoBarChartController alloc] init];
            TwoBarChart *chartObj = [[TwoBarChart alloc] init];
            chartController.chartObj = chartObj;
            [chartObj release];
            
            chartController.chartObj.sequence = [tableModel getSchedule];
            chartController.chartObj.title = [ModelObject instance].selectedObject.name;
            chartController.chartObj.maxX = [tableModel getNumOfPayments];
            chartController.chartObj.maxY = [[ModelObject instance].selectedObject.loanAmount getDollarValue];
            chartController.chartObj.coordMaxX = 480;
            chartController.chartObj.coordMaxY = 320;
            [chartController.chartObj initialize];
        }
        [self.view addSubview: chartController.view];
    }
    else{
        if (chartController != nil)
            [chartController.view removeFromSuperview];
    }
    
    if (chartController != nil)
        [chartController willAnimateRotationToInterfaceOrientation: interfaceOrientation duration:duration];
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    if (tableModel == nil){
        tableModel = [ScheduleModel instance];
    }
    int navigationHeight = 44;
    int startusBarHeight = 20;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        //    offset = 20;
        CGRect origFrame = 	self.headerView.frame;
        CGRect frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+navigationHeight+startusBarHeight, origFrame.size.width, origFrame.size.height);
        self.headerView.frame = frame;
    }
    float headerY = headerView.frame.origin.y;
    float headerHeight = headerView.frame.size.height;
    float screenSize = [[UIScreen mainScreen] bounds].size.height;
    
    [headerView viewDidLoad];
    headerView.detailController = self;
    
    mainTableView = [[UIHorizontalView alloc] initWithFrame: CGRectMake(0, headerHeight+headerY, 320, screenSize-headerHeight-navigationHeight-startusBarHeight) style:UITableViewStylePlain];
    mainTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mainTableView.detailController = self;
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: mainTableView];
    
    /*	headerView= [[HeaderUIView alloc] initWithFrame: CGRectMake(0, 0, 320, 55)];
     [self.view addSubview: headerView];		*/
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (continousRight:) name:@"continousRight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (continousLeft:) name:@"continousLeft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (continousEnd:) name:@"continousEnd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (swipeRight:) name:@"swipeRight" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (swipeLeft:) name:@"swipeLeft" object:nil];
    [super viewDidLoad];
}

-(void) doubleTap{
    scheduleMode = !scheduleMode;
    [tableModel initializeArray: scheduleMode];
    [headerView updateHeader];
    visibleRows = (int)[[mainTableView visibleCells] count];
    [mainTableView reloadData];
}

-(void)resetView{
    [tableModel initializeArray:scheduleMode];
    [headerView updateHeader];
    visibleRows = (int)[[mainTableView visibleCells] count];
    [mainTableView reloadData];
    
    if (chartController != nil){
        chartController.chartObj.sequence = [tableModel getSchedule];
        
        chartController.chartObj.title = [ModelObject instance].selectedObject.name;
        chartController.chartObj.maxX = [tableModel getNumOfPayments];
        chartController.chartObj.maxY = [[ModelObject instance].selectedObject.loanAmount getDollarValue];
        chartController.chartObj.coordMaxX = 480;
        chartController.chartObj.coordMaxY = 320;
        [chartController.chartObj initialize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    [progressIndicator release];
    [chartController release];
    [tableModel release];
    [headerView release];
    [mainTableView release];
    if (_timer != nil)
        [_timer release];
    [super dealloc];
}

/********************
 *Table Methods
 ********************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //The first section is the list of Loan properties and the second section is the Calculate button
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableModel verticalCount];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    visibleRows--;
    if (visibleRows == 0){
        [progressIndicator stopAnimating];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    CellSlide *cell;
    if (indexPath.section == 0){
        cell = (CellSlide *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[[CellSlide alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.index = (int)indexPath.row;
        [cell updateCells];
    }
    
    return cell;
}

- (IBAction) cancel{
    [[self.delegate navigationController] popViewControllerAnimated: YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath{
}

/*************
 Swipe methods
 *************/
- (void) continousLeft: (NSNotification *) notification{
    if ([tableModel canMoveLeft]){
        [tableModel swipeLeft];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"updateCells" object: self];
        if (_timer != nil)
            [_timer release];
        _timer = [[NSTimer scheduledTimerWithTimeInterval: 0.2 target:self selector: @selector(timerLeft:) userInfo:nil repeats:NO] retain];
    }
}

- (void)timerLeft:(NSTimer *)theTimer{
    if ([tableModel canMoveLeft]){
        [tableModel swipeLeft];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"updateCells" object: self];
        if (_timer != nil)
            [_timer release];
        _timer = [[NSTimer scheduledTimerWithTimeInterval: 0.2 target:self selector: @selector(timerLeft:) userInfo:nil repeats:NO] retain];
    }
}

- (void) continousRight: (NSNotification *) notification{
    if ([tableModel canMoveRight]){
        [tableModel swipeRight];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"updateCells" object: self];
        if (_timer != nil)
            [_timer release];
        _timer = [[NSTimer scheduledTimerWithTimeInterval: 0.2 target:self selector: @selector(timerRight:) userInfo:nil repeats:NO] retain];
    }
}

- (void)timerRight:(NSTimer *)theTimer{
    if ([tableModel canMoveRight]){
        [tableModel swipeRight];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"updateCells" object: self];
        if (_timer != nil)
            [_timer release];
        _timer = [[NSTimer scheduledTimerWithTimeInterval: 0.2 target:self selector: @selector(timerRight:) userInfo:nil repeats:NO] retain];
    }
}

- (void) continousEnd: (NSNotification *) notification{
    if ([_timer isValid]){
        [_timer invalidate];
    }
}

- (void)swipeLeft: (NSNotification *) notification{
    if ([tableModel canMoveLeft]){
        [tableModel swipeLeft];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"moveLeft" object: self];
    }
}

- (void)swipeRight: (NSNotification *) notification{
    if ([tableModel canMoveRight]){
        [tableModel swipeRight];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"moveRight" object: self];
        [mainTableView setContentOffset: CGPointMake(0, 0) animated: YES];
    }
}

- (void)swipe: (double) offset{
}

@end
