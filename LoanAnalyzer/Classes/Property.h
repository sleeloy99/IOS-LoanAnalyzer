//
//  Property.h
//  
//
//  Created by Sheldon Lee-Loy on 2/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentFreqObj.h"

@interface Property : NSObject {
	NSString *name;
	id <FormatObject> *value;
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, assign) id <FormatObject> *value;
@end
