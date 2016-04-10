//
//  AmortizationKeyPadViewController.h
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelObject.h"
#import "PopupViewController.h"

@interface AmortizationKeyPadViewController : PopupViewController {
	IBOutlet UIButton *btnStatusBar;		
	IBOutlet UISlider *monthSlider, *yearSlider;	
}

- (void) slideEvent: (id) sender;
- (void) sliderTouchUp: (id) sender;

@property (nonatomic, retain) IBOutlet UISlider *monthSlider, *yearSlider;
@property (nonatomic, retain) IBOutlet UIButton *btnStatusBar;

@end
