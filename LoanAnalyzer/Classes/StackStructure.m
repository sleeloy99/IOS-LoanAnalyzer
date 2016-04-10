//
//  StackStructure.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "StackStructure.h"

@implementation StackStructure

- (id)init{
	self = [super init];
	if (self){
		stack = [[NSMutableArray alloc] init];
		index = -1;
	}
	return self;
}

-(void) push: (id) item{
	[stack addObject: item];
	index++;
}
-(id) pop{	
	id returnValue = [stack objectAtIndex: index];
	[stack removeLastObject];
	index--;
	return returnValue;
}

-(id) peek{	
	return [stack objectAtIndex: index];
}

- (void)dealloc {
	[stack release];
    [super dealloc];
}


@end
