//
//  MyNavigationController.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 2013-09-21.
//  Copyright 2009 cellinova inc. All rights reserved.
//
//

#import "MyNavigationController.h"
@implementation MyNavigationController
- (BOOL)shouldAutorotate {
    return YES;
}
- (void) setLandScapeOk: (BOOL) ok {
    isLandScapeOk = ok;
}

/* ios 6 rotation methods */
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    if (isLandScapeOk) {
        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    return UIInterfaceOrientationMaskPortrait;
}
@end