//
//  LumpSumFrequencyViewController.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/29/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "LumpSumFrequencyViewController.h"

@implementation LumpSumFrequencyViewController
@synthesize freqCtrl, btnStatusBar, lumpsumPeriod;

 // The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibNameLumpsumPeriod:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  lumpsumPeriodVall:(LumpSumPeriodObj *) lumpsumPeriodVall {
	 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		 // Custom initialization
		 self.lumpsumPeriod = lumpsumPeriodVall;
	 }
	 return self;
 }

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *path=[[NSBundle mainBundle] pathForResource: @"calcBkg" ofType:@"png"];
	UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];	
	((UIImageView *)self.view).image = image;
	[image release];
	
	path=[[NSBundle mainBundle] pathForResource: @"headerBkg" ofType:@"png"];
	image = [[UIImage imageWithContentsOfFile: path] retain];	
	
	[btnStatusBar setBackgroundImage:image forState: UIControlStateNormal];
	btnStatusBar.backgroundColor = [UIColor clearColor];
	[btnStatusBar.titleLabel setFont: [UIFont boldSystemFontOfSize:12.0]];
	[btnStatusBar setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
	[btnStatusBar setTitle: @"Lump Sum Frequency" forState:UIControlStateNormal];
	[image release];	
	
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        freqCtrl.tintColor = [UIColor whiteColor];
    }
    
	[self setControls: self.lumpsumPeriod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) setControls: (LumpSumPeriodObj *) lumpsumPeriodVal
{
	self.lumpsumPeriod = lumpsumPeriodVal;
	LumpSumPeriodEnum freqVal = 0;
	switch ([lumpsumPeriodVal getLumpSumValue]) {
		case LUMPMONTHLY:
			freqVal = 0;
			break;
		case LUMPANNUAL:
			freqVal = 1;
			break;
		case LUMPNONE:
			freqVal = 2;
			break;
		default:
			break;
	}
	freqCtrl.selectedSegmentIndex = freqVal;
}

- (void) freqChanged: (id) sender{
	LumpSumPeriodEnum freqVal = LUMPMONTHLY;
	switch (freqCtrl.selectedSegmentIndex) {
		case 0:
			freqVal = LUMPMONTHLY;
			break;
		case 1:
			freqVal = LUMPANNUAL;
			break;
		case 2:
			freqVal = LUMPNONE;
			break;
		case 3:
			freqVal = BIWEEKLY;
			break;			
		default:
			break;
	}
	
	[self.lumpsumPeriod setLumpSumValue: freqVal];
}

- (void)dealloc {	
	[freqCtrl release];
	[btnStatusBar release];
	[lumpsumPeriod release];
    [super dealloc];
}

@end

