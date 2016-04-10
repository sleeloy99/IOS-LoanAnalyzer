//
//  ChartModel.m
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "ChartModel.h"

@implementation ChartModel

@synthesize minY, minX, maxY, maxX, coordMinY, coordMinX, coordMaxY, coordMaxX, title;

- (id)initWithValue: (float) vminY   vminX :(float)vminX   vmaxY:(float)vmaxY   vmaxX:(float)vmaxX   vcoordMinY:(float)vcoordMinY   vcoordMinX:(float)vcoordMinX   vcoordMaxY:(float)vcoordMaxY   vcoordMaxX:(float)vcoordMaxX{
    if (self = [super init]) {
        numOfYIncrements = 5;
        minY = vminY;
        minX = vminX;
        maxY = vmaxY;
        maxX = vmaxX;
        coordMinY = vcoordMinY;
        coordMinX = vcoordMinX;
        coordMaxY = vcoordMaxY;
        coordMaxX = vcoordMaxX;
    }
    return self;
}

-(void) initialize{
    
    ///
    /// Calculate Y axis label
    ///
    float interval = (maxY - minY);
    float increment = (interval/numOfYIncrements);
    
    float tempInc = increment;
    int factor = 10;
    while (tempInc > 1000){
        tempInc = tempInc/10;
        factor = factor*10;
    }
    
    int intValue = (int)(increment/factor);
    intValue = intValue*factor;
    if (intValue < increment){
        yIncrementWidth = intValue*factor;
    }
    else{
        yIncrementWidth = intValue;
    }
    
    NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
    [aFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    //	if (factor >= 1000)
    //		[aFormatter setFormat: @"$#.## K"];
    
    if (yIncrements != nil){
        [yIncrements release];
    }
    if (yIncrementsLbls != nil){
        [yIncrementsLbls release];
    }
    yIncrements = [[NSMutableArray alloc] init];
    yIncrementsLbls = [[NSMutableArray alloc] init];
    for (int x= 0; x< (numOfYIncrements+1); x++){
        double value = increment*x;
        [yIncrements addObject: [NSNumber numberWithFloat: value]];
        double dollarLbl;
        NSString *labelString;
        if (factor >= 1000){
            modf((value/1000.0f), &dollarLbl);
            labelString = [NSString stringWithFormat: @"$%@ K", [aFormatter stringFromNumber: [[[NSNumber alloc] initWithFloat: dollarLbl] autorelease]]];
        }
        else{
            dollarLbl = value;
            labelString =  [NSString stringWithFormat: @"$%@",[aFormatter stringFromNumber: [[[NSNumber alloc] initWithFloat: dollarLbl] autorelease]]];
        }
        
        [yIncrementsLbls addObject: labelString];
    }
    
    [aFormatter release];
    
    ///
    /// Calculate X axis label
    ///
    NSMutableArray *xLabels = [xLabelGenerator getLabels];
    int numOfXIncrements = (int)[xLabels count];
    interval = (maxX - minX);
    xIncrementWidth = (interval/numOfXIncrements);
    
    if (xIncrements != nil){
        [xIncrements release];
    }
    if (xIncrementsLbls != nil){
        [xIncrementsLbls release];
    }
    xIncrements = [[NSMutableArray alloc] init];
    xIncrementsLbls = [[NSMutableArray alloc] init];
    for (int x= 0; x< (numOfXIncrements); x++){
        float value = xIncrementWidth*x;
        [xIncrements addObject: [NSNumber numberWithFloat: value]];
        [xIncrementsLbls addObject: [xLabels objectAtIndex: x] ];
    }
    
}

-(NSMutableArray*) getYIncrements{
    return yIncrements;
}

-(NSMutableArray*) getYIncrementsLbls{
    return yIncrementsLbls;
}

-(NSMutableArray*) getXIncrements{
    return xIncrements;
}

-(NSMutableArray*) getXIncrementsLbls{
    return xIncrementsLbls;
}

-(float) getYIncrementWidth{
    return yIncrementWidth;
}

-(float) getXIncrementWidth{
    return xIncrementWidth;
}

-(float) getY:(float) y{
    return coordMaxY - (y/maxY*fabs(coordMaxY-coordMinY));
}

-(float) getX:(float) x{
    return (x/maxX*(fabs(coordMaxX-coordMinX)))+coordMinX;
}

- (void)dealloc {
    if (yIncrements != nil){
        [yIncrements release];
    }
    if (xIncrements != nil){
        [xIncrements release];
    }
    if (yIncrementsLbls != nil){
        [yIncrementsLbls release];
    }
    if (xIncrementsLbls != nil){
        [xIncrementsLbls release];
    }
    
    if (xLabelGenerator != nil){
        [(NSObject *)xLabelGenerator release];
    }
    
    [title release];
    [super dealloc];
}


@end
