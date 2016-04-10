//
//  LoanObject.m
//
//  Created by Sheldon Lee-Loy on 2/10/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "LoanObject.h"
#import "ScheduleElement.h"

@implementation LoanObject

@synthesize startDate, uid, name, loanAmount, interestRate, lumpSums, amortization, paymentFreq, paymentAmount, ratePerPeriod, compoundPeriod, principalAmt, interestAmt;

- (id)init{
    if ((self = [super init])){
        self.loanAmount = [[[NotifyLoanAmt alloc] initWithDouble: 0.0] autorelease];
        self.interestRate = [[[NotifyRate alloc] initWithFloat: 0.0] autorelease];
        self.amortization = [[[AmortizationObj alloc] initWithYearMonth: 0 monthsAttr:0] autorelease];
        self.paymentFreq = [[[PaymentFreqObj alloc] initWith:MONTHLY] autorelease];
        self.paymentAmount = [[[NotifyPaymentAmt alloc] initWithDouble: 0] autorelease];
        self.ratePerPeriod = [[[PercentObject alloc] initWithFloat: 0.0] autorelease];
        self.principalAmt = [[[DollarObject alloc] initWithDouble: -1] autorelease];
        self.interestAmt = [[[DollarObject alloc] initWithDouble: -1] autorelease];
        self.compoundPeriod = [[[CompoundPeriodObj alloc] initWith:CMONTHLY] autorelease];
        self.lumpSums = [[[NSMutableArray alloc] init] autorelease];
        self.startDate = [[[DateObject alloc] initWithDate: [NSDate date] notifyChan: @"startdateChanged"] autorelease];
    }
    return self;
}

- (id)copyWithZone: (NSZone *) zone{
    LoanObject *newLoan = [[LoanObject allocWithZone: zone] init];
    newLoan.loanAmount = [[[NotifyLoanAmt alloc] initWithDouble: [loanAmount getDollarValue]] autorelease];
    newLoan.interestRate = [[[NotifyRate alloc] initWithFloat: [interestRate getPercentValue]] autorelease];
    newLoan.amortization = [[[AmortizationObj alloc] initWithYearMonth: [amortization getYears] monthsAttr:[amortization getMonths]] autorelease];
    newLoan.paymentFreq = [[[PaymentFreqObj alloc] initWith:[paymentFreq getFreqValue]] autorelease];
    newLoan.paymentAmount = [[[NotifyPaymentAmt alloc] initWithDouble: [paymentAmount getDollarValue]] autorelease];
    newLoan.ratePerPeriod = [[[PercentObject alloc] initWithFloat: [ratePerPeriod getPercentValue]] autorelease];
    newLoan.principalAmt = [[[DollarObject alloc] initWithDouble: [principalAmt getDollarValue]] autorelease];
    newLoan.interestAmt = [[[DollarObject alloc] initWithDouble: [interestAmt getDollarValue]] autorelease];
    newLoan.compoundPeriod = [[[CompoundPeriodObj alloc] initWith:[compoundPeriod getCompoundValue]] autorelease];
    newLoan.startDate = [[[DateObject alloc] initWithDate:[startDate getDateValue]  notifyChan: @"startdateChanged"] autorelease];
    newLoan.name = [[name copy] autorelease];
    newLoan.uid = uid;
    
    //need to copy Lump Sum array
    for (int x =0; x < [lumpSums count]; x++){
        LumpSum *lumpsum = [lumpSums objectAtIndex: x];
        LumpSum *newLump = [[LumpSum alloc]initWith:[lumpsum.value getDollarValue] lumpsumPeriodVal:[lumpsum.lumpsumPeriod getLumpSumValue] startDateVal:[lumpsum.duration.startDate getDateValue] endDateVal:[lumpsum.duration.endDate getDateValue]];
        
        [newLoan.lumpSums addObject: newLump];
        [newLump release];
    }
    
    return newLoan;
}

