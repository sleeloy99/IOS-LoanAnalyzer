//
//  UIGradientView.h
//  
//
//  Created by Sheldon Lee-Loy on 2/14/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITwoModeGradientView : UIImageView{
	float maxHeight;
	float minHeight;
}

@property float maxHeight, minHeight;
@end
