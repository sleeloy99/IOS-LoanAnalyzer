//
//  LumpSumTableViewCell.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/27/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "LumpSumTableViewCell.h"


@implementation LumpSumTableViewCell

- (id)initWithStyleRO:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier readOnly:(BOOL) readOnly {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		isReadOnly = readOnly;
        UIView *myContentView = self.contentView;
		valueLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:16 bold:YES];
		valueLabel.textAlignment = NSTextAlignmentCenter;
		valueLabel.backgroundColor = [UIColor clearColor];
		[myContentView addSubview: valueLabel];
		[valueLabel release];
		
		freqLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12.0 bold:NO];
		freqLabel.textAlignment = NSTextAlignmentLeft;
		freqLabel.backgroundColor = [UIColor clearColor];
		freqLabel.textAlignment = NSTextAlignmentLeft;
		[myContentView addSubview: freqLabel];
		[freqLabel release];		
		
		dateLabel = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor whiteColor] fontSize: 12.0 bold:NO];
		dateLabel.textAlignment = NSTextAlignmentLeft;
		dateLabel.backgroundColor = [UIColor clearColor];
		dateLabel.textAlignment = NSTextAlignmentCenter;
		[myContentView addSubview: dateLabel];
		[dateLabel release];		
			
		UIImageView *lineView = [[UIImageView alloc] init];
		if(!isReadOnly)
			lineView.frame = CGRectMake(20, 50, 260, 3);
		else
			lineView.frame = CGRectMake(5, 50, 210, 3);
		NSString *path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
		UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];	
		lineView.image = image;
		[image release];
		[myContentView addSubview: lineView];	   
		
		if (!(readOnly)){
			UIImageView *discloseIndicator = [[UIImageView alloc] init];
			discloseIndicator.frame = CGRectMake(268, 13, 9, 13);
			path=[[NSBundle mainBundle] pathForResource: @"discloseIndicator" ofType:@"png"];
			image = [[UIImage imageWithContentsOfFile: path] retain];	
			discloseIndicator.image = image;
			[image release];
			[myContentView addSubview: discloseIndicator];		
		}
	}
    return self;
}


- (void)setData: (LumpSum *) lumpsum{
	valueLabel.text = [lumpsum.value displayString];
	dateLabel.text = [lumpsum.duration displayString];
	freqLabel.text = [lumpsum.lumpsumPeriod displayString];
}

- (void)layoutSubviews{
	[super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;
	
	if (!self.editing){
		CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
        if(!isReadOnly){
			frame = CGRectMake(boundsX+55, 10, 170, 20);
        }
        else{
			frame = CGRectMake(boundsX+35, 10, 170, 20);
        }
		valueLabel.frame = frame;
				
        if(!isReadOnly){
			frame = CGRectMake(boundsX+225, 10, 60, 16);
        }
        else{
			frame = CGRectMake(boundsX+170, 10, 60, 16);
        }
		freqLabel.frame = frame;

        if(!isReadOnly){
			frame = CGRectMake(boundsX+40, 29, 240, 16);
        }
        else{
			frame = CGRectMake(boundsX, 29, 240, 16);
        }
		dateLabel.frame = frame;
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
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
	[dateLabel release];
	[valueLabel release];
	[freqLabel release];
    [super dealloc];
}

@end
