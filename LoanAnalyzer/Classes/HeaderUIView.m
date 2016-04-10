//
//  HeaderUIView.m
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "HeaderUIView.h"


@implementation HeaderUIView
@synthesize prevButton, nextButton;
@synthesize detailController;
@synthesize stillPressed;

- (void)viewDidLoad {
    
    UIImageView *bkg = [[UIImageView alloc] init];
    bkg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    NSString *path=[[NSBundle mainBundle] pathForResource: @"scheduleheaderbkg" ofType:@"png"];
    UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
    bkg.image = image;
    [image release];
    [self addSubview: bkg];
    [bkg release];
    
    animateDone = YES;
    
    nameLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:22.0 bold:YES];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview: nameLabel];
    [nameLabel release];
    
    nameLabelLeft = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:22.0 bold:YES];
    nameLabelLeft.textAlignment = NSTextAlignmentCenter;
    [self addSubview: nameLabelLeft];
    [nameLabelLeft release];
    
    nameLabelRight = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:22.0 bold:YES];
    nameLabelRight.textAlignment = NSTextAlignmentCenter;
    [self addSubview: nameLabelRight];
    [nameLabelRight release];
    
    UILabel *principalLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:10.0 bold:YES];
    CGRect frame = CGRectMake(50, 40, 100, 14);
    principalLbl.frame = frame;
    principalLbl.textAlignment = NSTextAlignmentCenter;
    principalLbl.text = @"principal";
    [self addSubview: principalLbl];
    [principalLbl release];
    
    UILabel *interestLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:10.0 bold:YES];
    frame = CGRectMake(125, 40, 100, 14);
    interestLbl.frame = frame;
    interestLbl.textAlignment = NSTextAlignmentCenter;
    interestLbl.text = @"interest";
    [self addSubview: interestLbl];
    [interestLbl release];
    
    UILabel *balanceLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:10.0 bold:YES];
    frame = CGRectMake(220, 40, 100, 14);
    balanceLbl.frame = frame;
    balanceLbl.textAlignment = NSTextAlignmentCenter;
    balanceLbl.text = @"balance";
    [self addSubview: balanceLbl];
    [balanceLbl release];
    
    frame = CGRectMake(10, 5, 30, 30);
    prevButton = [[UIHoldDownButton alloc] initWithFrameNotification: frame notificationStr: @"continousLeft" notificationNameTapStr: @"swipeLeft"];
    path=[[NSBundle mainBundle] pathForResource: @"leftarrow" ofType:@"png"];
    image = [UIImage imageWithContentsOfFile: path];
    [prevButton setBackgroundImage:image forState: UIControlStateNormal];
    path=[[NSBundle mainBundle] pathForResource: @"leftarrowhighlight" ofType:@"png"];
    image = [UIImage imageWithContentsOfFile: path];
    [prevButton setBackgroundImage: image forState:UIControlStateHighlighted];
    prevButton.backgroundColor = [UIColor clearColor];
    
    [self addSubview: prevButton];
    [prevButton release];
    
    frame = CGRectMake(278, 5, 30, 30);
    nextButton = [[UIHoldDownButton alloc] initWithFrameNotification: frame notificationStr: @"continousRight" notificationNameTapStr: @"swipeRight"];
    path=[[NSBundle mainBundle] pathForResource: @"rightarrow" ofType:@"png"];
    image = [UIImage imageWithContentsOfFile: path];
    [nextButton setBackgroundImage:image forState: UIControlStateNormal];
    path=[[NSBundle mainBundle] pathForResource: @"rightarrowhighlight" ofType:@"png"];
    image = [UIImage imageWithContentsOfFile: path];
    [nextButton setBackgroundImage: image forState:UIControlStateHighlighted];
    
    nextButton.backgroundColor = [UIColor clearColor];
    [self addSubview: nextButton];
    [nextButton release];
    
    [self updateHeader];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (updateContent:) name:@"updateCells" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (moveLeft:) name:@"moveLeft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (moveRight:) name:@"moveRight" object:nil];
}

- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
    UIFont *font;
    if (bold)
        font = [UIFont boldSystemFontOfSize:fontSize];
    else
        font = [UIFont systemFontOfSize:fontSize];
    
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    newLabel.backgroundColor = [UIColor clearColor];
    newLabel.opaque = YES;
    newLabel.textColor = primaryColor;
    newLabel.highlightedTextColor = selectedColor;
    newLabel.font = font;
    
    return newLabel;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect contentRect = self.bounds;
    
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    frame = CGRectMake(boundsX+60, 7, contentRect.size.width-120, 25);
    nameLabel.frame = frame;
    
    
    frame = CGRectMake(boundsX+60-contentRect.size.width, 7, contentRect.size.width-120, 25);
    nameLabelLeft.frame = frame;
    
    frame = CGRectMake(boundsX+60+contentRect.size.width, 7, contentRect.size.width-120, 25);
    nameLabelRight.frame = frame;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [nameLabel release];
    [nameLabelLeft release];
    [nameLabelRight release];
    
    [nextButton release];
    [prevButton release];
    [super dealloc];
}

- (void)updateHeader{
    nameLabel.text = [[ScheduleModel instance] getHorizontalLabel];
    nameLabelLeft.text = [[ScheduleModel instance] getPrevHorizontalLabel];
    nameLabelRight.text = [[ScheduleModel instance] getNextHorizontalLabel];
}

-(void)animationDone:(NSString*) animationID finished:(NSNumber *)finished context:(void *)context{
    [self updateHeader];
    animateDone = YES;
}

-(IBAction) swipeLeft: (id) sender{
    if ([[ScheduleModel instance] canMoveLeft])	{
        [detailController swipeLeft:nil];
    }
}

-(IBAction) swipeRight: (id) sender{
    if ([[ScheduleModel instance] canMoveRight])
        [detailController swipeRight:nil];
}

- (void) updateContent: (NSNotification *) notification{
    [self updateHeader];
}

- (void) moveLeft: (NSNotification *) notification{
    [self moveLbls: 1];
}

- (void) moveRight: (NSNotification *) notification{
    [self moveLbls: -1];
}

- (void) moveLbls: (float) direction{
    if (animateDone == NO) return;
    animateDone = NO;
    CGRect lframeNameLbl,  rframeNameLbl;
    
    float shift = direction*self.frame.size.width;
    CGRect nameFrame = nameLabel.frame;
    
    CGRect lnameFrame = nameLabelLeft.frame;
    
    CGRect rnameFrame = nameLabelRight.frame;
    
    CGRect frameNameLbl = CGRectMake(nameFrame.origin.x +shift , nameFrame.origin.y ,nameFrame.size.width, nameFrame.size.height);
    
    if (direction == -1){
        lframeNameLbl = CGRectMake(rnameFrame.origin.x , rnameFrame.origin.y ,rnameFrame.size.width, rnameFrame.size.height);
    }
    else{
        lframeNameLbl = CGRectMake(lnameFrame.origin.x +shift , lnameFrame.origin.y ,lnameFrame.size.width, lnameFrame.size.height);
    }
    if (direction == -1){
        rframeNameLbl = CGRectMake(rnameFrame.origin.x +shift , rnameFrame.origin.y ,rnameFrame.size.width, rnameFrame.size.height);
    }
    else{
        rframeNameLbl = CGRectMake(lnameFrame.origin.x , lnameFrame.origin.y ,lnameFrame.size.width, lnameFrame.size.height);
    }
    
    if (direction == -1){
        [UIView beginAnimations: @"move cells" context:nil];
        [UIView setAnimationDuration: 0.6];
        nameLabel.frame = frameNameLbl;
        nameLabelRight.frame = rframeNameLbl;
        
        [UIView setAnimationDelegate: self];
        [UIView setAnimationDidStopSelector: @selector(animationDone:finished:context:)];
        
        [UIView commitAnimations];
        
        nameLabelLeft.frame = lframeNameLbl;
        
        UILabel *tnameLabel = nameLabelLeft;
        UILabel *t2nameLabel = nameLabel;
        
        nameLabel = nameLabelRight;
        nameLabelLeft = t2nameLabel;
        nameLabelRight = tnameLabel;
        
    } else{
        [UIView beginAnimations: @"move cells" context:nil];
        [UIView setAnimationDuration: 0.6];	
        nameLabel.frame = frameNameLbl;
        nameLabelLeft.frame = lframeNameLbl;
        
        [UIView setAnimationDelegate: self];
        [UIView setAnimationDidStopSelector: @selector(animationDone:finished:context:)];
        
        [UIView commitAnimations];
        
        nameLabelRight.frame = rframeNameLbl;
        
        UILabel *tnameLabel = nameLabelRight;
        UILabel *t2nameLabel = nameLabel;
        
        nameLabel = nameLabelLeft;
        nameLabelRight = t2nameLabel;
        nameLabelLeft = tnameLabel;		
    }	
}

@end
