//
//  PropertyTableViewCell.m
//  
//
//  Created by Sheldon Lee-Loy on 2/7/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "PropertyTableViewCell.h"


@implementation PropertyTableViewCell

@synthesize nameLabel, valueLabel, secondValueLabel, hasDiffValue, hasValue, canLock, lock, isLock, delegate;
@synthesize diffValueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier hasVal:(BOOL)hasVal canLockVal: (BOOL)canLockVal hasDiffVal: (BOOL)hasDiffVal{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *myContentView = self.contentView;
        self.hasValue = hasVal;
        self.hasDiffValue = hasDiffVal;
        self.isLock = YES;
        self.canLock = NO;
        
        self.nameLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:14.0 bold:NO];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [myContentView addSubview: self.nameLabel];
        [self.nameLabel release];
        
        self.valueLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16.0 bold:YES];
        self.valueLabel.backgroundColor = [UIColor clearColor];
        self.valueLabel.textAlignment = NSTextAlignmentLeft;
        [myContentView addSubview: self.valueLabel];
        [self.valueLabel release];
        
        if (self.hasValue){
            self.secondValueLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12.0 bold:NO];
            self.secondValueLabel.textAlignment = NSTextAlignmentLeft;
            self.secondValueLabel.backgroundColor = [UIColor clearColor];
            self.secondValueLabel.textAlignment = NSTextAlignmentLeft;
            [myContentView addSubview: self.secondValueLabel];
            [self.secondValueLabel release];
        }
        
        if (self.canLock){
            CGRect frame = CGRectMake(270, 12, 19, 19);
            lock = [[UIButton alloc] initWithFrame: frame];
            NSString *path=[[NSBundle mainBundle] pathForResource: @"lock" ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile: path];
            [lock setBackgroundImage:image forState: UIControlStateNormal];
            lock.backgroundColor = [UIColor clearColor];
            [myContentView addSubview: lock];
            lock.hidden = YES;
            [lock addTarget: self action:@selector(toggleLock:) forControlEvents:UIControlEventTouchUpInside];
        }
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

- (UILabel*) getDiffValueLabel{
    if (diffValueLabel == nil){
        self.diffValueLabel = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor whiteColor] fontSize: 10.0 bold:NO];
        self.diffValueLabel.textAlignment = NSTextAlignmentLeft;
        self.diffValueLabel.backgroundColor = [UIColor clearColor];
        self.diffValueLabel.textAlignment = NSTextAlignmentLeft;
        self.diffValueLabel.frame = CGRectMake(self.contentView.frame.origin.x+120, 22, 120, 16);
        [self.contentView addSubview: self.diffValueLabel];
    }
    return diffValueLabel;
}

- (UIImageView*) getArrowDown{
    if (arrowDown == nil){
        
        arrowDown = [[UIImageView alloc] init];
        arrowDown.frame = CGRectMake(280, 10, 12, 19);
        NSString *path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        arrowDown.image = image;
        arrowDown.hidden = YES;
        [image release];
        [self.contentView addSubview: arrowDown];
    }
    return arrowDown;
}

- (UIImageView*) getArrowUp{
    if (arrowUp == nil){
        arrowUp = [[UIImageView alloc] init];
        arrowUp.frame = CGRectMake(280, 10, 12, 19);
        NSString *path=[[NSBundle mainBundle] pathForResource: @"uparrow" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        arrowUp.image = image;
        arrowUp.hidden = YES;
        [image release];
        [self.contentView addSubview: arrowUp];
    }
    return arrowUp;
}

-(IBAction) toggleLock: (id) sender{
    [self setLockVal: !isLock];
    [self.delegate toggleLockPressed: sender];
}

-(void) setLockVal: (BOOL) lockVal{
    NSString *path;
    isLock = lockVal;
    if (isLock)
        path=[[NSBundle mainBundle] pathForResource: @"lock" ofType:@"png"];
    else
        path=[[NSBundle mainBundle] pathForResource: @"unlock" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile: path];
    [lock setBackgroundImage:image forState: UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)resetData:(NSString*) name prop:(id<FormatObject>)prop{
    self.nameLabel.text = name;
    self.valueLabel.text = [prop displayString];
    if (diffValueLabel != nil)
        [self getDiffValueLabel].text = @"";
    if (arrowDown != nil)
        [self getArrowDown].hidden = YES;
    if (arrowUp != nil)
        [self getArrowUp].hidden = YES;
}

- (void)resetData{
    if (diffValueLabel != nil)
        [self getDiffValueLabel].text = @"";
    if (arrowDown != nil)
        [self getArrowDown].hidden = YES;
    if (arrowUp != nil)
        [self getArrowUp].hidden = YES;
}

- (void)resetData:(NSString*) name prop:(id<FormatObject>)prop  prop2:(id<FormatObject>)prop2{
    self.nameLabel.text = name;
    self.valueLabel.text = [prop displayString];
    self.secondValueLabel.text = [prop2 displayString];
    if (diffValueLabel != nil)
        [self getDiffValueLabel].text = @"";
    if (arrowDown != nil)
        [self getArrowDown].hidden = YES;
    if (arrowUp != nil)
        [self getArrowUp].hidden = YES;
}

- (void)setSecondProp:(id<FormatObject>)prop{
    self.secondValueLabel.text = [prop displayString];
}

- (void)setProp:(id<FormatObject>)prop{
    self.valueLabel.text = [prop displayString];
}

- (void)setPropDiff:(id<FormatObject>)prop orgin:(id<FormatObject>)orgin{
    self.valueLabel.text =  [prop displayString];
    double diff = [prop getDiff: orgin];
    if (diff > 0){
        [self getDiffValueLabel].textColor = [UIColor yellowColor];
        [self getArrowDown].hidden = YES;
        [self getArrowUp].hidden = NO;
    }
    else if (diff < 0){
        [self getDiffValueLabel].textColor = [UIColor greenColor];
        [self getArrowDown].hidden = NO;
        [self getArrowUp].hidden = YES;
    }
    else{
        if (arrowDown != nil)
            [self getArrowDown].hidden = YES;
        if (arrowUp != nil)
            [self getArrowUp].hidden = YES;
    }
    [self getDiffValueLabel].text = [prop displayDiffString:orgin];
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

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    
    if (!self.editing){
        CGFloat boundsX = contentRect.origin.x;
        CGRect frame;
        
        frame = CGRectMake(boundsX+5, 7, 100, 20);
        self.nameLabel.frame = frame;
        
        frame = CGRectMake(boundsX+120, 5, 160, 20);
        self.valueLabel.frame = frame;
        
        if (self.hasValue){
            frame = CGRectMake(boundsX+200, 5, 60, 16);
            self.secondValueLabel.frame = frame;
        }
    }
}

- (void)dealloc {
    [arrowDown release];
    [arrowUp release];
    [nameLabel release];
    [lock release];	
    [valueLabel release];
    [self.diffValueLabel release];	
    if (self.hasValue){
        [secondValueLabel release];
    }
    [super dealloc];
}


@end
