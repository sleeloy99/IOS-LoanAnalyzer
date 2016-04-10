//
//  NumberKeyPadSliderController.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/27/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "NumberKeyPadSliderController.h"


@implementation NumberKeyPadSliderController
@synthesize freqPaymentCtrl;

- (void)viewDidLoad {
	self.twoModeView.minHeight = 120;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        freqPaymentCtrl.tintColor = [UIColor whiteColor];
    }

    [super viewDidLoad];
}

-(void) setControls:(DollarObject *) dollarVal
{
	[super setControls:dollarVal];
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

- (void) setAlphaControls: (double) alpha alphaInverse: (double) alphaInverse{
	[super setAlphaControls:alpha alphaInverse:alphaInverse];
	freqPaymentCtrl.alpha = alpha;
}

- (void) expandControls: (BOOL) expand{
	[super expandControls: expand];
	freqPaymentCtrl.hidden = expand;
}

- (void) freqPaymentChanged: (id) sender{
	PaymentFreqEnum paymentFreqVal;
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
	[[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];		
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) sendUpdateNotification{
	[[NSNotificationCenter defaultCenter] postNotificationName: @"paymentAmtAndUpdateChartChanged" object: self];		
}

-(void) sliderTouchUp: (id) sender{
	[self updateMinMaxLabels];
	[[NSNotificationCenter defaultCenter] postNotificationName: @"paymentAmtAndUpdateChartChanged" object: self];		
}

- (void)dealloc {
    [super dealloc];
}

@end

@implementation LumpSumNumberKeyPadSliderController

- (void)viewDidLoad {
	[super viewDidLoad];
	windowHieght = 320.0f;
}

@end
