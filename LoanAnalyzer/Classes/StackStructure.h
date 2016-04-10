//
//  StackStructure.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackStructure : NSObject {
	int index;
	NSMutableArray *stack;
}

-(void) push: (id) item;
-(id) pop;
-(id) peek;

@end
