//
//  HeaderUIView.h
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"
#import "UISwipeHorizontally.h"
#import "UIHoldDownButton.h"

@interface HeaderUIView : UIView {
	UILabel *nameLabel;
	UILabel *nameLabelLeft;
	UILabel *nameLabelRight;
	UIHoldDownButton *prevButton, *nextButton;
	id <UISwipeHorizontally>  detailController;		
	BOOL animateDone;
	BOOL stillPressed;
}

-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
- (void)updateHeader;
- (void) updateContent: (NSNotification *) notification;
- (void) moveLeft: (NSNotification *) notification;
- (void) moveRight: (NSNotification *) notification;
- (void) moveLbls: (float) direction;

-(IBAction) swipeLeft: (id) sender;
-(IBAction) swipeRight: (id) sender;
	
- (void)animationDone:(NSString*) animationID finished:(NSNumber *)finished context:(void *)context;
- (void)viewDidLoad;

@property(nonatomic, retain) UIHoldDownButton *prevButton, *nextButton;
@property (nonatomic, assign) id <UISwipeHorizontally> detailController;
@property BOOL stillPressed;

@end
