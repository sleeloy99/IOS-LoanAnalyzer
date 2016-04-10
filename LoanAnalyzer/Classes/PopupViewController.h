//
//  PopupViewController.h
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PopupViewController : UIViewController {
	BOOL isVisible;
	float windowHeightVal;
}

-(void) closeView: (id) sender;
-(void) displaySelectedView: (BOOL) show;
-(void) setIsVisbile: (BOOL) visible;
-(BOOL) getIsVisible;
-(void) setControls;

@end
