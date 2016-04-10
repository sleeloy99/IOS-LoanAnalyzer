//
//  PercentKeyPadViewController.h
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SliderViewControllerKeyPad.h"
#import "UIGradientView.h"

/// Key IDS
extern NSInteger const DECIMAL_KEY_ID;
extern NSInteger const RETURN_KEY_ID;

/// SLIDER CONSTANTS
extern NSInteger const MINMAX_SLIDER_PRECISION;
extern NSInteger const MINMAX_SLIDER_PRECENT_FACTOR;

@interface PercentKeyPadViewController : SliderViewControllerKeyPad {
	float numberValue;	
	float minValue;	
	float maxValue;
	float increment;
	NSString *displayStr;
	BOOL decimalPlace;
	IBOutlet UIButton *btnOne, *btnTwo, *btnThree, *btnFour, *btnFive, *btnSix, *btnSeven, *btnEight, *btnNine, *btnDecimal, *btnReturn, *btnZero;
	IBOutlet UISegmentedControl *compoundPeriodCtrl;
	IBOutlet UIButton *btnStatusBar;	
	IBOutlet UITwoModeGradientView *twoModeView;
	IBOutlet UILabel *labelValue, *cmpLbl;	
	IBOutlet UIButton *upImageBtn;
	float windowHieght;
	UIImageView *imgView;
	BOOL isLoaded;
	BOOL isExpanded;
}


- (IBAction) pressZero:(id) sender;
- (IBAction) pressOne:(id) sender;
- (IBAction) pressTwo:(id) sender;
- (IBAction) pressThree:(id) sender;
- (IBAction) pressFour:(id) sender;
- (IBAction) pressFive:(id) sender;
- (IBAction) pressSix:(id) sender;
- (IBAction) pressSeven:(id) sender;
- (IBAction) pressEight:(id) sender;
- (IBAction) pressNine:(id) sender;
- (IBAction) pressDecimal:(id) sender;
- (IBAction) pressReturn:(id) sender;

- (void) keyPressed:(int) value;
- (void) setAlphaControls: (double) alpha alphaInverse: (double) alphaInverse;
- (void) expandControls:(BOOL)expand;
- (void) setIsExpanded: (BOOL) expand;
- (BOOL) getIsExpanded;
- (void) expandView: (BOOL) expand;
- (void) expandSelectedView: (id) sender;
- (float) trueValue;
- (void) compoundPeriodChanged: (id) sender;
- (void) sendUpdateNotification;

@property (nonatomic, retain) NSString *displayStr;
@property (nonatomic, retain) IBOutlet UISegmentedControl *compoundPeriodCtrl;
@property (nonatomic, retain) IBOutlet UIButton *btnStatusBar, *upImageBtn;
@property (nonatomic, retain) IBOutlet UILabel *labelValue, *cmpLbl;
@property (nonatomic, retain) IBOutlet UIButton *btnOne, *btnTwo, *btnThree, *btnFour, *btnFive, *btnSix, *btnSeven, *btnEight, *btnNine, *btnDecimal, *btnReturn, *btnZero;
@property (nonatomic, retain) IBOutlet UITwoModeGradientView *twoModeView;

@end
