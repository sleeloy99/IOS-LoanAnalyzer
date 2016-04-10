//
//  PaymentFreqObj.m
//  
//
//  Created by Sheldon Lee-Loy on 2/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "PaymentFreqObj.h"

@implementation LumpSum

@synthesize duration, value, lumpsumPeriod, comps, currentDate, paid;

- (id)initWith: (double)valueval lumpsumPeriodVal: (LumpSumPeriodEnum)lumpsumPeriodVal startDateVal:(NSDate *) startDateVal endDateVal: (NSDate *)endDateVal{
    self = [super init];
    if (self){
        self.value = [[[NotifyDollarObject alloc] initWith:valueval notifyChan: @"lumpsumchanged"] autorelease];
        self.lumpsumPeriod = [[[LumpSumPeriodObj alloc] initWith: lumpsumPeriodVal] autorelease];
        self.duration = [[[DurationObject alloc] initWithDates:startDateVal endDateVal:endDateVal] autorelease];
    }
    return self;
}

- (void)resetCurrentDate{
    NSDate *startDateCopy= [[self.duration.startDate getDateValue] copy];
    self.currentDate = startDateCopy;
    [startDateCopy release];
    self.comps = [[[NSDateComponents alloc] init] autorelease];
    //reduce memory count by 1 since setter will retain
    if ([lumpsumPeriod getLumpSumValue] == LUMPMONTHLY)
        [self.comps setMonth: 1];
    else if ([lumpsumPeriod getLumpSumValue] == LUMPANNUAL)
        [self.comps setYear: 1];
}

- (double)getLumpSumFor: (NSDate *) paymentDate gregorian: (NSCalendar *)gregorian{
    
    double returnVal = 0;
    if (self.currentDate == nil)
        return -1;
    NSComparisonResult comparision = [[self.duration.endDate getDateValue] compare: self.currentDate];
    if (comparision == NSOrderedAscending){
        return -1;
    }
    comparision = [self.currentDate compare: paymentDate];
    while ((comparision == NSOrderedAscending) || (comparision == NSOrderedSame)){
        self.currentDate = [gregorian dateByAddingComponents:self.comps toDate:self.currentDate options:0];
        returnVal += [self.value getDollarValue];
        comparision = [self.currentDate compare: paymentDate];
        
        //only apply lump sum once if it doesn't repeat
        if ([lumpsumPeriod getLumpSumValue] == LUMPNONE){
            self.currentDate = nil;
            break;
        }
    }
    return returnVal;
}

- (void)dealloc {
    if (self.comps != nil){
        [self.comps release];
    }
    if (self.currentDate != nil){
        [self.currentDate release];
    }
    [self.lumpsumPeriod release];
    [self.value release];
    [self.duration release];
    [super dealloc];
}

@end

@implementation DateObject

@synthesize notifychannel, value;

- (id)initWithDate: (NSDate*) dateVal notifyChan: (NSString *) notifyChan{
    self = [super init];
    if (self){
        self.value = dateVal;
        self.notifychannel = notifyChan;
    }
    return self;
}

- (void)setDateValue: (NSDate *) dateVal{
    if ([self.value compare:dateVal]  != NSOrderedSame){
        self.value = dateVal;
        if (self.notifychannel != nil)
            [[NSNotificationCenter defaultCenter] postNotificationName: notifychannel object: self];
    }
    
}

- (NSDate *)getDateValue{
    return self.value;
}

- (void)setDateValueStr: (NSString *) dateVal{
    NSDateFormatter *aFormatter = [[NSDateFormatter alloc] init];
    [aFormatter setDateFormat: @"yyyy-MM-dd"];
    
    self.value  = [aFormatter dateFromString:dateVal];
    [aFormatter release];
}

-(NSString *)getSQLDateStr{
    NSString *returnValue;
    NSDateFormatter *aFormatter = [[NSDateFormatter alloc] init];
    [aFormatter setDateFormat: @"yyyy-MM-dd"];
    
    returnValue = [aFormatter stringFromDate: self.value];
    [aFormatter release];
    return returnValue;
}

