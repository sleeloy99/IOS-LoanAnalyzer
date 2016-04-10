//
//  LoanObject.h
//  
//
//  Created by Sheldon Lee-Loy on 2/10/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentFreqObj.h"

@interface LoanObject : NSObject<NSCopying> {

@public	
	NotifyLoanAmt *loanAmount;
	PercentObject *interestRate;
	AmortizationObj *amortization;
	PaymentFreqObj *paymentFreq;
	NotifyPaymentAmt *paymentAmount;
	PercentObject *ratePerPeriod;
	DollarObject *principalAmt;
	DollarObject *interestAmt;
	CompoundPeriodObj *compoundPeriod;
	NSMutableArray *lumpSums;
	NSMutableArray *lumpSumsTmp;
	DateObject *startDate;	
	NSString *name;
	int uid;
}

@property (nonatomic, retain) NSMutableArray *lumpSums;
@property (nonatomic, retain) NotifyLoanAmt *loanAmount;
@property (nonatomic, retain) PercentObject *interestRate;
@property (nonatomic, retain) AmortizationObj *amortization;
@property (nonatomic, retain) PaymentFreqObj *paymentFreq;
@property (nonatomic, retain) NotifyPaymentAmt *paymentAmount;
@property (nonatomic, retain) PercentObject *ratePerPeriod;
@property (nonatomic, retain) DollarObject *principalAmt;
@property (nonatomic, retain) CompoundPeriodObj *compoundPeriod;
@property (nonatomic, retain) DollarObject *interestAmt;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) DateObject *startDate;
@property int uid;

-(PercentObject *) calculateRatePerPeriod;
-(DollarObject *) calculateLoanAmt;
-(DollarObject *) calculatePaymentAmt;
-(int) populateSchedule:(NSMutableArray *) schedule mode:(BOOL)mode;
-(void) populateYears:(NSMutableArray *) years numOfYears:(int) numOfYears;
-(void) calculatePrincipalInterestAmt;
-(void) calculateAmortization;
-(void) resetLumpSums;
-(double) getLumpSums: (NSDate *)paymentDate gregorian:(NSCalendar *) gregorian;

@end
