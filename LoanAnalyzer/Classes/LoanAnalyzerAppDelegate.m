//
//  LoanAnalyzerAppDelegate.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright cellinova inc 2009. All rights reserved.
//

#import "LoanAnalyzerAppDelegate.h"
#import "ModelObject.h"

@implementation LoanAnalyzerAppDelegate

@synthesize window, navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after application launch
    [window setRootViewController:navController];
    [window makeKeyAndVisible];
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window { // iOS 6 autorotation fix
    return UIInterfaceOrientationMaskAll;
}

- (void)dealloc {
	[navController release];
    [window release];
    [super dealloc];
}

@end
