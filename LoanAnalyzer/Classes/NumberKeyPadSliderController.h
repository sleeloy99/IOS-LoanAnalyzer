//
//  NumberKeyPadSliderController.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/27/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberSliderKeyPadViewController.h"
#import "ModelObject.h"

@interface NumberKeyPadSliderController : NumberSliderKeyPadViewController {
    IBOutlet UISegmentedControl *freqPaymentCtrl;
}

- (void) freqPaymentChanged: (id) sender;

@property (nonatomic, retain) IBOutlet UISegmentedControl *freqPaymentCtrl;

@end

@interface LumpSumNumberKeyPadSliderController : NumberKeyPadSliderController {
}
@end
