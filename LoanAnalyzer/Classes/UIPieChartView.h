//
//  UIPieChartView.h
//  
//
//  Created by Sheldon Lee-Loy on 2/10/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIPieChartView : UIView {
	float percent;
	float radius;
	float xOffset;
	float yOffset;
}

- (void) setPercent: (float) percentAttr;
-(void) addRoundedRectToPath: (CGContextRef) context rect:(CGRect) rect ovalWidth:(float) ovalWidth ovalHeight: (float) ovalHeight;

@end
