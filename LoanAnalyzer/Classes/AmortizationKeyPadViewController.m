//
//  AmortizationKeyPadViewController.m
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "AmortizationKeyPadViewController.h"


@implementation AmortizationKeyPadViewController

@synthesize yearSlider, monthSlider, btnStatusBar;

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
	[btnStatusBar setTitle: @"Amortization" forState:UIControlStateNormal];
	[image release];	
	
	[self setControls];

}

- (void)setControls{
	monthSlider.value = [[ModelObject instance].selectedObject.amortization getMonths];
	yearSlider.value = [[ModelObject instance].selectedObject.amortization getYears];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

-(void) sliderTouchUp: (id) sender{
	[[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];		
}

- (void) slideEvent: (id) sender{
    if (sender == yearSlider){
		[[ModelObject instance].selectedObject.amortization setYears: ((int)(yearSlider.value+.5f))];
    }
    else if (sender == monthSlider){
		[[ModelObject instance].selectedObject.amortization setMonths: ((int)(monthSlider.value+.5f))];
    }
}

- (void)dealloc{
	[monthSlider release];
	[yearSlider release];
	[btnStatusBar release];	
    [super dealloc];
}

@end