- (NSString *)displayString{
    NSString *returnValue;
    NSDateFormatter *aFormatter = [[NSDateFormatter alloc] init];
    aFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    returnValue = [aFormatter stringFromDate: value];
    [aFormatter release];
    return returnValue;
}

- (NSString *)displayDiffString: (id)original{
    return @"";
}

- (double)getDiff: (id)original{
    return 0;
}

- (void)dealloc {
    [value release];
    [notifychannel release];
    [super dealloc];
}
@end


@implementation PaymentFreqObj

- (id)initWith: (PaymentFreqEnum) paymentFreq
{
    self = [super init];
    if (self)
        value = paymentFreq;
    return self;
}
- (NSString *)displayDiffString: (id)original{
    return @"";
}
- (double)getDiff: (id)original{
    return 0;
}

- (NSString *)displayString{
    switch(value){
        case MONTHLY:
            return @"Monthly";
        case BIMONTHLY:
            return @"Bi-Monthly";
        case WEEKLY:
            return @"Weekly";
        default:
            return @"Bi-Weekly";
    }
}

- (PaymentFreqEnum)getFreqValue{
    return value;
}

- (void)setFreqValue: (PaymentFreqEnum) freqValue{
    if (value != freqValue){
        value = freqValue;
        [[NSNotificationCenter defaultCenter] postNotificationName: @"paymentFreqChanged" object: self];
    }
}

@end

@implementation LumpSumPeriodObj

- (id)initWith: (LumpSumPeriodEnum)lumpSumPeriod
{
    self = [super init];
    if (self)
        value = lumpSumPeriod;
    return self;
}
- (double)getDiff: (id)original{
    return 0;
}

- (NSString *)displayDiffString: (id)original{
    return @"";
}
- (NSString *)displayString{
    switch(value){
        case LUMPMONTHLY:
            return @"Monthly";
        case LUMPANNUAL:
            return @"Yearly";
        default:
            return @"Never";
    }
}

- (LumpSumPeriodEnum)getLumpSumValue{
    return value;
}

- (void)setLumpSumValue: (LumpSumPeriodEnum) lumpSumValue{
    if (value != lumpSumValue){
        value = lumpSumValue;
        [[NSNotificationCenter defaultCenter] postNotificationName: @"lumpsumFreqChanged" object: self];
    }
}

@end

@implementation CompoundPeriodObj

- (id)initWith: (CompoundPeriodEnum) compoundPeriod{
    self = [super init];
    if (self)
        value = compoundPeriod;
    return self;
}

- (double)getDiff: (id)original{
    return 0;
}

- (NSString *)displayDiffString: (id)original{
    return @"";
}
- (NSString *)displayString{
    switch(value){
        case CMONTHLY:
            return @"Monthly";
        case CANNUAL:
            return @"Annual";
        default:
            return @"Semi-Annual";
    }
}

- (CompoundPeriodEnum)getCompoundValue{
    return value;
}

- (void)setCompoundValue: (CompoundPeriodEnum) compoundValue{
    if (value != compoundValue){
        value = compoundValue;
        [[NSNotificationCenter defaultCenter] postNotificationName: @"compoundPeriodChanged" object: self];
    }
}

@end

@implementation PercentObject

- (id)initWithFloat: (float) percent{
    self = [super init];
    
    if (self)
        value = percent;
    return self;
}

- (double)getDiff: (id)original{
    return  value-[((PercentObject*)original) getPercentValue];
}


- (NSString *)displayDiffString: (id)original{
    double diff = value-[((PercentObject*)original) getPercentValue];
    if (diff == 0)
        return @"";
    if (diff < 0)
        return [NSString stringWithFormat:@"-%.4f%%", diff*(-1)];
    return [NSString stringWithFormat:@"+%.4f%%", diff];
}