- (void)dealloc{
    if (lumpSumsTmp != nil){
        [lumpSumsTmp removeAllObjects];
        [lumpSumsTmp release];
        lumpSumsTmp = nil;
    }
    [loanAmount release];
    [amortization release];
    [paymentAmount release];
    [interestRate release];
    [paymentFreq release];
    [ratePerPeriod release];
    [interestAmt release];
    [principalAmt release];
    [compoundPeriod release];
    [name release];
    [startDate release];
    [lumpSums release];
    [super dealloc];
}

-(void) calculatePrincipalInterestAmtNoLumpsums{
    int numOfPaymentsPerYear = [paymentFreq getFreqValue];
    int amortizationValue = [amortization getYears]*numOfPaymentsPerYear+[amortization getMonths]*numOfPaymentsPerYear/12;
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:FALSE raiseOnOverflow:TRUE raiseOnUnderflow:TRUE raiseOnDivideByZero:TRUE];
    NSDecimalNumber *loanAmountTmp = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [loanAmount getDollarValue]] decimalValue]];
    NSDecimalNumber *amortizationValueNumber = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithInt:  amortizationValue] decimalValue]];
    NSDecimalNumber *paymentAmt = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [paymentAmount getDollarValue]] decimalValue]];
    NSDecimalNumber *balance = [paymentAmt decimalNumberByMultiplyingBy: amortizationValueNumber withBehavior:roundingBehavior];
    NSDecimalNumber *interestAmtTmp = [balance decimalNumberBySubtracting: loanAmountTmp withBehavior:roundingBehavior];
    
    [principalAmt setDollarValue: [loanAmountTmp doubleValue]];
    [interestAmt setDollarValue: [interestAmtTmp doubleValue]];
}

