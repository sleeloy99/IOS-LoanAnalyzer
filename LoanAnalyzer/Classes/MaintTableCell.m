//
//  MaintTableCell.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/11/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "MaintTableCell.h"


@implementation MaintTableCell

@synthesize nameLabel, amortizationLabel, loanAmtLabel, paymentAmtLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *myContentView = self.contentView;
        
        nameLabel = [self newLabelWithPrimaryColor: [UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:18 bold:NO italic:YES];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.backgroundColor = [UIColor clearColor];
        [myContentView addSubview: nameLabel];
        
        loanAmtLabel = [self newLabelWithPrimaryColor: [UIColor darkGrayColor] selectedColor:[UIColor whiteColor] fontSize: 14 bold:NO italic:NO];
        loanAmtLabel.textAlignment = NSTextAlignmentLeft;
        loanAmtLabel.backgroundColor = [UIColor clearColor];
        [myContentView addSubview: loanAmtLabel];
        
        amortizationLabel = [self newLabelWithPrimaryColor: [UIColor blueColor] selectedColor:[UIColor whiteColor] fontSize: 14 bold:NO italic:NO];
        amortizationLabel.textAlignment = NSTextAlignmentLeft;
        amortizationLabel.backgroundColor = [UIColor clearColor];
        [myContentView addSubview: amortizationLabel];
        
        paymentAmtLabel = [self newLabelWithPrimaryColor: [UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize: 14 bold:NO italic:NO];
        paymentAmtLabel.textAlignment = NSTextAlignmentRight;
        paymentAmtLabel.backgroundColor = [UIColor clearColor];
        [myContentView addSubview: paymentAmtLabel];
        
        
        rightDecorator = [[UIImageView alloc] init];
        rightDecorator.frame = CGRectMake(myContentView.frame.size.width - 50, 18, 9, 13);
        
        NSString *path=[[NSBundle mainBundle] pathForResource: @"rightdecorator" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        rightDecorator.image = image;
        rightDecorator.hidden = NO;
        [image release];
        
        [myContentView addSubview: rightDecorator];
        
        
    }
    return self;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if(fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        rightDecorator.hidden = YES;
    }
    else{
        rightDecorator.hidden = NO;
    }
}


- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold italic: (BOOL) italic
{
    UIFont *font;
    if (bold)
        font = [UIFont boldSystemFontOfSize:fontSize];
    else if (italic)
        font = [UIFont italicSystemFontOfSize:fontSize];
    else
        font = [UIFont systemFontOfSize:fontSize];
    
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    newLabel.backgroundColor = [UIColor whiteColor];
    newLabel.opaque = YES;
    newLabel.textColor = primaryColor;
    newLabel.highlightedTextColor = selectedColor;
    newLabel.font = font;
    
    return newLabel;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    
    if (!self.editing){
        CGFloat boundsX = contentRect.origin.x;
        CGFloat cellWidth = contentRect.size.width;
        CGRect frame;
        
        frame = CGRectMake(boundsX+10, 4, cellWidth-50, 22);
        nameLabel.frame = frame;
        
        frame = CGRectMake(boundsX+10, 24, 170, 16);
        loanAmtLabel.frame = frame;
        
        frame = CGRectMake(boundsX+10, 42, 180, 16);
        amortizationLabel.frame = frame;
        
        frame = CGRectMake(cellWidth-180, 42, 150, 22);
        paymentAmtLabel.frame = frame;
        
        
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)dealloc {
    [rightDecorator release];
    [nameLabel release];
    [amortizationLabel release];
    [loanAmtLabel release];
    [paymentAmtLabel release];	
    [super dealloc];
}


@end
