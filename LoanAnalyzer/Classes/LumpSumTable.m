//
//  LumpSumTable.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/27/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "LumpSumTable.h"
#import "MyNavigationController.h"

@implementation LumpSumTable
@synthesize delegate, tableView ,editButton, lumpSums, readOnly;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithFrame: (CGRect)frame readOnlyVal:(BOOL)readOnlyVal {
    if (self = [super init]) {
		readOnly = readOnlyVal;
		viewFrame = frame;
    }
	return self;
}
- (id)init {
    if (self = [super init]) {
		readOnly = NO;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear: animated];
	self.navigationItem.title = @"Lump Sums";
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	self.view = [[UIView alloc] initWithFrame: viewFrame];
	//create lump sum table	
	if (!readOnly){
		self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 55, viewFrame.size.width, 200) style:UITableViewStyleGrouped];
	}
    else{
		self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 5, viewFrame.size.width, 200) style:UITableViewStyleGrouped];
    }
	self.tableView.dataSource = self;
	self.tableView.delegate = self;	
	self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview: tableView];
	
	if (!readOnly){
		//edit and add button
		editButton = [[UIButton alloc] initWithFrame: CGRectMake(10, 5, 80, 40)];
		
		NSString *path=[[NSBundle mainBundle] pathForResource: @"whiteround" ofType:@"png"];
		UIImage *image = [UIImage imageWithContentsOfFile: path];		
		[editButton setTitle: @"Edit" forState: UIControlStateNormal];
		[editButton setBackgroundImage:image forState: UIControlStateNormal];
		editButton.backgroundColor = [UIColor clearColor];
		[self.view addSubview: editButton];
		[editButton addTarget: self action:@selector(toggleEdit:) forControlEvents:UIControlEventTouchUpInside];				
		[editButton release];
		
		UIButton *addButton = [[UIButton alloc] initWithFrame: CGRectMake(270, 5, 40, 40)];
		path=[[NSBundle mainBundle] pathForResource: @"whiteadd" ofType:@"png"];
		image = [UIImage imageWithContentsOfFile: path];		
		[addButton setBackgroundImage:image forState: UIControlStateNormal];
		addButton.backgroundColor = [UIColor clearColor];
		[self.view addSubview: addButton];
		[addButton addTarget: self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
		[addButton release];
	}
	
}

- (void)shouldHideEdit{
	if ([[ModelObject instance].selectedObject.lumpSums count] == 0){
		editButton.hidden = YES;
		//reset edit button
		if (self.tableView.editing){
			[self.tableView setEditing: !self.tableView.editing animated:YES];	
			[editButton setTitle: @"Edit" forState: UIControlStateNormal];			
		}
	}
    else{
		editButton.hidden = NO;
    }
}