-(void) calculatePrincipalInterestAmt{
    
    if ([self.lumpSums count] == 0){
        [self calculatePrincipalInterestAmtNoLumpsums];
    }
    else{
        [self calculateRatePerPeriod];
        int numOfPaymentsPerYear, amortizationValue;
        
        NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:FALSE raiseOnOverflow:TRUE raiseOnUnderflow:TRUE raiseOnDivideByZero:TRUE];
        
        NSDecimalNumber *balance, *principalVal =[NSDecimalNumber zero],  *interestVal = [NSDecimalNumber zero];
        NSDecimalNumber *paymentAmt = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [paymentAmount getDollarValue]] decimalValue]];
        NSDecimalNumber *ratePerPeriodVal = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [ratePerPeriod getPercentValue]/100] decimalValue]];
        balance = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [loanAmount getDollarValue]] decimalValue]];
        
        numOfPaymentsPerYear = [paymentFreq getFreqValue];
        amortizationValue = [amortization getYears]*numOfPaymentsPerYear+[amortization getMonths]*numOfPaymentsPerYear/12;
        
        //	NSDate *paymentDate = [[startDate getDateValue] autorelease];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *nextDate = [[[startDate getDateValue] copy] autorelease];
        
        NSDate *nextBiDate = nil;
        switch (numOfPaymentsPerYear){
            case MONTHLY:
                [comps setMonth: 1];
                break;
            case BIMONTHLY:
                [comps setMonth: 1];
                NSDateComponents *bicomps = [[NSDateComponents alloc] init];
                [bicomps setDay: 14];
                nextBiDate = [gregorian dateByAddingComponents:bicomps toDate:nextDate options:0];
                [bicomps release];
                break;
            case WEEKLY:
                [comps setDay: 7];
                break;
            case BIWEEKLY:
                [comps setDay: 14];
                break;
                
            default:
                break;
        }
        
        [self resetLumpSums];
        for (int x = 0; x < amortizationValue; x++){
            
            //calculate lumpsum
            NSDecimalNumber *lumpsum =[NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [self getLumpSums: nextDate gregorian: gregorian]] decimalValue]];
            
            balance = [balance decimalNumberBySubtracting: lumpsum withBehavior:roundingBehavior];
            principalVal = [principalVal decimalNumberByAdding: lumpsum withBehavior:roundingBehavior];
            NSDecimalNumber *interestAmtTmp = [balance decimalNumberByMultiplyingBy: ratePerPeriodVal withBehavior:roundingBehavior];
            
            NSDecimalNumber *principalAmtTmp = [paymentAmt decimalNumberBySubtracting: interestAmtTmp withBehavior:roundingBehavior];
            interestVal = [interestVal decimalNumberByAdding: interestAmtTmp withBehavior:roundingBehavior];
            principalVal = [principalVal decimalNumberByAdding: principalAmtTmp withBehavior:roundingBehavior];
            balance = [balance decimalNumberBySubtracting: principalAmtTmp withBehavior:roundingBehavior];
            
            if ([balance doubleValue] <= 0 ) break;
            if ([principalVal doubleValue]> [loanAmount getDollarValue]) break;
            
            if (nextBiDate != nil){
                //need to update bi payment date
                /////////////////////////////////////////////////
                //check to see if we're in another year
                /////////////////////////////////////////////////
                
                //////////////////////////
                //Calculate Payment
                //////////////////////////
                //start calculations at start date
                NSDecimalNumber *lumpsum =[NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [self getLumpSums: nextBiDate gregorian: gregorian]] decimalValue]];
                
                balance = [balance decimalNumberBySubtracting: lumpsum withBehavior:roundingBehavior];
                principalVal = [principalVal decimalNumberByAdding: lumpsum withBehavior:roundingBehavior];
                NSDecimalNumber *interestAmtTmp = [balance decimalNumberByMultiplyingBy: ratePerPeriodVal withBehavior:roundingBehavior];
                
                NSDecimalNumber *principalAmtTmp = [paymentAmt decimalNumberBySubtracting: interestAmtTmp withBehavior:roundingBehavior];
                interestVal = [interestVal decimalNumberByAdding: interestAmtTmp withBehavior:roundingBehavior];
                principalVal = [principalVal decimalNumberByAdding: principalAmtTmp withBehavior:roundingBehavior];
                balance = [balance decimalNumberBySubtracting: principalAmtTmp withBehavior:roundingBehavior];
                
                if ([balance doubleValue] <= 0 ) break;
                if ([principalVal doubleValue] > [loanAmount getDollarValue]) break;
                //increment count by 1 since we've calculated a second payment
                x++;
                nextBiDate = [gregorian dateByAddingComponents:comps toDate:nextBiDate options:0];
            }
            nextDate = [gregorian dateByAddingComponents:comps toDate:nextDate options:0];
        }
        [principalAmt setDollarValue: [principalVal doubleValue]];
        [interestAmt setDollarValue: [interestVal doubleValue]];
        [comps release];
        [gregorian release];
    }
}

-(void)resetLumpSums{
    if (lumpSumsTmp != nil){
        [lumpSumsTmp removeAllObjects];
        [lumpSumsTmp release];
        lumpSumsTmp = nil;
    }
    lumpSumsTmp = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.lumpSums count]; x++){
        LumpSum *lumpsum = [self.lumpSums objectAtIndex: x];
        [lumpsum resetCurrentDate];
        [lumpSumsTmp addObject: lumpsum];
        
    }
}

-(double)getLumpSums: (NSDate *)paymentDate gregorian: (NSCalendar *)gregorian{
    double result = 0;
    NSMutableArray *removeObjects = nil;
    for (int x = 0; x < [lumpSumsTmp count]; x++){
        LumpSum *lumpsum = [lumpSumsTmp objectAtIndex: x];
        double tmpResult =[lumpsum getLumpSumFor: paymentDate gregorian:gregorian];
        if (tmpResult != -1){
            result += tmpResult;
        }
        else{
            if (removeObjects == nil){
                removeObjects  = [[NSMutableArray alloc] init];
            }
            [removeObjects addObject: lumpsum];
        }
    }
    if (removeObjects != nil){
        //remove objects from lumpSumsTmp
        for (int x = 0; x < [removeObjects count]; x++){
            [lumpSumsTmp removeObject: [removeObjects objectAtIndex: x]];
        }
        [removeObjects release];
    }
    return result;
}

