//
//  PaymentFreqObj.h
//  Test3
//
//  Created by user user on 2/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
/*
typedef enum {MONTHLY = 12, BIMONTHLY = 24, WEEKLY = 52, BIWEEKLY= 26} PaymentFreqEnum;
typedef enum {CMONTHLY = 12, CANNUAL = 1, CSEMIANNUAL = 2} CompoundPeriodEnum;
typedef enum {LUMPMONTHLY = 12, LUMPANNUAL = 1, LUMPNONE = 0} LumpSumPeriodEnum;

@protocol FormatObject<NSObject>

@required
- (NSString *)displayString;
- (NSString *)displayDiffString: (id)original;
- (double)getDiff: (id)original;
@end

@interface LumpSumPeriodObj : NSObject<FormatObject> {
	LumpSumPeriodEnum value;
}

- (id)initWith: (LumpSumPeriodEnum)lumpSumPeriod;
- (void)setLumpSumValue: (LumpSumPeriodEnum) lumpSumValue;
- (LumpSumPeriodEnum)getLumpSumValue;

@end


@interface DateObject : NSObject<FormatObject> {
	NSDate *value;
	NSString *notifychannel;	
}

-(NSString *)getSQLDateStr;
- (NSDate *)getDateValue;
- (void)setDateValueStr: (NSString *) dateVal;
- (void)setDateValue: (NSDate *) dateVal;
- (id)initWithDate: (NSDate*) dateVal notifyChan: (NSString *) notifyChan;

@property (nonatomic, retain) NSString *notifychannel;
@property (nonatomic, retain) NSDate *value;

@end

@interface DurationObject : NSObject<FormatObject> 
{
	DateObject *startDate;
	DateObject *endDate;
}
- (id)initWithDates: (NSDate *) startDateVal endDateVal: (NSDate *)endDateVal;
@property (nonatomic, retain) DateObject *startDate;
@property (nonatomic, retain) DateObject *endDate;


@end

@interface CompoundPeriodObj : NSObject<FormatObject> {
	CompoundPeriodEnum value;
}

- (id)initWith: (CompoundPeriodEnum) compoundPeriod;
- (void)setCompoundValue: (CompoundPeriodEnum) compoundValue;
- (CompoundPeriodEnum)getCompoundValue;

@end

@interface PaymentFreqObj : NSObject<FormatObject> {
	PaymentFreqEnum value;
}

- (id)initWith: (PaymentFreqEnum) paymentFreq;
- (void)setFreqValue: (PaymentFreqEnum) freqValue;
- (PaymentFreqEnum)getFreqValue;

@end

@interface PercentObject : NSObject<FormatObject> {
	float value;
}

- (id)initWithFloat: (float) percent;
- (void)setPercentValue: (float) percent;
- (float)getPercentValue;

@end


@interface DollarObject : NSObject<FormatObject> {
	double value;
}

- (id)initWithDouble: (double) dollar;
- (void)setDollarValue: (double) dollar;
- (double)getDollarValue;

@end

@interface NotifyDollarObject : DollarObject {
	NSString *notifychannel;
}

- (id)initWith: (double) dollar notifyChan: (NSString *) notifyChan;
@property (nonatomic, retain) NSString *notifychannel;
@end

@interface AmortizationObj : NSObject<FormatObject>{
	int months;
	int years;
	BOOL paymentAmtLock;
}

@property BOOL paymentAmtLock;

- (NSString *)displayStringShort;	
- (id)initWithYearMonth: (int)yearsAttr monthsAttr:(int)monthsAttr;
- (int)getYears;
- (void)setYears: (int) yearsAttr;
- (int)getMonths;
- (void)setMonths: (int) monthsAttr;

@end


@interface NotifyRate : PercentObject {
}
@end

@interface NotifyLoanAmt : DollarObject {
	BOOL paymentAmtLock;
}

@property BOOL paymentAmtLock;
@end

@interface NotifyPaymentAmt : DollarObject {
	BOOL loanAmtLock;
}

- (NSString *) monthlyAmtDisplayStringShort: (PaymentFreqEnum) paymentFreq;
- (NSString *) monthlyAmtDisplayString: (PaymentFreqEnum) paymentFreq;
- (double) monthlyAmt: (PaymentFreqEnum) paymentFreq;

@property BOOL loanAmtLock;

@end

@interface LumpSum: NSObject
{
	DurationObject *duration;
	LumpSumPeriodObj *lumpsumPeriod;
	NotifyDollarObject *value;
	NSDate *currentDate;
	NSDateComponents *comps;
	BOOL paid;
}
- (id)initWith: (double)valueval lumpsumPeriodVal: (LumpSumPeriodEnum)lumpsumPeriodVal startDateVal:(NSDate *) startDateVal endDateVal: (NSDate *)endDateVal;
- (void)resetCurrentDate;
- (double)getLumpSumFor: (NSDate *) paymentDate gregorian: (NSCalendar *)gregorian;
@property (nonatomic, retain) NSDate *currentDate;
@property (nonatomic, retain) NSDateComponents *comps;
@property (nonatomic, retain) DurationObject *duration;
@property (nonatomic, retain) LumpSumPeriodObj *lumpsumPeriod;
@property (nonatomic, retain) NotifyDollarObject *value;
@property BOOL paid;

@end
*/