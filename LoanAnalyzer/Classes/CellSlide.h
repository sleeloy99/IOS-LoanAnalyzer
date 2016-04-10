//
//  CellSlide.h
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"

@interface CellSlide : UITableViewCell<UIScrollViewDelegate> {
	UILabel *nameLabel;
	UILabel *valueLabel;
	UILabel *secondValueLabel;
	
	UILabel *nameLabelLeft;
	UILabel *valueLabelLeft;
	UILabel *secondValueLabelLeft;	

	UILabel *nameLabelRight;
	UILabel *valueLabelRight;
	UILabel *secondValueLabelRight;	
	
	UILabel *lumpsumLabel;
	UILabel *lumpsumLabelRight;
	UILabel *lumpsumLabelLeft;
	
	UIScrollView *scrollView;
	UIImageView *bkg;
	
	UILabel *leftLabelTag;
	int index;
	
	BOOL animateDone;
}


//- (void)setData:(NSString*) name prop:(NSString*)prop  prop2:(NSString *)prop2;
- (void) moveLeft: (NSNotification *) notification;
- (void) moveRight: (NSNotification *) notification;
- (void) updateContent: (NSNotification *) notification;
- (void) moveLbls: (float) direction;
- (void) updateCells;
- (void)animationDone:(NSString*) animationID finished:(NSNumber *)finished context:(void *)context;
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
- (void) modifyCellFromLumpsum;
	
@property(nonatomic, retain) UILabel *leftLabelTag;
@property int index;

@end