-(void) populateYears:(NSMutableArray *) years numOfYears:(int) numOfYears{
    NSCalendar *gregorian = nil;
    NSDateComponents  *initcomps = nil;
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    initcomps = [gregorian components: NSYearCalendarUnit fromDate: [startDate getDateValue]];
    
    int intialYear = (int)[initcomps year];
    
    for (int x = 0; x < numOfYears; x++){
        [years addObject: [NSString stringWithFormat: @"%d", (intialYear+x)]];
    }
    [gregorian release];
}

-(int) populateSchedule:(NSMutableArray *) schedule mode:(BOOL)mode{
    
    int numOfPayments = 0;
    
    [self calculateRatePerPeriod];
    int numOfPaymentsPerYear, amortizationValue;
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:FALSE raiseOnOverflow:TRUE raiseOnUnderflow:TRUE raiseOnDivideByZero:TRUE];
    
    NSDecimalNumber *balance, *principalVal =[NSDecimalNumber zero],  *interestVal = [NSDecimalNumber zero];
    NSDecimalNumber *paymentAmt = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [paymentAmount getDollarValue]] decimalValue]];
    NSDecimalNumber *ratePerPeriodVal = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [ratePerPeriod getPercentValue]/100] decimalValue]];
    
    balance = [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [loanAmount getDollarValue]] decimalValue]];
    numOfPaymentsPerYear = [paymentFreq getFreqValue];
    amortizationValue = [amortization getYears]*numOfPaymentsPerYear+[amortization getMonths]*numOfPaymentsPerYear/12;
    int numOfPaymentsPerYearCount = 0;
    NSMutableArray *schedulePerYear = [[NSMutableArray alloc] init];
    [schedule addObject: schedulePerYear];
    //set up payment frequence increment
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *initcomps = [gregorian components: NSYearCalendarUnit fromDate: [startDate getDateValue]];
    
    NSDate *paymentDate = [startDate getDateValue];
    NSDate *nextDate = [startDate getDateValue];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSDate *biPaymentDate = nil;
    NSDate *nextBiDate = [startDate getDateValue];
    
    if (numOfPaymentsPerYear == MONTHLY)
        [comps setMonth: 1];
    else if (numOfPaymentsPerYear == BIMONTHLY){
        [comps setMonth: 1];
        NSDateComponents *bicomps = [[NSDateComponents alloc] init];
        [bicomps setDay: 14];
        biPaymentDate = [startDate getDateValue];
        biPaymentDate = [gregorian dateByAddingComponents:bicomps toDate:nextDate options:0];
        [bicomps release];
        nextBiDate = [gregorian dateByAddingComponents:comps toDate:nextBiDate options:0];
    }
    else if (numOfPaymentsPerYear == WEEKLY)
        [comps setDay: 7];
    else if (numOfPaymentsPerYear == BIWEEKLY)
        [comps setDay: 14];
    
    int startYear = (int)[initcomps year];
    [self resetLumpSums];
    
    for (int x = 0; x < amortizationValue; x++){
        
        /////////////////////////////////////////////////
        //check to see if we're in another year
        /////////////////////////////////////////////////
        NSDateComponents *paymentYear = [gregorian components: NSYearCalendarUnit fromDate: paymentDate];
        
        if (startYear != [paymentYear year]){
            startYear++;
            if (schedulePerYear != nil)
                [schedulePerYear release];
            schedulePerYear = [[NSMutableArray alloc] init];
            [schedule addObject: schedulePerYear];
            numOfPaymentsPerYearCount=0;
        }
        
        //////////////////////////
        //Calculate Payment
        //////////////////////////
        //start calculations at start date
        NSDecimalNumber *lumpsum =[NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [self getLumpSums: nextDate gregorian: gregorian]] decimalValue]];
        
        balance = [balance decimalNumberBySubtracting: lumpsum withBehavior:roundingBehavior];
        principalVal = [principalVal decimalNumberByAdding: lumpsum withBehavior:roundingBehavior];
        NSDecimalNumber *interestAmtTmp = [balance decimalNumberByMultiplyingBy: ratePerPeriodVal withBehavior:roundingBehavior];
        
        NSDecimalNumber *principalAmtTmp = [paymentAmt decimalNumberBySubtracting: interestAmtTmp withBehavior:roundingBehavior];
        
        interestVal = [interestVal decimalNumberByAdding: interestAmtTmp withBehavior:roundingBehavior];
        principalVal = [principalVal decimalNumberByAdding: principalAmtTmp withBehavior:roundingBehavior];
        balance = [balance decimalNumberBySubtracting: principalAmtTmp withBehavior:roundingBehavior];
        
        numOfPaymentsPerYearCount++;
        numOfPayments++;
        ScheduleElement *elem = nil;
        if (mode)
            elem = [[ScheduleElement alloc] initWithValue: [interestAmtTmp doubleValue] pricipalValue: [principalAmtTmp doubleValue] balanceValue: [balance doubleValue] lumpsumValue: [lumpsum doubleValue]];
        else
            elem = [[ScheduleElement alloc] initWithValue: [interestVal doubleValue] pricipalValue: [principalVal doubleValue] balanceValue: [balance doubleValue] lumpsumValue: [lumpsum doubleValue]];
        elem.paymentDate = paymentDate;
        [schedulePerYear addObject: elem];
        [elem release];
        paymentDate = [gregorian dateByAddingComponents:comps toDate:paymentDate options:0];
        
        if ([balance doubleValue] <= 0 ) break;
        if ([principalVal doubleValue] > [loanAmount getDollarValue]) break;
        
        if (biPaymentDate != nil){
            //need to update bi payment date
            /////////////////////////////////////////////////
            //check to see if we're in another year
            /////////////////////////////////////////////////
            
            paymentYear = [gregorian components: NSYearCalendarUnit fromDate: biPaymentDate];
            
            if (startYear != [paymentYear year]){
                startYear++;
                if (schedulePerYear != nil)
                    [schedulePerYear release];
                schedulePerYear = [[NSMutableArray alloc] init];
                [schedule addObject: schedulePerYear];
                numOfPaymentsPerYearCount=0;
            }
            
            //////////////////////////
            //Calculate Payment
            //////////////////////////
            //start calculations at start date
            lumpsum =[NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [self getLumpSums: nextBiDate gregorian: gregorian]] decimalValue]];
            
            balance = [balance decimalNumberBySubtracting: lumpsum withBehavior:roundingBehavior];
            principalVal = [principalVal decimalNumberByAdding: lumpsum withBehavior:roundingBehavior];
            interestAmtTmp = [balance decimalNumberByMultiplyingBy: ratePerPeriodVal withBehavior:roundingBehavior];
            
            principalAmtTmp = [paymentAmt decimalNumberBySubtracting: interestAmtTmp withBehavior:roundingBehavior];
            
            interestVal = [interestVal decimalNumberByAdding: interestAmtTmp withBehavior:roundingBehavior];
            principalVal = [principalVal decimalNumberByAdding: principalAmtTmp withBehavior:roundingBehavior];
            balance = [balance decimalNumberBySubtracting: principalAmtTmp withBehavior:roundingBehavior];
            
            numOfPaymentsPerYearCount++;
            numOfPayments++;
            if (mode)
                elem = [[ScheduleElement alloc] initWithValue: [interestAmtTmp doubleValue] pricipalValue: [principalAmtTmp doubleValue] balanceValue: [balance doubleValue] lumpsumValue: [lumpsum doubleValue]];
            else
                elem = [[ScheduleElement alloc] initWithValue: [interestVal doubleValue] pricipalValue: [principalVal doubleValue] balanceValue: [balance doubleValue] lumpsumValue: [lumpsum doubleValue]];
            elem.paymentDate = biPaymentDate;
            [schedulePerYear addObject: elem];
            [elem release];
            biPaymentDate = [gregorian dateByAddingComponents:comps toDate:biPaymentDate options:0];
            
            if ([balance doubleValue] <= 0 ) break;
            if ([principalVal doubleValue] > [loanAmount getDollarValue]) break;
            //increment count by 1 since we've calculated a second payment
            x++;
        }
        
        nextDate = [gregorian dateByAddingComponents:comps toDate:nextDate options:0];
    }
    if (schedulePerYear != nil)
        [schedulePerYear release];
    [gregorian release];
    [comps release];
    return numOfPayments;
}

