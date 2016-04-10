//
//  TableProtocols.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SlideItemTable

-(UIView *) getTableView;
-(void) setNavigation: (UINavigationItem*) navigationItemVal;
-(void) beforePush;
-(void) afterPush;
-(void) beforePop;
-(void) beforePeek;

@end

@protocol SimpleTableController

-(UIView *) getContainerView;
-(void) pushController: (id) pushedTable;
-(void) popController;

@end

