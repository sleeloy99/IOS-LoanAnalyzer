//
//  AmortizationKeyPad.m
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "PaymentFreqKeyPadViewController.h"


@implementation PaymentFreqKeyPadViewController
@synthesize freqPaymentCtrl, btnStatusBar;

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
    [btnStatusBar setTitle: @"Payment Frequency" forState:UIControlStateNormal];
    [image release];
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        freqPaymentCtrl.tintColor = [UIColor whiteColor];
    }
    
    [self setControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) setControls{
    PaymentFreqEnum paymentFreqVal = 0;
    switch ([[ModelObject instance].selectedObject.paymentFreq getFreqValue]) {
        case MONTHLY:
            paymentFreqVal = 0;
            break;
        case BIMONTHLY:
            paymentFreqVal = 1;
            break;
        case WEEKLY:
            paymentFreqVal = 2;
            break;
        case BIWEEKLY:
            paymentFreqVal = 3;
            break;
        default:
            break;
    }
    freqPaymentCtrl.selectedSegmentIndex = paymentFreqVal;
}

- (void) freqPaymentChanged: (id) sender{
    PaymentFreqEnum paymentFreqVal = MONTHLY;
    switch (freqPaymentCtrl.selectedSegmentIndex) {
        case 0:
            paymentFreqVal = MONTHLY;
            break;
        case 1:
            paymentFreqVal = BIMONTHLY;
            break;
        case 2:
            paymentFreqVal = WEEKLY;
            break;
        case 3:
            paymentFreqVal = BIWEEKLY;
            break;			
        default:
            break;
    }
    
    [[ModelObject instance].selectedObject.paymentFreq setFreqValue: paymentFreqVal];
}

- (void)dealloc {	
    [freqPaymentCtrl release];
    [btnStatusBar release];
    [super dealloc];
}

@end