-(PercentObject *) calculateRatePerPeriod{    
    double result, rate;
    double numOfPaymentsPerYear, numOfCompoundPerYear;
    
    numOfPaymentsPerYear = [paymentFreq getFreqValue];
    numOfCompoundPerYear = [compoundPeriod getCompoundValue];
    rate = [interestRate getPercentValue]/100;
    
    result = pow((1.0f + rate/numOfCompoundPerYear), numOfCompoundPerYear/numOfPaymentsPerYear) - 1.0f;
    [ratePerPeriod setPercentValue: result*100];
    
    return ratePerPeriod;
}

-(void) calculateAmortization{
    
    double rate = [ratePerPeriod getPercentValue]/100.0f;
    double amortizationVal = -1.0f*log(1-[loanAmount getDollarValue]*rate/[paymentAmount getDollarValue])/log(1+rate);
    double year;
    int numOfPaymentsPerYear = [paymentFreq getFreqValue];
    int monthDivider = 1;
    if (numOfPaymentsPerYear == BIMONTHLY)
        monthDivider = 2;
    else if (numOfPaymentsPerYear == WEEKLY)
        monthDivider = 4;
    else if (numOfPaymentsPerYear == BIWEEKLY)
        monthDivider = 2;
    
    modf(amortizationVal/numOfPaymentsPerYear, &year);
    double mounth = floor(fmod(amortizationVal, numOfPaymentsPerYear)/monthDivider)+1.0f;
    [amortization setYears: (int)year];
    [amortization setMonths: (int)mounth];
}

