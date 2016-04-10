//
//  PropertyTableViewCell.h
//  
//
//  Created by Sheldon Lee-Loy on 2/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"

@protocol UIToggleLockPressed

-(void) toggleLockPressed: (id) sender;
@end

@interface PropertyTableViewCell : UITableViewCell {
	UILabel *nameLabel;
	UILabel *valueLabel;
	UILabel *secondValueLabel;
	UILabel *diffValueLabel;
	UIImageView *arrowDown, *arrowUp;
	UIButton *lock;
	BOOL hasValue, canLock, hasDiffValue;
	BOOL isLock;
	id <UIToggleLockPressed>  delegate;		
}

@property (nonatomic, retain) UIButton *lock;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *valueLabel;
@property (nonatomic, retain) UILabel *secondValueLabel;
@property (nonatomic, retain) UILabel *diffValueLabel;

@property BOOL hasValue, canLock, isLock, hasDiffValue;
@property (nonatomic, assign) id <UIToggleLockPressed> delegate;

- (void)resetData;
- (void)resetData:(NSString*) name prop:(id<FormatObject>)prop;
- (void)resetData:(NSString*) name prop:(id<FormatObject>)prop  prop2:(id<FormatObject>)prop2;
- (void)setProp:(id<FormatObject>)prop;
- (void)setPropDiff:(id<FormatObject>)prop orgin:(id<FormatObject>)orgin;
- (void)setSecondProp:(id<FormatObject>)prop;
- (IBAction) toggleLock: (id) sender;
- (void) setLockVal: (BOOL) lockVal;
	
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hasVal:(BOOL)hasVal canLockVal: (BOOL)canLockVal hasDiffVal: (BOOL)hasDiffVal;
@end
