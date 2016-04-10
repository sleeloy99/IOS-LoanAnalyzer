//
//  NumberSliderKeyPadViewController.h
//  
//
//  Created by Sheldon Lee-Loy on 2/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGradientView.h"
#import "ModelObject.h"
#import "SliderViewControllerKeyPad.h"

@interface NumberSliderKeyPadViewController : SliderViewControllerKeyPad {
	IBOutlet UIButton *btnOne, *btnTwo, *btnThree, *btnFour, *btnFive, *btnSix, *btnSeven, *btnEight, *btnNine, *btnDecimal, *btnReturn, *btnZero;	
	IBOutlet UIButton *btnStatusBar;
	IBOutlet UILabel *labelValue;	
	IBOutlet UITwoModeGradientView *twoModeView;
	DollarObject *dollarObject;
	float windowHieght;
	UIImageView *imgView;
	IBOutlet UIButton *upImageBtn;
	
	BOOL isLoaded;
	BOOL isExpanded;
	
	double minLimit;
	double maxLimit;
	double minValue;	
	double maxValue;
	double increment;
	double numberValue;		
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
- (void) setLabelText: (NSString*) label;
- (void) setAlphaControls: (double) alpha alphaInverse: (double) alphaInverse;
- (void) expandControls:(BOOL)expand;
-(void) setIsExpanded: (BOOL) expand;
-(BOOL) getIsExpanded;
-(void) expandView: (BOOL) expand;
- (void) expandSelectedView: (id) sender;
-(double) trueValue;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dollarObj: (DollarObject *) dollaryObj;
- (void) setControls: (DollarObject *) dollarVal;
- (void) sendUpdateNotification;

@property (nonatomic, retain) IBOutlet UIButton *btnStatusBar, *upImageBtn;
@property (nonatomic, retain) IBOutlet UIButton *btnOne, *btnTwo, *btnThree, *btnFour, *btnFive, *btnSix, *btnSeven, *btnEight, *btnNine, *btnDecimal, *btnReturn, *btnZero;
@property (nonatomic, retain) IBOutlet UILabel *labelValue;
@property (nonatomic, retain) IBOutlet UITwoModeGradientView *twoModeView;
@property double minLimit, maxLimit;

@end