-(DollarObject *) calculateLoanAmt{
    double result;
    double rate;
    [self calculateRatePerPeriod];
    float numOfPaymentsPerYear = [paymentFreq getFreqValue];
    float amortizationValue = [amortization getYears]*numOfPaymentsPerYear+[amortization getMonths]*numOfPaymentsPerYear/12.0f;
    rate = [ratePerPeriod getPercentValue]/100.0f;
    result = [paymentAmount getDollarValue]/(rate*(pow((1.0f+rate), amortizationValue)))/((pow((1.0f+rate),amortizationValue))-1.0f);
    
    result = roundf(result*10.0f)/10.0f;
    [loanAmount setDollarValue: result];
    
    return loanAmount;	
}

-(DollarObject *) calculatePaymentAmt{
    NSDecimalNumber *result;
    float rate;
    [self calculateRatePerPeriod];		
    float numOfPaymentsPerYear = [paymentFreq getFreqValue];
    float amortizationValue = [amortization getYears]*numOfPaymentsPerYear+[amortization getMonths]*numOfPaymentsPerYear/12.0f;
    rate = [ratePerPeriod getPercentValue]/100.0f;
    if (rate != 0){
        result = [[NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble: [loanAmount getDollarValue]] decimalValue]] 
                  decimalNumberByMultiplyingBy:
                  [NSDecimalNumber decimalNumberWithDecimal: [[NSNumber numberWithDouble:
                                                               (rate*(pow((1.0f+rate), amortizationValue)))/((pow((1.0f+rate),amortizationValue))-1.0f)] decimalValue]]
                  ] ;   
        
        
        NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:FALSE raiseOnOverflow:TRUE raiseOnUnderflow:TRUE raiseOnDivideByZero:TRUE];
        [paymentAmount setDollarValue: [[result decimalNumberByRoundingAccordingToBehavior: roundingBehavior] doubleValue]];
    }
    return paymentAmount;	
}

@end
