//
//  ModelObject.m
//
//  Created by Sheldon Lee-Loy on 2/12/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "ModelObject.h"


@implementation ModelObject
@synthesize selectedObject, loans, selectedOriginalObject;

static ModelObject *_instance;

static ScheduleElement *_emptyElement;

+(ModelObject *) instance{
    if (!_instance){
        _instance = [[ModelObject alloc] init];
        _emptyElement = [[ScheduleElement alloc] initWithEmpty];
    }
    return _instance;
}

+(ScheduleElement *) getEmptyElement{
    
    return _emptyElement;
}

+(id) alloc
{
    @synchronized(self){
        NSAssert(_instance == nil, @"Attempted to allocate a second instance of a singleton.");
        _instance = [super alloc];
    }
    return _instance;
}

-(id) init{
    self = [super init];
    
    if (self){
        [self loadLoans];
        UIApplication *app = [UIApplication sharedApplication];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:app];
        
    }
    return self;
}

- (void)applicationWillTerminate:(NSNotification *) notification{
    sqlite3_close(database);
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if (selectedObject != nil){
        [selectedObject release];
    }
    if (leftObject != nil){
        [leftObject release];
    }
    if (rightObject != nil){
        [rightObject release];
    }
    
    [loans release];
    [_emptyElement release];
    [_instance release];
    [super dealloc];
}

-(void) setRightLoan: (LoanObject *) loan{
    rightObject = loan;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rightObjectChanged" object: self];
}

-(void) setLeftLoan: (LoanObject *) loan{
    leftObject = loan;
    [[NSNotificationCenter defaultCenter] postNotificationName: @"leftObjectChanged" object: self];
}

-(LoanObject *) getRightLoan{
    return rightObject;
}

-(LoanObject *) getLeftLoan{
    return leftObject;
}

-(void) assingSelected: (LoanObject *) selectedObjectVal{
    //may need to calculate the principal amount
    if ([selectedObjectVal.principalAmt getDollarValue] == -1)
    {
        [selectedObjectVal calculatePrincipalInterestAmt];
    }
    
    selectedOriginalObject = selectedObjectVal;
    [self resetSelected];
}

-(void) assignNew{
    LoanObject *loan = [[LoanObject alloc] init];
    loan.name = [[NSString alloc] initWithString: @"New Loan"];
    [loan.amortization setYears: 20];
    [loan.amortization setMonths: 0];
    [loan.loanAmount setDollarValue: 150000];
    [loan.interestRate setPercentValue: 4.25];
    [loan calculatePaymentAmt];
    [loan calculatePrincipalInterestAmt];
    
    loan.uid = (int)[loans count];
    
    self.selectedOriginalObject = loan;
    [loan release];
    [self resetSelected];
}

- (void) persistLoan{
    [loans addObject: selectedObject];
    selectedObject.uid = (int)[loans count]-1;
    
    //Add to Database
    [self updateDatabase: selectedObject];
    
    //reset orignal object
    if (selectedOriginalObject != nil){
        [selectedOriginalObject release];
    }
    selectedOriginalObject = selectedObject;
    selectedObject = [selectedOriginalObject copy];
}

- (void) cancelLoan{
    if (selectedObject != nil){
        [selectedObject release];
        selectedObject = nil;
    }
    if (selectedOriginalObject != nil)
    {
        //need to clean up lumpsum table
        [self deleteLumpsums: selectedOriginalObject.uid];
        [selectedOriginalObject release];
        selectedOriginalObject = nil;
    }
}

