//
//  LumpSumFrequencyViewController.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/29/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupViewController.h"
#import "PaymentFreqObj.h"

@interface LumpSumFrequencyViewController : PopupViewController {
	IBOutlet UISegmentedControl *freqCtrl;
	IBOutlet UIButton *btnStatusBar;	
	LumpSumPeriodObj *lumpsumPeriod;
}

- (void) freqChanged: (id) sender;
- (id)initWithNibNameLumpsumPeriod:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  lumpsumPeriodVall:(LumpSumPeriodObj *) lumpsumPeriodVall;
- (void) setControls: (LumpSumPeriodObj *) lumpsumPeriodVal;

@property (nonatomic, retain) IBOutlet UISegmentedControl *freqCtrl;
@property (nonatomic, retain) IBOutlet UIButton *btnStatusBar;
@property (nonatomic, retain) IBOutlet LumpSumPeriodObj *lumpsumPeriod;
@end
