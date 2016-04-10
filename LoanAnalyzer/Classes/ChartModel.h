//
//  ChartModel.h
//  ChartApp
//
//  Created by user user on 4/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LabelGenerator.h"

@interface ChartModel : NSObject {
	float minY, minX, maxY, maxX;
	float coordMinY, coordMinX, coordMaxY, coordMaxX;
	int numOfYIncrements;
	float yIncrementWidth;
	float xIncrementWidth;
	id<ILabelGenerator> xLabelGenerator;
	
	NSString *title;
	
	NSMutableArray *yIncrementsLbls;
	NSMutableArray *yIncrements;
	NSMutableArray *xIncrementsLbls;
	NSMutableArray *xIncrements;
}

-(float) getYIncrementWidth;
-(float) getXIncrementWidth;
-(float) getY:(float) y;
-(float) getX:(float) x;
-(void) setCoordMaxY:(float) coordMaxYVal;
-(void) setCoordMaxX:(float) coordMaxXVal;
-(NSMutableArray*) getYIncrements;
-(NSMutableArray*) getYIncrementsLbls;
-(NSMutableArray*) getXIncrements;
-(NSMutableArray*) getXIncrementsLbls;
-(void) initialize;
- (id)initWithValue: (float) vminY vminX :(float)vminX vmaxY:(float)vmaxY vmaxX:(float)vmaxX vcoordMinY:(float)vcoordMinY vcoordMinX:(float)vcoordMinX vcoordMaxY:(float)vcoordMaxY vcoordMaxX:(float)vcoordMaxX;

@property float minY, minX, maxY, maxX, coordMinY, coordMinX, coordMaxY, coordMaxX;
@property (nonatomic, retain) NSString *title;


@end
