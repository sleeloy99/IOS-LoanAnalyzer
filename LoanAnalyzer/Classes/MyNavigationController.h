//
//  MyNavigationController.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 2013-09-21.
//  Copyright 2009 cellinova inc. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyNavigationController : UINavigationController {
    BOOL isLandScapeOk;
}
- (void) setLandScapeOk: (BOOL) ok;

@end