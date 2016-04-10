//
//  LumpSumTableCellView.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/27/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "LumpSumTableCellView.h"

@implementation LumpSumTableCellView

@synthesize nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *myContentView = self.contentView;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 240, 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.opaque = YES;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.highlightedTextColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [myContentView addSubview: self.nameLabel];
        
        UIImageView *discloseIndicator = [[UIImageView alloc] init];
        discloseIndicator.frame = CGRectMake(268, 13, 9, 13);
        NSString *path=[[NSBundle mainBundle] pathForResource: @"discloseIndicator" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        discloseIndicator.image = image;
        [image release];
        [myContentView addSubview: discloseIndicator];
        
        UIImageView *lineView = [[UIImageView alloc] init];
        lineView.frame = CGRectMake(20, 40, 260, 3);
        path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
        image = [[UIImage imageWithContentsOfFile: path] retain];
        lineView.image = image;
        [image release];
        [myContentView addSubview: lineView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc {
    [nameLabel release];
    [super dealloc];
}

@end
