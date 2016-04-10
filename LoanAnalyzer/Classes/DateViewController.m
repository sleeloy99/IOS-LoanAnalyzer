//
//  DateViewController.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "DateViewController.h"

@implementation DateViewController

@synthesize datePicker, btnStatusBar;

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
    [btnStatusBar setTitle: @"Start Date" forState:UIControlStateNormal];
    [image release];
}

- (void)setControls : (DateObject *) date{
    dateObj = date;
    datePicker.date = [dateObj getDateValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) changeEvent: (id) sender{
    if (sender == datePicker){
        [dateObj setDateValue: datePicker.date];
    }
}

- (void)dealloc {
    [datePicker release];
    [btnStatusBar release];
    [super dealloc];
}

@end
