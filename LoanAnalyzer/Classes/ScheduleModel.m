//
//  ScheduleModel.m
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "ScheduleModel.h"
#import "ModelObject.h"


@implementation ScheduleModel

@synthesize schedule, initDate;

static ScheduleModel *_instance;

+(ScheduleModel *) instance{
	
	if (!_instance){
		_instance = [[ScheduleModel alloc] init];
	}
	return _instance;
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
	
	return self;
}

-(void) dealloc {
	[schedule release];
	[horizontalLabels release];
    if (currentArray != nil){
		[currentArray release];
    }
    if (initDate != nil){
		[initDate release];
    }
	[_instance release];
    [super dealloc];
}

-(void)swipeLeft{
	currentIndex--;
	if (currentIndex < 0){
		currentIndex = 0;
		return;
	}

	[self updateArrays];

}

-(void)swipeRight{
	currentIndex++;
	if (currentIndex >= [schedule count]){
		currentIndex = ((int)[schedule count]-1);
		return;
	}	
	[self updateArrays];
}

-(NSMutableArray *) getSchedule{
	return schedule;
}

-(void)updateArrays{
	currentArray = nil;
	if ([schedule count]>currentIndex)
		currentArray = [schedule objectAtIndex: currentIndex];
	currentPrevArray = nil;
	if (0 <= (currentIndex-1))
		currentPrevArray =[schedule objectAtIndex: currentIndex-1];	
	currentNextArray = nil;
	if ([schedule count] > (currentIndex+1))
		currentNextArray =[schedule objectAtIndex: currentIndex+1];	
}

-(BOOL)canMoveRight{
	return ((currentIndex+1) <[schedule count]);
}

-(BOOL)canMoveLeft{
	return (currentIndex >0);
}

-(ScheduleElement *) getPrevElement: (int) index {
	if (currentPrevArray == nil) 
		return nil;
	if (index >= [currentPrevArray count]) return nil;
	
	return  [self getElementFromArray: currentPrevArray objectAtIndex: index];
}

-(ScheduleElement *) getNextElement: (int) index {
	if (currentNextArray == nil) return nil;
	if (index >= [currentNextArray count]) return nil;
	return  [self getElementFromArray: currentNextArray objectAtIndex: index];
}

-(ScheduleElement *) getElement: (int) index {
	if (currentArray == nil) return nil;	
	if (index >= [currentArray count]) return nil;
	return  [self getElementFromArray: currentArray objectAtIndex: index];
}

-(ScheduleElement *) getElementFromArray: (NSMutableArray *) array objectAtIndex:(int)objectAtIndex{
	if (objectAtIndex < [array count])
		return [array objectAtIndex: objectAtIndex];
	else
	return [ModelObject getEmptyElement];
}

-(int) verticalCount{
	if (paymentFreq == WEEKLY)
		return 53;
	else if (paymentFreq == BIWEEKLY)
		return 27;
	else if (paymentFreq == MONTHLY)
		return 12;
	else
		return 24;
}

-(int) horizontalCount{
	return (int)[horizontalLabels count];
}

-(NSString *) getHorizontalLabel{
	return [horizontalLabels objectAtIndex: currentIndex];
}

-(NSString *) getPrevHorizontalLabel{
	if (currentIndex > 0)
		return [horizontalLabels objectAtIndex: (currentIndex-1)];
	return nil;
}
-(NSString *) getNextHorizontalLabel{
	if ((currentIndex+1) < [horizontalLabels count])	{
		return [horizontalLabels objectAtIndex: (currentIndex+1)];
	}
	return nil;
}

-(NSString *) getVerticalLabel: (int) index{
	ScheduleElement *elem = [self getElement:index];
	return [elem getDateDisplay];
}

-(int) getNumOfPayments{
	return numOfPayments;
}

-(void) initializeArray: (BOOL) mode{
    if (schedule != nil){
		[schedule release];
    }
    if (horizontalLabels != nil){
		[horizontalLabels release];
    }
	
	schedule = [[NSMutableArray alloc] init];
	horizontalLabels = [[NSMutableArray alloc] init];
	
	LoanObject *selectedLoan = [ModelObject instance].selectedObject;
	numOfPayments = [selectedLoan populateSchedule: schedule mode: mode];

	[selectedLoan populateYears: horizontalLabels numOfYears: (int)[schedule count]];
	paymentFreq = [selectedLoan.paymentFreq getFreqValue];
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *initcomps = [gregorian components: NSYearCalendarUnit fromDate: [selectedLoan.startDate getDateValue]];
	if (self.initDate != nil)
		[self.initDate release];
	self.initDate = [[selectedLoan.startDate getDateValue] copy];
	
	startYear = (int)[initcomps year];
	
	currentIndex = 0;
	[self updateArrays];
	[gregorian release];	
	
}

@end