/* ios 6 rotation methods */
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section{
	if (self.lumpSums != nil)
		return [self.lumpSums count];
	return [[ModelObject instance].selectedObject.lumpSums count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 54;
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	static NSString *RootViewControllerCell = @"RootViewControllerCell";
	
	LumpSumTableViewCell *cell = (LumpSumTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
	if (cell == nil){
		cell = [[[LumpSumTableViewCell alloc] initWithStyleRO:UITableViewCellStyleDefault reuseIdentifier: RootViewControllerCell readOnly:self.readOnly] autorelease ];
		UIView *transparentBackground = [[UIView alloc] initWithFrame:CGRectZero];
		transparentBackground.backgroundColor = [UIColor clearColor];
		cell.backgroundView = transparentBackground;			
        cell.backgroundColor = [UIColor clearColor];
	}
    if (self.lumpSums != nil){
		[cell setData:[self.lumpSums objectAtIndex: indexPath.row]];
    }
    else{
		[cell setData:[[ModelObject instance].selectedObject.lumpSums objectAtIndex: indexPath.row]];
    }
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath{
	if (readOnly) return;
	//lumpSumController
	if (lumpSumDetailController == nil){
		lumpSumDetailController = [[LumpSumDetailTable alloc] initWithLumpsum: (int)indexPath.row add:NO];
		lumpSumDetailController.delegate = self.delegate;	
		[[self.delegate getContainerView] addSubview: lumpSumDetailController.view];
	}
	else{
		[lumpSumDetailController setControls: (int)indexPath.row];
		lumpSumDetailController.isAdd = NO;		
	}
	[self.delegate pushController: lumpSumDetailController];
	[self.tableView deselectRowAtIndexPath: indexPath animated: YES];
		
	
/*	[lumpSumController displaySelectedView: YES];
	LumpSum *lumpsum = [lumpsums objectAtIndex: indexPath.row];
	[lumpSumController setControls: lumpsum.value];
	[self.view bringSubviewToFront: lumpSumController.view];	
 */
}

-(void)tableView:(UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath{
	NSUInteger index = [indexPath row];
	[[ModelObject instance] deleteLumpSumAt: (int)index];
	[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
	//need to update chart if we remove a lump sum
	[[NSNotificationCenter defaultCenter] postNotificationName: @"redrawChart" object: self];	
	[self shouldHideEdit];

}

-(void) slideDetailTable{	
	CGRect frame =  CGRectMake(lumpSumDetailController.view.frame.size.width, lumpSumDetailController.view.frame.origin.y, lumpSumDetailController.view.bounds.size.width, lumpSumDetailController.view.frame.size.height);		
	CGRect tframe =  CGRectMake(0, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration: 0.5f];
	lumpSumDetailController.view.frame = frame;
	self.tableView.frame = tframe;
	[UIView commitAnimations];			
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

-(UIView *) getTableView{
		return self.view;
}
	
-(void) setNavigation: (UINavigationItem*) navigationItemVal{
	parentNavigationItem = navigationItemVal;
}
	
-(void) beforePush{
	//update loand need to refresh table
	[self.tableView reloadData];	
	parentNavigationItem.title = @"Lump Sums";
	oldLeftBarButton = parentNavigationItem.leftBarButtonItem;
	[self shouldHideEdit];

	//set up navigation bar
//	self.editButton = [[UIBarButtonItem alloc] initWithTitle: @"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEdit:)];	
	parentNavigationItem.rightBarButtonItem = nil;
}

-(void) beforePeek{
	[self.tableView reloadData];		
	[self shouldHideEdit];
	parentNavigationItem.title = @"Lump Sums";
	parentNavigationItem.leftBarButtonItem = oldLeftBarButton;	
	parentNavigationItem.rightBarButtonItem = nil;	
	//turn off edit
	if (self.tableView.editing){
		parentNavigationItem.rightBarButtonItem.title = nil;
		parentNavigationItem.leftBarButtonItem = oldLeftBarButton;	
		[self.tableView setEditing: !self.tableView.editing animated:YES];	
	}
}

-(void) beforePop{
}

-(void) toggleEdit:(id)sender{
	if (self.tableView.editing){
		[editButton setTitle: @"Edit" forState: UIControlStateNormal];
//		parentNavigationItem.rightBarButtonItem.title = @"Edit";
//		parentNavigationItem.leftBarButtonItem = oldLeftBarButton;		
	}
	else{
		[editButton setTitle: @"Done" forState: UIControlStateNormal];		
//		parentNavigationItem.rightBarButtonItem.title = @"Done";
//		UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];	
//		parentNavigationItem.leftBarButtonItem = plusButton;
//		[plusButton release];			
	}
	[self.tableView setEditing: !self.tableView.editing animated:YES];
}

-(void) addAction:(id)sender{
	
	LumpSum *newlumpsum = [[ModelObject instance] createNewLumpSum];
	int lumpsumidx = [[ModelObject instance] saveLumpSum: newlumpsum idx:-1];
	if (lumpSumDetailController == nil){
	
		lumpSumDetailController = [[LumpSumDetailTable alloc] initWithLumpsum: lumpsumidx add:YES];
		lumpSumDetailController.delegate = self.delegate;	
		[[self.delegate getContainerView] addSubview: lumpSumDetailController.view];
	}
	else{
		[lumpSumDetailController setControls: lumpsumidx];
		lumpSumDetailController.isAdd = YES;
	}
	//need to update chart
	[[NSNotificationCenter defaultCenter] postNotificationName: @"redrawChart" object: self];	
	[self.delegate pushController: lumpSumDetailController];
}

-(void) afterPush{
}

- (void)dealloc {
    if (lumpSums != nil){
		[lumpSums release];
    }
	[lumpSumDetailController release];
	[self.editButton release];	
	[self.tableView release];
    [super dealloc];
}


@end
