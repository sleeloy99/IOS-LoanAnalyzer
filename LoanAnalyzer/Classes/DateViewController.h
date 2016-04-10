//
//  DateViewController.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupViewController.h"
#import "ModelObject.h"

@interface DateViewController :  PopupViewController {
	IBOutlet UIButton *btnStatusBar;		
	IBOutlet UIDatePicker *datePicker;
	DateObject *dateObj;
}

- (void) changeEvent: (id) sender;
- (void) setControls : (DateObject *) date;

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIButton *btnStatusBar;

@end