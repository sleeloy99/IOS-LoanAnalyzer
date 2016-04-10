//
//  PopupViewController.m
//  
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "PopupViewController.h"

@implementation PopupViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) displaySelectedView: (BOOL) show{
    if ([self getIsVisible]  != show){
        [self setIsVisbile: show];
        CGRect rec = self.view.frame;
        float screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        float windowHieght = screenHeight -64.0f;
        
        if (show){
            rec.origin.y = windowHieght - rec.size.height;
        }
        else{
            rec.origin.y = windowHieght + rec.size.height;
        }
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration: 0.3f];
        self.view.frame = CGRectMake(rec.origin.x, rec.origin.y, rec.size.width, rec.size.height);
        [UIView commitAnimations];
    }
    if (show == NO){
        [[NSNotificationCenter defaultCenter] postNotificationName: @"closingkeypad" object: self];
    }
}

-(void) closeView: (id) sender{
    [self displaySelectedView: NO];
}

-(void) setIsVisbile: (BOOL) visible{
    isVisible = visible;
}

-(BOOL) getIsVisible{
    return isVisible;
}

-(void) setControls{
}

- (void)dealloc {
    [super dealloc];
}

@end
