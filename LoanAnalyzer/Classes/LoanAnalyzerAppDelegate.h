//
//  LoanAnalyzerAppDelegate.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright cellinova inc 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanAnalyzerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	IBOutlet UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

