//
//  Property.m
//  
//
//  Created by Sheldon Lee-Loy on 2/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "Property.h"


@implementation Property
@synthesize name, value;

- (void)dealloc {
    [name release];
    [super dealloc];
}
@end
