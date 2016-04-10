//
//  AmortizationKeyPad.h
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelObject.h"
#import "PopupViewController.h"

@interface PaymentFreqKeyPadViewController : PopupViewController {
	IBOutlet UISegmentedControl *freqPaymentCtrl;
	IBOutlet UIButton *btnStatusBar;		
}

- (void) freqPaymentChanged: (id) sender;

@property (nonatomic, retain) IBOutlet UISegmentedControl *freqPaymentCtrl;
@property (nonatomic, retain) IBOutlet UIButton *btnStatusBar;

@end
