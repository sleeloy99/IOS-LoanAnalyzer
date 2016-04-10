//
//  RoundRectView.h
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 4/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RoundRectView : UIView {

	CGFloat r, g, b, a;
	
}
- (id)initWithFrameColor:(CGRect)frame red:(CGFloat) red green:(CGFloat) green blue:(CGFloat)blue alpha:(CGFloat) alpha;

@end
