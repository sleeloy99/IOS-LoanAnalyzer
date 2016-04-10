//
//  ModelObject.h
//
//  Created by Sheldon Lee-Loy on 2/12/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoanObject.h"
#import "sqlite3.h"
#import "ScheduleElement.h"

#define kFilename	@"data.sqlite3"

@interface ModelObject : NSObject {
	LoanObject *selectedObject;
	LoanObject *selectedOriginalObject;	
	NSMutableArray *loans;
	LoanObject *rightObject;
	LoanObject *leftObject;
	
	sqlite3 *database;
}

+(ModelObject *) instance;
+(ScheduleElement *) getEmptyElement;
-(NSString *) toDBFormat: (NSString *)dbstr;
-(void) loadLoans;
-(void) resetSelected;
-(void) saveSelected;
-(void) assingSelected: (LoanObject *) selectedObjectVal;
-(void) assignNew;
-(void) updateDatabase: (LoanObject *)loan;
-(NSString *) dataFilePath;
-(void) deleteObjectAtIndex: (int) index;
-(void)applicationWillTerminate:(NSNotification *) notification;
-(NSString *) totalPaymentAmtDisplayString;
-(void) setRightLoan: (LoanObject *) loan;
-(void) setLeftLoan: (LoanObject *) loan;
-(LoanObject *) getRightLoan;
-(LoanObject *) getLeftLoan;
-(LumpSum *) createNewLumpSum;
-(int) saveLumpSum: (LumpSum*) lumpsum idx:(int)idx;
-(void) deleteLumpSumAt: (int) index;
-(void) resetLumpSumAt: (int) index;
-(void) loadLumpSums: (int)loanid lumpsums:(NSMutableArray*)lumpsums;
-(void) updateLumpsumDatabase: (int) x;
-(void) deleteLumpsumFromDBAtIndex: (int) index;
-(void) deleteLumpsums: (int) uid;
-(void) persistLoan;
-(void) cancelLoan;

@property (nonatomic, retain) LoanObject *selectedObject, *selectedOriginalObject;
@property (nonatomic, retain) NSMutableArray *loans;

@end