- (NSString *)displayString{
    return [NSString stringWithFormat:@"%.4f%%", value];
}

- (float)getPercentValue{
    return value;
}

- (void)setPercentValue: (float) percent{
    value = percent;
}
@end

@implementation DurationObject
@synthesize startDate, endDate;

- (id)initWithDates: (NSDate *) startDateVal endDateVal: (NSDate *)endDateVal{
    self = [super init];
    if (self){
        self.startDate = [[[DateObject alloc] initWithDate:startDateVal notifyChan:@"startdatelumpsumChanged"] autorelease];
        self.endDate = [[[DateObject alloc] initWithDate:endDateVal notifyChan:@"enddatelumpsumChanged"] autorelease];
    }
    return self;
}

- (NSString *)displayString{
    return [NSString stringWithFormat: @"%@ - %@", [self.startDate displayString], [self.endDate displayString]];
}

- (NSString *)displayDiffString: (id)original{
    return @"";
}
- (double)getDiff: (id)original{
    return 0;
}

- (void)dealloc {
    [self.startDate release];
    [self.endDate release];
    [super dealloc];
}

@end;

@implementation DollarObject

- (id)initWithDouble: (double) dollar{
    self = [super init];
    if (self){
        value = dollar;
    }
    return self;
}

- (double)getDiff: (id)original{
    return value - [((DollarObject*)original) getDollarValue];
}

- (NSString *)displayDiffString: (id)original{
    
    double diff = value - [((DollarObject*)original) getDollarValue];
    NSString *returnValue;
    NSNumber *aNumber;
    NSNumberFormatter *aFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    if (diff == 0){
        returnValue = @"";
    }
    else if (diff < 0){
        aNumber = [NSNumber numberWithDouble: diff*(-1)];
        NSString* formatStr = [aFormatter stringFromNumber: aNumber];
        returnValue = [[NSString alloc] initWithFormat: @"-%@",formatStr];
    }
    else{
        aNumber = [NSNumber numberWithDouble: diff];
        NSString* formatStr = [aFormatter stringFromNumber: aNumber];
        returnValue = [[NSString alloc] initWithFormat: @"+%@",formatStr];
    }
    return [returnValue autorelease];
}

- (NSString *)displayString{
    NSString *returnValue;
    NSNumber *aNumber = [NSNumber numberWithDouble: value];
    NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
    
    [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    returnValue = [aFormatter stringFromNumber: aNumber];
    [aFormatter release];
    return returnValue;
}

- (double)getDollarValue{
    return value;
}

- (void)setDollarValue: (double) dollar{
    value = dollar;
}

@end

@implementation AmortizationObj
@synthesize paymentAmtLock;

- (id)init{
    if (self = [super init]){
        // Initialization code
        paymentAmtLock = NO;
    }
    return self;
    
}

- (id)initWithYearMonth: (int)yearsAttr monthsAttr:(int)monthsAttr
{
    self = [super init];
    if (self){
        years = yearsAttr;
        months = monthsAttr;
    }
    return self;
}

- (double)getDiff: (id)original{
    return years*12+months - ([((AmortizationObj*)original) getYears]*12+[((AmortizationObj*)original) getMonths]);
}

- (NSString *)displayDiffString: (id)original{
    int diff = years*12+months - ([((AmortizationObj*)original) getYears]*12+[((AmortizationObj*)original) getMonths]);
    double dyear;
    modf(diff/12.0f, &dyear);
    double dmonth = floor(fmod(diff, 12.0f));
    int diffY = (int)dyear;
    int diffM = (int)dmonth;
    if ((diffY == 0) && (diffM !=0)){
        if (diffM > 0){
            return [[[NSString alloc] initWithFormat:@"+%d Months", diffM] autorelease];
        }
        return [[[NSString alloc] initWithFormat:@"%d Months", diffM] autorelease];
    }
    else if (diffY != 0) {
        if (diffM > 0)
            return [[[NSString alloc] initWithFormat:@"+%d Years %d Months", diffY, diffM] autorelease];
        return [[[NSString alloc] initWithFormat:@"%d Years %d Months", diffY, diffM] autorelease];
    }
    else{
        return @"";
    }
}

- (NSString *)displayStringShort{
    return [[[NSString alloc] initWithFormat:@"%d Y %d M", years, months] autorelease];
}

- (NSString *)displayString{
    return [[[NSString alloc] initWithFormat:@"%d Years %d Months", years, months] autorelease];
}

- (int)getYears{
    return years;
}

- (void)setYears: (int) yearsAttr{
    if (years != yearsAttr){
        years = yearsAttr;
        [[NSNotificationCenter defaultCenter] postNotificationName: @"yearChanged" object: self];
    }
}
- (int)getMonths{
    return months;
}

- (void)setMonths: (int) monthsAttr{
    if (months != monthsAttr){
        months = monthsAttr;
        [[NSNotificationCenter defaultCenter] postNotificationName: @"monthChanged" object: self];
    }
}

@end

@implementation NotifyRate
- (void)setPercentValue: (float) percent{
    if (value != percent){
        [super setPercentValue: percent];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"rateChanged" object: self];
    }
}
@end

