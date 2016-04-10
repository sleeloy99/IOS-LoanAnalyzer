//
//  StartDateTableViewCell.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/28/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "StartDateTableViewCell.h"


@implementation StartDateTableViewCell
@synthesize nameLabel, valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIView *myContentView = self.contentView;
		
		self.nameLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:14.0 bold:NO];
		self.nameLabel.backgroundColor = [UIColor clearColor];
		self.nameLabel.textAlignment = NSTextAlignmentRight;
		[myContentView addSubview: self.nameLabel];
		[self.nameLabel release];
		
		self.valueLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:16.0 bold:YES];
		self.valueLabel.backgroundColor = [UIColor clearColor];
		self.valueLabel.textAlignment = NSTextAlignmentLeft;
		[myContentView addSubview: self.valueLabel];
		[self.valueLabel release];
		
		UIImageView *lineView = [[UIImageView alloc] init];
		lineView.frame = CGRectMake(20, 40, 260, 3);
		NSString *path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
		UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];	
		lineView.image = image;
		[image release];
		[myContentView addSubview: lineView];		
					
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

- (void)resetData:(NSString*) name prop:(id<FormatObject>)prop{
	self.nameLabel.text = name;
	if (prop != nil)
		self.valueLabel.text = [prop displayString];
}

- (void)setData:(id<FormatObject>)prop{
	self.valueLabel.text = [prop displayString];
}

- (void)resetData:(NSString*) name{
	self.nameLabel.text = name;
}

- (void)resetData{
}


- (void)layoutSubviews{
	[super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;
	
	if (!self.editing){
		CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
		frame = CGRectMake(boundsX+5, 10, 100, 20);
		self.nameLabel.frame = frame;
		frame = CGRectMake(boundsX+120, 10, 140, 20);
		self.valueLabel.frame = frame;
		
	}
}

- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold{
	UIFont *font;
    if (bold){
		font = [UIFont boldSystemFontOfSize:fontSize];
    }
    else{
		font = [UIFont systemFontOfSize:fontSize];
    }
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

- (void)dealloc {
	[nameLabel release];
	[valueLabel release];	
    [super dealloc];
}

@end
