//
//  ScheduleElement.m
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "ScheduleElement.h"


@implementation ScheduleElement

@synthesize paymentDate;

- (id)initWithEmpty
{
	if ((self = [super init])){
		isEmpty = YES;
		pricipalAmount = 0;
		interestAmount = 0;
		balance= 0;
		lumpsum = 0;
	}
	return self;
}


- (id)initWithValue: (double) interestVal pricipalValue: (double) pricipalValue balanceValue: (double) balanceValue lumpsumValue: (double) lumpsumValue
{
	if ((self = [super init])){
		isEmpty = NO;
		pricipalAmount = pricipalValue;
		interestAmount = interestVal;
		balance= balanceValue;
		lumpsum = lumpsumValue;
	}
	return self;
}

-(double) getInterestAmt{
	return interestAmount;
}
-(double) getPrincipalAmt{
	return pricipalAmount;
}
-(double) getBalanceAmt{
	return balance;
}

-(NSString *)getDateDisplay{
	if (self.paymentDate == nil)
		return @"";
	NSDateFormatter *aFormatter = [[NSDateFormatter alloc] init];
	[aFormatter setDateFormat: @"MMM dd"];	
	NSString *returnVal = [aFormatter stringFromDate: self.paymentDate];
	[aFormatter release];
	return returnVal;
}

-(NSString *)getShortDateDisplay{
	if (self.paymentDate == nil)
		return @"";
	NSDateFormatter *aFormatter = [[NSDateFormatter alloc] init];
	[aFormatter setDateFormat: @"d/M/YY"];	
	NSString *returnVal = [aFormatter stringFromDate: self.paymentDate];
	[aFormatter release];
	return returnVal;
}
- (double) interestPercent{
	if (isEmpty) return 0;
	return interestAmount/pricipalAmount;
}

-(NSString *)getPrincipalAmountDisplay{
	if (isEmpty) return @"";
	NSNumber *aNumber = [NSNumber numberWithDouble: pricipalAmount];
	NSNumberFormatter *aFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	
	[aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
	
	return [aFormatter stringFromNumber: aNumber];
}

-(NSString *)getInterestAmountDisplay{
	if (isEmpty) return @"";
	NSNumber *aNumber = [NSNumber numberWithDouble: interestAmount];
	NSNumberFormatter *aFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	
	[aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
	
	return [aFormatter stringFromNumber: aNumber];
}

-(NSString *)getBalanceDisplay{
	if (isEmpty) return @"";
	NSNumber *aNumber = [NSNumber numberWithDouble: balance];
	NSNumberFormatter *aFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	
	[aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
	
	return [aFormatter stringFromNumber: aNumber];	
}

-(NSString *)getLumpSumDisplay{
	if ((isEmpty) || (lumpsum ==0)) return @"";
	
	NSNumber *aNumber = [NSNumber numberWithDouble: lumpsum];
	NSNumberFormatter *aFormatter = [[[NSNumberFormatter alloc] init] autorelease];
	
	[aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
	
	return [aFormatter stringFromNumber: aNumber];
}

- (void) dealloc{
	[paymentDate release];
	[super dealloc];
}

@end
