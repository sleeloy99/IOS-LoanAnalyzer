//
//  EditablePropertyTableViewCell.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EditablePropertyTableViewCell : UITableViewCell {
	UILabel *nameLabel;
	UITextField *editingTextField;
	UIButton *clearBtn;	
}

-(IBAction) clear: (id) sender;
- (void)setData:(NSString*) name prop:(NSString *)prop;
- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UITextField *editingTextField;
@property (nonatomic, retain) UIButton *clearBtn;

@end