@implementation NotifyLoanAmt

@synthesize paymentAmtLock;

- (id)init{
    if (self = [super init]) {
        // Initialization code
        paymentAmtLock = NO;
    }
    return self;
    
}

- (void)setDollarValue: (double) dollar{
    if (dollar != value){
        [super setDollarValue: dollar];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"loanAmtChanged" object: self];
    }
}
@end

@implementation NotifyDollarObject

@synthesize notifychannel;

- (id)initWith: (double) dollar notifyChan: (NSString *) notifyChan{
    self = [super initWithDouble: dollar];
    if (self)
        notifychannel = notifyChan;
    return self;
}

- (id)init{
    if (self = [super init]) {
        // Initialization code
    }
    return self;
}

- (void)setDollarValue: (double) dollar{
    if (dollar != value){
        [super setDollarValue: dollar];
        [[NSNotificationCenter defaultCenter] postNotificationName: notifychannel object: self];
    }
}

- (void)dealloc {
    [notifychannel release];
    [super dealloc];
}

@end

@implementation NotifyPaymentAmt

@synthesize loanAmtLock;

- (id)init{
    if (self = [super init]){
        // Initialization code
        loanAmtLock = YES;
    }
    return self;
    
}

- (void)setDollarValue: (double) dollar{
    if (dollar != value){
        [super setDollarValue: dollar];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"paymentAmtChanged" object: self];
    }
}

- (NSString *) monthlyAmtDisplayStringShort: (PaymentFreqEnum) paymentFreq{
    
    NSNumber *aNumber = [NSNumber numberWithDouble: [self monthlyAmt: paymentFreq]];
    NSNumberFormatter *aFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    
    [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    return [[[NSString alloc] initWithFormat: @"%@", [aFormatter stringFromNumber: aNumber]] autorelease];
}

- (NSString *) monthlyAmtDisplayString: (PaymentFreqEnum) paymentFreq{
    NSNumber *aNumber = [NSNumber numberWithDouble: [self monthlyAmt: paymentFreq]];
    NSNumberFormatter *aFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    
    [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    return [[[NSString alloc] initWithFormat: @"%@/month", [aFormatter stringFromNumber: aNumber]] autorelease];
}

- (double) monthlyAmt: (PaymentFreqEnum) paymentFreq{
    double returnValue = value;
    switch(paymentFreq){
        case BIWEEKLY:
            returnValue = (value*26.0)/12.0;
            break;
        case BIMONTHLY:
            returnValue = value/2.0;
            break;
        case WEEKLY:
            returnValue = (value*52.0)/12.0;
            break;
        case MONTHLY:
            break;
    }
    
    return returnValue;
}

@end

