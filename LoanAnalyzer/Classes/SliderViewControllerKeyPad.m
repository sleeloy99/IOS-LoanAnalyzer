//
//  SliderViewControllerKeyPad.m
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "SliderViewControllerKeyPad.h"


@implementation SliderViewControllerKeyPad

@synthesize maxLbl, minLbl, slider;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeSliderMinMax];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) initializeSliderMinMax{
}

- (void) updateMinMaxLabels{
}

- (void) slideEvent: (id) sender{
}

- (void) sliderTouchUp: (id) sender{
}

- (void)dealloc {
    [maxLbl release];
    [minLbl release];
    [slider release];
    [super dealloc];
}

@end

