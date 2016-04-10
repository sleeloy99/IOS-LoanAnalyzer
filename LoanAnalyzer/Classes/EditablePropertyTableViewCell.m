//
//  EditablePropertyTableViewCell.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "EditablePropertyTableViewCell.h"

@implementation EditablePropertyTableViewCell

@synthesize nameLabel, editingTextField, clearBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        UIView *myContentView = self.contentView;
        
        self.nameLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [myContentView addSubview: self.nameLabel];
        
        self.editingTextField = [[UITextField alloc] initWithFrame: CGRectMake(120, 10, 140, 20)];
        self.editingTextField.textColor = [UIColor whiteColor];
        [self.editingTextField setText:@""];
        
        [myContentView addSubview: self.editingTextField];
        
        clearBtn = [[UIButton alloc] initWithFrame: CGRectMake(265, 12, 19, 19)];
        NSString *path=[[NSBundle mainBundle] pathForResource: @"clear" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile: path];
        [clearBtn setBackgroundImage:image forState: UIControlStateNormal];
        clearBtn.backgroundColor = [UIColor clearColor];
        [myContentView addSubview: clearBtn];
        clearBtn.hidden = YES;
        [clearBtn addTarget: self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
        
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

-(IBAction) clear: (id) sender{
    [self.editingTextField setText:@""];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setData:(NSString*) name prop:(NSString *)prop{
    self.nameLabel.text = name;
    [self.editingTextField setText: prop];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    
    if (!self.editing){
        CGFloat boundsX = contentRect.origin.x;
        CGRect frame;
        
        frame = CGRectMake(boundsX+5, 10, 100, 20);
        self.nameLabel.frame = frame;
        
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
    [editingTextField release];	
    [clearBtn release];
    [super dealloc];
}

@end
