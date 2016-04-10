//
//  LabelGenerator.h
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILabelGenerator

-(NSMutableArray*) getLabels;
- (void) initialize: (id)chartModel;

@end
