//
//  TwoLableTableViewCell.m
//  
//
//  Created by Sheldon Lee-Loy on 2/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "TwoLableTableViewCell.h"


@implementation TwoLableTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [super dealloc];
}

@end
