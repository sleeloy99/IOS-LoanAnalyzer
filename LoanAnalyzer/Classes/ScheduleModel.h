//
//  ScheduleModel.h
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleElement.h"
#import "PaymentFreqObj.h"

@interface ScheduleModel : NSObject {
	NSMutableArray *schedule;
	NSMutableArray *horizontalLabels;
	NSMutableArray *currentArray, *currentNextArray, *currentPrevArray; 	
	NSDate *initDate;
	PaymentFreqEnum paymentFreq;
	int startYear;
	int numOfPayments;
	int currentIndex;
	
}
	
+(ScheduleModel *) instance;

-(void) initializeArray: (BOOL) mode;
-(ScheduleElement *) getElement: (int) index;
-(int) verticalCount;
-(int) horizontalCount;
-(NSString *) getHorizontalLabel;
-(NSString *) getVerticalLabel:(int) index;;
-(NSString *) getNextHorizontalLabel;
-(NSString *) getPrevHorizontalLabel;
-(BOOL)canMoveRight;
-(BOOL)canMoveLeft;

-(int) getNumOfPayments;
-(NSMutableArray *) getSchedule;
-(ScheduleElement *) getPrevElement: (int) index;
-(ScheduleElement *) getNextElement: (int) index;
-(ScheduleElement *) getElement: (int) index ;
-(ScheduleElement *) getElementFromArray: (NSMutableArray *) array objectAtIndex:(int)objectAtIndex;

-(void)swipeLeft;
-(void)swipeRight;
-(void)updateArrays;

@property(nonatomic, retain) NSMutableArray *schedule;
@property(nonatomic, retain) NSDate *initDate;

@end
