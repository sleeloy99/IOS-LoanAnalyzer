//
//  ComparisonViewController.m
//  Comparison
//
//  Created by Sheldon Lee-Loy on 3/25/09.
//  Copyright cellinova inc 2009. All rights reserved.
//

#import "ComparisonViewController.h"

@implementation ComparisonViewController

@synthesize view1, view2;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    
    leftLoanController = [[LeftLoanTable alloc] initWithNibName:@"LeftTableView" bundle:[NSBundle mainBundle]];
    [view1 addSubview: leftLoanController.view];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            );
}

-(void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation duration:(NSTimeInterval)duration{
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    float navigationHeight = 64;
    
    if(toOrientation == UIInterfaceOrientationPortrait || toOrientation == UIInterfaceOrientationPortraitUpsideDown){
        view1.frame = CGRectMake(0, 0, 320, screenHeight - navigationHeight);
        view2.frame = CGRectMake(0, 0, 0, 0);
        if (rightLoanController != nil){
            [rightLoanController.view removeFromSuperview];
        }
    }
    else{
        rightLoanController = [[RightLoanTable alloc] initWithNibName:@"RightTableView" bundle:[NSBundle mainBundle]];
        rightLoanController.view.frame = CGRectMake(0, 0, 320, screenHeight - navigationHeight);
        float midPoint = screenHeight/2;
        [view2 addSubview: rightLoanController.view];
        
        view1.frame = CGRectMake(0, 0, midPoint, 315);
        view2.frame = CGRectMake(midPoint, 0, midPoint, 315);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    [cell.textLabel setText: [NSString stringWithFormat: @"Mortgage %d", (int)indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}

- (void)dealloc {
    [view1 release];
    [view2 release];
    [leftLoanController release];
    [rightLoanController release];
    [super dealloc];
}

@end