-(void) updateDatabase: (LoanObject *)loan{
    char *errorMsg;
    NSUInteger idx = [loans indexOfObject: loan];
    
    NSString *update = [[NSString alloc] initWithFormat: @"INSERT OR REPLACE INTO FIELDS (ROW, NAME, YEARS, MONTHS, LOANAMT, INTEREST_RATE, PAYMENT_FREQ, COMPOUND_PERIOD, STARTDATE, PAYMENTAMT) VALUES (%d, '%@', %d, %d, %f, %f, %d, %d, '%@', %f);",
                        (int)idx,
                        [self toDBFormat:loan.name],
                        [loan.amortization getYears],
                        [loan.amortization getMonths],
                        [loan.loanAmount getDollarValue],
                        [loan.interestRate getPercentValue],
                        [loan.paymentFreq getFreqValue],
                        [loan.compoundPeriod getCompoundValue],
                        [loan.startDate getSQLDateStr],
                        [loan.paymentAmount getDollarValue]];
    
    if (sqlite3_exec(database, [update UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        NSAssert1(0, @"Error updating tables: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
    [update release];
    
}

-(void) updateLumpsumDatabase: (int) value{
    char *errorMsg;
    LumpSum *lumpsum = [selectedObject.lumpSums objectAtIndex: value];
    NSUInteger idx = selectedObject.uid;
    
    //update lump sum list
    
    NSString *updateLumpSum = [[NSString alloc] initWithFormat: @"INSERT OR REPLACE INTO LUMPSUMS (ROW, LOANID, LUMPSUMPERIOD, VALUE, STARTDATE, ENDDATE) VALUES (%d, %d, %d,  %f, '%@', '%@');", value,
                               (int)idx,
                               [lumpsum.lumpsumPeriod getLumpSumValue],
                               [lumpsum.value getDollarValue],
                               [lumpsum.duration.startDate getSQLDateStr],
                               [lumpsum.duration.endDate getSQLDateStr]
                               ];
    
    if (sqlite3_exec(database, [updateLumpSum UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        NSAssert1(0, @"Error updating tables: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
    [updateLumpSum release];
    
}

-(void) saveSelected{
    if (selectedObject != nil){
        NSUInteger index = [loans indexOfObject: selectedOriginalObject];
        [loans replaceObjectAtIndex:index withObject: selectedObject];
        [self updateDatabase: selectedObject];
        
        selectedOriginalObject = selectedObject;
        selectedObject = [selectedOriginalObject copy];
    }
}

-(void) resetSelected{
    if (selectedObject != nil){
        [selectedObject release];
    }
    selectedObject = [selectedOriginalObject copy];
}

-(int) saveLumpSum: (LumpSum*) lumpsum idx:(int)idx{
    int returnIdx = idx;
    if (selectedObject != nil){
        if (idx == -1){
            //add lump sum to selected and original
            //lump sum will be a reference ... should copy
            
            LumpSum *copyLump = [[LumpSum alloc]initWith:[lumpsum.value getDollarValue] lumpsumPeriodVal:[lumpsum.lumpsumPeriod getLumpSumValue] startDateVal:[[[lumpsum.duration.startDate getDateValue] copy] autorelease] endDateVal:[[[lumpsum.duration.endDate getDateValue] copy] autorelease]];
            [selectedObject.lumpSums addObject: copyLump];
            [selectedOriginalObject.lumpSums addObject: lumpsum];
            returnIdx = (int)[selectedOriginalObject.lumpSums count] -1;
            [copyLump release];
            
            //need to recalculate principal amount and interest amount
            [selectedObject calculatePrincipalInterestAmt];
            [selectedOriginalObject calculatePrincipalInterestAmt];
        }
        else{
            LumpSum *copyLump = [[LumpSum alloc]initWith:[lumpsum.value getDollarValue] lumpsumPeriodVal:[lumpsum.lumpsumPeriod getLumpSumValue] startDateVal:[[[lumpsum.duration.startDate getDateValue] copy] autorelease] endDateVal:[[[lumpsum.duration.endDate getDateValue] copy] autorelease]];
            [selectedOriginalObject.lumpSums replaceObjectAtIndex:idx withObject: copyLump];
            [copyLump release];
            [selectedOriginalObject calculatePrincipalInterestAmt];
        }
    }
    [self updateLumpsumDatabase: returnIdx];
    return returnIdx;
}

-(void) deleteLumpSumAt: (int) index{
    if (selectedObject != nil){
        //delete lump sum from selected and original
        //lump sum will be a reference ... should copy
        [selectedObject.lumpSums removeObjectAtIndex: index];
        [selectedOriginalObject.lumpSums removeObjectAtIndex: index];
        [self deleteLumpsumFromDBAtIndex: index];
    }
}

-(void) resetLumpSumAt: (int) index{
    if (selectedObject != nil){
        //delete lump sum from selected and original
        //lump sum will be a reference ... should copy
        LumpSum *lumpsum = [selectedOriginalObject.lumpSums objectAtIndex: index];
        LumpSum *copyLump = [[LumpSum alloc]initWith:[lumpsum.value getDollarValue] lumpsumPeriodVal:[lumpsum.lumpsumPeriod getLumpSumValue] startDateVal:[[[lumpsum.duration.startDate getDateValue] copy] autorelease] endDateVal:[[[lumpsum.duration.endDate getDateValue] copy] autorelease]];
        [selectedObject.lumpSums replaceObjectAtIndex:index withObject: copyLump];
        [copyLump release];
    }
    
}

-(NSString *) totalPaymentAmtDisplayString{
    double total = 0.0;
    for (int x =0; x < [loans count]; x++){
        LoanObject *loan = [loans objectAtIndex: x];
        total += [loan.paymentAmount monthlyAmt: [loan.paymentFreq getFreqValue]];
    }
    
    NSString *returnValue;
    NSNumber *aNumber = [NSNumber numberWithDouble: total];
    NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
    
    [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    returnValue = [[[NSString alloc] initWithFormat: @"%@/month", [aFormatter stringFromNumber: aNumber]] autorelease];
    [aFormatter release];
    return returnValue;
}

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex: 0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(LumpSum *) createNewLumpSum{
    NSDate* startDate = [NSDate date];
    NSDate* endDate = [NSDate date];
    return [[[LumpSum alloc] initWith:0 lumpsumPeriodVal:LUMPNONE startDateVal: startDate endDateVal:endDate] autorelease];
}

-(void) loadLoans{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    char *errorMsg;
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS (ROW INTEGER PRIMARY KEY, NAME TEXT, YEARS INTEGER, MONTHS INTEGER, LOANAMT REAL, INTEREST_RATE REAL, PAYMENT_FREQ INTERGER, COMPOUND_PERIOD INTEGER, STARTDATE TEXT, PAYMENTAMT REAL);";
    if (sqlite3_exec(database, [createSQL UTF8String],	NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Failed to create table: %s", errorMsg);
    }
    createSQL = @"CREATE TABLE IF NOT EXISTS LUMPSUMS (ROW INTEGER PRIMARY KEY, LOANID INTEGER, LUMPSUMPERIOD INTEGER, VALUE REAL, STARTDATE TEXT, ENDDATE TEXT);";
    if (sqlite3_exec(database, [createSQL UTF8String],	NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Failed to create table: %s", errorMsg);
    }
    
    loans = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT ROW, NAME, YEARS, MONTHS, LOANAMT, INTEREST_RATE, PAYMENT_FREQ, COMPOUND_PERIOD, STARTDATE, PAYMENTAMT FROM FIELDS ORDER BY ROW";
    sqlite3_stmt *statement;
    const char *message;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, &message) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW){
            int row = sqlite3_column_int(statement, 0);
            char *name = (char *)sqlite3_column_text(statement, 1);
            
            LoanObject *loan = [[LoanObject alloc] init];
            loan.uid = row;
            loan.name = [[NSString alloc] initWithUTF8String:name];
            [self loadLumpSums: row lumpsums: loan.lumpSums];
            
            [loan.amortization setYears: sqlite3_column_int(statement, 2)];
            [loan.amortization setMonths: sqlite3_column_int(statement, 3)];
            [loan.loanAmount setDollarValue: sqlite3_column_double(statement, 4)];
            [loan.interestRate setPercentValue: sqlite3_column_double(statement, 5)];
            [loan.paymentFreq setFreqValue: sqlite3_column_int(statement, 6)];
            [loan.compoundPeriod setCompoundValue: sqlite3_column_int(statement, 7)];
            
            char *startdate = (char *)sqlite3_column_text(statement, 8);
            NSString *dateStr = [[NSString alloc] initWithUTF8String:startdate];
            
            [loan.startDate setDateValueStr: dateStr];
            [loan.paymentAmount setDollarValue: sqlite3_column_double(statement, 9)];
            [loans addObject: loan];
            [loan release];
            [dateStr release];
        }
    }
}

-(void) loadLumpSums: (int)loanid lumpsums:(NSMutableArray*)lumpsums{
    NSString *query =[[NSString alloc] initWithFormat: @"SELECT ROW, LUMPSUMPERIOD, VALUE, STARTDATE, ENDDATE FROM LUMPSUMS WHERE LOANID=%d ORDER BY ROW", loanid];
    sqlite3_stmt *statement;
    const char *message;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, &message) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW){
            LumpSum *lumpsum = [[LumpSum alloc] initWith:sqlite3_column_double(statement, 2) lumpsumPeriodVal:sqlite3_column_int(statement, 1) startDateVal: nil endDateVal:nil];
            
            char *strdate = (char *)sqlite3_column_text(statement, 3);
            NSString *dateStr = [[NSString alloc] initWithUTF8String:strdate];
            [lumpsum.duration.startDate setDateValueStr:dateStr];
            [dateStr release];
            strdate = (char *)sqlite3_column_text(statement, 4);
            dateStr = [[NSString alloc] initWithUTF8String:strdate];
            [lumpsum.duration.endDate setDateValueStr:dateStr];
            [dateStr release];
            [lumpsums addObject:lumpsum];
            [lumpsum release];
        }
    }
    sqlite3_finalize(statement);
    [query release];
    
}

-(void) deleteObjectAtIndex: (int) index{
    char *errorMsg;
    
    LoanObject *loan = [self.loans objectAtIndex:index];
    int uid = loan.uid;
    [self.loans removeObjectAtIndex:index];
    
    NSString *delete = [[NSString alloc] initWithFormat: @"DELETE FROM FIELDS WHERE ROW=%d;", uid];
    if (sqlite3_exec(database, [delete UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        NSAssert1(0, @"Error updating tables: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
    [delete release];
}

-(void) deleteLumpsums: (int) uid{
    char *errorMsg;
    
    NSString *delete = [[NSString alloc] initWithFormat: @"DELETE FROM LUMPSUMS WHERE LOANID=%d;", uid];
    if (sqlite3_exec(database, [delete UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        NSAssert1(0, @"Error updating tables: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
    [delete release];
}


-(void) deleteLumpsumFromDBAtIndex: (int) index{
    char *errorMsg;
    
    NSString *delete = [[NSString alloc] initWithFormat: @"DELETE FROM LUMPSUMS WHERE ROW=%d;", index];
    if (sqlite3_exec(database, [delete UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        NSAssert1(0, @"Error updating tables: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
    [delete release];
}

-(NSString *) toDBFormat: (NSString *)dbstr{
    return [dbstr stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

@end
