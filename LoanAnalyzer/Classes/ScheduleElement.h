//
//  ScheduleElement.h
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScheduleElement : NSObject {
	double interestAmount;
	double pricipalAmount;
	double balance;
	double lumpsum;
	NSDate *paymentDate;
	BOOL isEmpty;
}

-(double) getInterestAmt;
-(double) getPrincipalAmt;
-(double) getBalanceAmt;

-(NSString *)getPrincipalAmountDisplay;
-(NSString *)getInterestAmountDisplay;
-(NSString *)getBalanceDisplay;
-(NSString *)getLumpSumDisplay;
-(NSString *)getDateDisplay;
-(NSString *)getShortDateDisplay;


- (id)initWithValue: (double) interestVal pricipalValue: (double) pricipalValue balanceValue: (double) balanceValue lumpsumValue: (double) lumpsumValue;
- (id)initWithEmpty;
- (double) interestPercent;

@property (nonatomic, retain) NSDate* paymentDate;
@end
