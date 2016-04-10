//
//  SliderViewControllerKeyPad.h
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelObject.h"
#import "PopupViewController.h"

@interface SliderViewControllerKeyPad : PopupViewController {
	IBOutlet UILabel *maxLbl, *minLbl;
	IBOutlet UISlider *slider;	
}

- (void) initializeSliderMinMax;
-(void) updateMinMaxLabels;
-(void) sliderTouchUp: (id) sender;
- (void) slideEvent: (id) sender;
	
@property (nonatomic, retain) IBOutlet UILabel *minLbl, *maxLbl;
@property (nonatomic, retain) IBOutlet UISlider *slider;
@end
