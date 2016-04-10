//
//  ScheduleViewViewController.h
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright cellinova inc 2009. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIHorizontalView.h"
#import "ScheduleModel.h"
#import "HeaderUIView.h"
#import "TwoBarChartController.h"
#import "ModelObject.h"

@interface ScheduleViewViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISwipeHorizontally> {
	UIHorizontalView *mainTableView;
	ScheduleViewViewController* delegate;	
	ScheduleModel *tableModel;
	IBOutlet HeaderUIView *headerView;
	BOOL stillPressed;
	BOOL scheduleMode;
	NSTimer *_timer;
	TwoBarChartController *chartController;	
	IBOutlet UIActivityIndicatorView *progressIndicator;
	int visibleRows;
}
@property (nonatomic, assign /* for weak ref*/) ScheduleViewViewController* delegate;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (nonatomic, retain) IBOutlet HeaderUIView *headerView;

- (id)initWithNibNameTableModel:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)resetView;
- (void) continousLeft: (NSNotification *) notification;
- (void) continousEnd: (NSNotification *) notification;
- (void)timerRight:(NSTimer *)theTimer;
- (void)timerLeft:(NSTimer *)theTimer;

@end

