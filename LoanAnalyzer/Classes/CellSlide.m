//
//  CellSlide.m
//  ScheduleView
//
//  Created by Sheldon Lee-Loy on 2/22/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "CellSlide.h"

@implementation CellSlide

@synthesize leftLabelTag, index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *myContentView = self.contentView;
        animateDone = YES;
        
        bkg = [[UIImageView alloc] init];
        NSString *path=[[NSBundle mainBundle] pathForResource: @"schedulecellbkg" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        bkg.image = image;
        [image release];
        [myContentView addSubview: bkg];
        
        nameLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:12 bold:NO];
        nameLabel.textAlignment = NSTextAlignmentRight;
        [myContentView addSubview: nameLabel];
        [nameLabel release];
        
        
        valueLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12 bold:NO];
        valueLabel.textAlignment = NSTextAlignmentLeft;
        [myContentView addSubview: valueLabel];
        [valueLabel release];
        
        secondValueLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12 bold:NO];
        secondValueLabel.textAlignment = NSTextAlignmentLeft;
        [myContentView addSubview: secondValueLabel];
        [secondValueLabel release];
        
        nameLabelLeft = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:12 bold:NO];
        nameLabelLeft.textAlignment = NSTextAlignmentRight;
        [myContentView addSubview: nameLabelLeft];
        [nameLabelLeft release];
        
        valueLabelLeft = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12 bold:NO];
        valueLabelLeft.textAlignment = NSTextAlignmentLeft;
        [myContentView addSubview: valueLabelLeft];
        [valueLabelLeft release];
        
        secondValueLabelLeft = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12 bold:NO];
        secondValueLabelLeft.textAlignment = NSTextAlignmentLeft;
        [myContentView addSubview: secondValueLabelLeft];
        [secondValueLabelLeft release];
        
        nameLabelRight = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
        nameLabelRight.textAlignment = NSTextAlignmentRight;
        [myContentView addSubview: nameLabelRight];
        [nameLabelRight release];
        
        valueLabelRight = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12 bold:NO];
        valueLabelRight.textAlignment = NSTextAlignmentLeft;
        [myContentView addSubview: valueLabelRight];
        [valueLabelRight release];
        
        secondValueLabelRight = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 12 bold:NO];
        secondValueLabelRight.textAlignment = NSTextAlignmentLeft;
        [myContentView addSubview: secondValueLabelRight];
        [secondValueLabelRight release];
        
        leftLabelTag = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:10.0 bold:YES];
        leftLabelTag.textAlignment = NSTextAlignmentCenter;
        leftLabelTag.backgroundColor = [UIColor colorWithRed:0.0 green:0.3294 blue:0.5843 alpha:1.0];
        leftLabelTag.opaque = YES;
        [myContentView addSubview: leftLabelTag];
        [leftLabelTag release];
        
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (updateContent:) name:@"updateCells" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (moveLeft:) name:@"moveLeft" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (moveRight:) name:@"moveRight" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector (move:) name:@"move" object:nil];
        
    }
    return self;
}

-(void)animationDone:(NSString*) animationID finished:(NSNumber *)finished context:(void *)context{
    [self updateCells];
    animateDone = YES;
}

- (void) updateCells{
    nameLabel.text = [[[ScheduleModel instance] getElement:index] getPrincipalAmountDisplay];
    valueLabel.text = [[[ScheduleModel instance] getElement:index] getInterestAmountDisplay];
    secondValueLabel.text = [[[ScheduleModel instance] getElement:index] getBalanceDisplay];
    
    nameLabelLeft.text = [[[ScheduleModel instance] getPrevElement:index] getPrincipalAmountDisplay];
    valueLabelLeft.text = [[[ScheduleModel instance] getPrevElement:index] getInterestAmountDisplay];
    secondValueLabelLeft.text =  [[[ScheduleModel instance] getPrevElement:index] getBalanceDisplay];
    
    nameLabelRight.text = [[[ScheduleModel instance] getNextElement:index] getPrincipalAmountDisplay];
    valueLabelRight.text = [[[ScheduleModel instance] getNextElement:index] getInterestAmountDisplay];
    secondValueLabelRight.text = [[[ScheduleModel instance] getNextElement:index] getBalanceDisplay];
    
    leftLabelTag.text = [[ScheduleModel instance] getVerticalLabel: index];
    
    [self modifyCellFromLumpsum];
}

-(void) modifyCellFromLumpsum{
    //left
    NSString *rightStr = [[[ScheduleModel instance] getNextElement:index] getLumpSumDisplay];
    NSString *leftStr = [[[ScheduleModel instance] getPrevElement:index] getLumpSumDisplay];
    NSString *centerStr = [[[ScheduleModel instance] getElement:index] getLumpSumDisplay];
    CGRect frame;
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGFloat cellWidth = contentRect.size.width;
    
    if ([centerStr compare: @""]  == NSOrderedSame){
        if (lumpsumLabel != nil){
            //need to remove label from view
            [lumpsumLabel removeFromSuperview];
            lumpsumLabel = nil;
            
            //then readjust other labels
            frame = CGRectMake(boundsX+10, 8, 120, 30);
            nameLabel.frame = frame;
            
            frame = CGRectMake(boundsX+150, 8, 80, 30);
            valueLabel.frame = frame;
            
            frame = CGRectMake(boundsX+240, 8, 150, 30);
            secondValueLabel.frame = frame;
        }
    }
    else{
        //label has value
        if (lumpsumLabel == nil){
            //need to allocate label
            lumpsumLabel = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
            lumpsumLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview: lumpsumLabel];
            
            frame = CGRectMake(boundsX+100, 16, 120, 30);
            lumpsumLabel.frame = frame;
            //then readjust other labels
            frame = CGRectMake(boundsX+10, 1, 120, 30);
            nameLabel.frame = frame;
            
            frame = CGRectMake(boundsX+150, 1, 80, 30);
            valueLabel.frame = frame;
            
            frame = CGRectMake(boundsX+240, 1, 150, 30);
            secondValueLabel.frame = frame;
            
        }
        lumpsumLabel.text = [[[NSString alloc] initWithFormat: @"Lump sum: %@", centerStr] autorelease];
    }
    
    if ([rightStr compare: @""]  == NSOrderedSame){
        if (lumpsumLabelRight != nil){
            //need to remove label from view
            [lumpsumLabelRight removeFromSuperview];
            lumpsumLabelRight = nil;
            
            //then readjust other labels
            
            frame = CGRectMake(boundsX+10+cellWidth, 8, 120, 30);
            nameLabelRight.frame = frame;
            
            frame = CGRectMake(boundsX+150+cellWidth, 8, 80, 30);
            valueLabelRight.frame = frame;
            
            frame = CGRectMake(boundsX+240+cellWidth, 8, 150, 30);
            secondValueLabelRight.frame = frame;
            
        }
    }
    else{
        //label has value
        
        if (lumpsumLabelRight == nil){
            //need to allocate label
            lumpsumLabelRight = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
            lumpsumLabelRight.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview: lumpsumLabelRight];
            
            frame = CGRectMake(boundsX+100+cellWidth, 16, 120, 30);
            lumpsumLabelRight.frame = frame;
            //then readjust other labels
            
            frame = CGRectMake(boundsX+10+cellWidth, 1, 120, 30);
            nameLabelRight.frame = frame;
            
            frame = CGRectMake(boundsX+150+cellWidth, 1, 80, 30);
            valueLabelRight.frame = frame;
            
            frame = CGRectMake(boundsX+240+cellWidth, 1, 150, 30);
            secondValueLabelRight.frame = frame;
            
        }
        lumpsumLabelRight.text = [[[NSString alloc] initWithFormat: @"Lump sum: %@", rightStr] autorelease];
    }
    
    if ([leftStr compare: @""]  == NSOrderedSame){
        if (lumpsumLabelLeft != nil){
            //need to remove label from view
            [lumpsumLabelLeft removeFromSuperview];
            lumpsumLabelLeft = nil;
            //then readjust other labels
            frame = CGRectMake(boundsX+10-cellWidth, 8, 120, 30);
            nameLabelLeft.frame = frame;
            
            frame = CGRectMake(boundsX+150-cellWidth, 8, 80, 30);
            valueLabelLeft.frame = frame;
            
            frame = CGRectMake(boundsX+240-cellWidth, 8, 150, 30);
            secondValueLabelLeft.frame = frame;
        }
    }
    else{
        
        //label has value
        if (lumpsumLabelLeft == nil){
            //need to allocate label
            lumpsumLabelLeft = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
            lumpsumLabelLeft.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview: lumpsumLabelLeft];
            
            frame = CGRectMake(boundsX+100-cellWidth, 16, 120, 30);
            lumpsumLabelLeft.frame = frame;
            //then readjust other labels
            frame = CGRectMake(boundsX+10-cellWidth, 1, 120, 30);
            nameLabelLeft.frame = frame;
            
            frame = CGRectMake(boundsX+150-cellWidth, 1, 80, 30);
            valueLabelLeft.frame = frame;
            
            frame = CGRectMake(boundsX+240-cellWidth, 1, 150, 30);
            secondValueLabelLeft.frame = frame;
            
            
        }
        lumpsumLabelLeft.text = [[[NSString alloc] initWithFormat: @"Lump sum: %@", leftStr] autorelease];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
    
    CGRect contentRect = self.contentView.bounds;
    
    if (!self.editing){
        CGFloat boundsX = contentRect.origin.x;
        CGFloat cellWidth = contentRect.size.width;
        CGRect frame;
        
        CGFloat cBoundsY = 8;
        if (lumpsumLabel != nil){
            cBoundsY = 1;
        }
        CGFloat lBoundsY = 8;
        if (lumpsumLabelLeft != nil){
            lBoundsY = 1;
        }
        CGFloat rBoundsY = 8;
        if (lumpsumLabelRight != nil){
            rBoundsY = 1;
        }
        
        bkg.frame = CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
        
        frame = CGRectMake(boundsX, 0, 50,  contentRect.size.height);
        leftLabelTag.frame = frame;
        
        frame = CGRectMake(boundsX+10, cBoundsY, 120, 30);
        nameLabel.frame = frame;
        
        frame = CGRectMake(boundsX+150, cBoundsY, 80, 30);
        valueLabel.frame = frame;
        
        frame = CGRectMake(boundsX+240, cBoundsY, 150, 30);
        secondValueLabel.frame = frame;
        
        frame = CGRectMake(boundsX+10-cellWidth, lBoundsY, 120, 30);
        nameLabelLeft.frame = frame;
        
        frame = CGRectMake(boundsX+150-cellWidth, lBoundsY, 80, 30);
        valueLabelLeft.frame = frame;
        
        frame = CGRectMake(boundsX+240-cellWidth, lBoundsY, 150, 30);
        secondValueLabelLeft.frame = frame;
        
        
        frame = CGRectMake(boundsX+10+cellWidth, rBoundsY, 120, 30);
        nameLabelRight.frame = frame;
        
        frame = CGRectMake(boundsX+150+cellWidth, rBoundsY, 80, 30);
        valueLabelRight.frame = frame;
        
        
        frame = CGRectMake(boundsX+240+cellWidth, rBoundsY, 150, 30);
        secondValueLabelRight.frame = frame;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [leftLabelTag release];
    
    [nameLabel release];
    [valueLabel release];
    [secondValueLabel release];
    
    [nameLabelLeft release];
    [valueLabelLeft release];
    [secondValueLabelLeft release];
    
    [nameLabelRight release];
    [valueLabelRight release];
    [secondValueLabelRight release];
    
    if (lumpsumLabelRight != nil)
        [lumpsumLabelRight release];
    if (lumpsumLabelLeft != nil)
        [lumpsumLabelLeft release];
    if (lumpsumLabel != nil)
        [lumpsumLabel release];
    
    [super dealloc];
}

- (void) updateContent: (NSNotification *) notification{
    [self updateCells];
}

- (void) move: (NSNotification *) notification{
    NSDictionary* info = [notification userInfo];
    NSNumber *offset = [info objectForKey: @"offset"];
    [self moveLbls: [offset floatValue]];
}

- (void) moveLeft: (NSNotification *) notification{
    [self moveLbls: 1*self.frame.size.width];
    //	[self updateCells];
}

- (void) moveRight: (NSNotification *) notification{
    [self moveLbls: -1*self.frame.size.width];
    //	[self updateCells];
}

- (void) moveLbls: (float) direction{
    if (animateDone == NO) return;
    animateDone = NO;
    CGRect frameLumpsumLbl, lframeLbl2, lframeLbl, lframeNameLbl, lframeLumpLbl, rframeLbl2, rframeLbl, rframeNameLbl, rframeLumpLbl;
    CGRect contentRect = self.contentView.bounds;
    //	CGFloat boundsX = contentRect.origin.x;
    CGFloat cellWidth = contentRect.size.width;
    
    float shift = direction;
    CGRect nameFrame = nameLabel.frame;
    CGRect firstValueFrame = valueLabel.frame;
    CGRect secondValueFrame = secondValueLabel.frame;
    
    CGRect lnameFrame = nameLabelLeft.frame;
    CGRect lfirstValueFrame = valueLabelLeft.frame;
    CGRect lsecondValueFrame = secondValueLabelLeft.frame;
    
    CGRect rnameFrame = nameLabelRight.frame;
    CGRect rfirstValueFrame = valueLabelRight.frame;
    CGRect rsecondValueFrame = secondValueLabelRight.frame;
    
    CGRect lumpsumFrame;
    CGRect llumpsumFrame;
    CGRect rlumpsumFrame;
    
    if (lumpsumLabel != nil){
        lumpsumFrame = lumpsumLabel.frame;
        frameLumpsumLbl = CGRectMake(lumpsumFrame.origin.x +shift , lumpsumFrame.origin.y ,lumpsumFrame.size.width, lumpsumFrame.size.height);
    }
    if (lumpsumLabelLeft != nil)
        llumpsumFrame = lumpsumLabelLeft.frame;
    if (lumpsumLabelRight != nil)
        rlumpsumFrame = lumpsumLabelRight.frame;
    
    
    CGRect frameLbl2 = CGRectMake(secondValueFrame.origin.x +shift , secondValueFrame.origin.y ,secondValueFrame.size.width, secondValueFrame.size.height);
    CGRect frameLbl = CGRectMake(firstValueFrame.origin.x +shift , firstValueFrame.origin.y ,firstValueFrame.size.width, firstValueFrame.size.height);
    CGRect frameNameLbl = CGRectMake(nameFrame.origin.x +shift , nameFrame.origin.y ,nameFrame.size.width, nameFrame.size.height);
    
    if (direction < 0){
        lframeLbl2 = CGRectMake(rsecondValueFrame.origin.x , rsecondValueFrame.origin.y ,rsecondValueFrame.size.width, rsecondValueFrame.size.height);
        lframeLbl = CGRectMake(rfirstValueFrame.origin.x , rfirstValueFrame.origin.y ,rfirstValueFrame.size.width, rfirstValueFrame.size.height);
        lframeNameLbl = CGRectMake(rnameFrame.origin.x , rnameFrame.origin.y ,rnameFrame.size.width, rnameFrame.size.height);
        if (lumpsumLabelLeft != nil)
            lframeLumpLbl = CGRectMake(100+cellWidth , llumpsumFrame.origin.y ,llumpsumFrame.size.width, llumpsumFrame.size.height);
    }
    else{
        lframeLbl2 = CGRectMake(lsecondValueFrame.origin.x +shift , lsecondValueFrame.origin.y ,lsecondValueFrame.size.width, lsecondValueFrame.size.height);
        lframeLbl = CGRectMake(lfirstValueFrame.origin.x +shift , lfirstValueFrame.origin.y ,lfirstValueFrame.size.width, lfirstValueFrame.size.height);
        lframeNameLbl = CGRectMake(lnameFrame.origin.x +shift , lnameFrame.origin.y ,lnameFrame.size.width, lnameFrame.size.height);
        if (lumpsumLabelLeft != nil)
            lframeLumpLbl = CGRectMake(100-cellWidth+shift , llumpsumFrame.origin.y ,llumpsumFrame.size.width, llumpsumFrame.size.height);
    }
    if (direction < 0 ){
        rframeLbl2 = CGRectMake(rsecondValueFrame.origin.x +shift , rsecondValueFrame.origin.y ,rsecondValueFrame.size.width, rsecondValueFrame.size.height);
        rframeLbl = CGRectMake(rfirstValueFrame.origin.x +shift , rfirstValueFrame.origin.y ,rfirstValueFrame.size.width, rfirstValueFrame.size.height);
        rframeNameLbl = CGRectMake(rnameFrame.origin.x +shift , rnameFrame.origin.y ,rnameFrame.size.width, rnameFrame.size.height);
        if (lumpsumLabelRight != nil){
            rframeLumpLbl = CGRectMake(100+cellWidth+shift, rlumpsumFrame.origin.y ,rlumpsumFrame.size.width, rlumpsumFrame.size.height);
        }
    }
    else{
        rframeLbl2 = CGRectMake(lsecondValueFrame.origin.x , lsecondValueFrame.origin.y ,lsecondValueFrame.size.width, lsecondValueFrame.size.height);
        rframeLbl = CGRectMake(lfirstValueFrame.origin.x , lfirstValueFrame.origin.y ,lfirstValueFrame.size.width, lfirstValueFrame.size.height);
        rframeNameLbl = CGRectMake(lnameFrame.origin.x , lnameFrame.origin.y ,lnameFrame.size.width, lnameFrame.size.height);
        if (lumpsumLabelRight != nil)
            rframeLumpLbl = CGRectMake(100-cellWidth , rlumpsumFrame.origin.y ,rlumpsumFrame.size.width, rlumpsumFrame.size.height);
    }
    
    
    if (direction < 0){
        [UIView beginAnimations: @"move cells" context:nil];
        [UIView setAnimationDuration: 0.6];
        nameLabel.frame = frameNameLbl;
        valueLabel.frame = frameLbl;
        secondValueLabel.frame = frameLbl2;
        
        nameLabelRight.frame = rframeNameLbl;
        valueLabelRight.frame = rframeLbl;
        secondValueLabelRight.frame = rframeLbl2;
        
        if (lumpsumLabel != nil)
            lumpsumLabel.frame = frameLumpsumLbl;
        if (lumpsumLabelRight != nil)
            lumpsumLabelRight.frame = rframeLumpLbl;
        
        [UIView setAnimationDelegate: self];
        [UIView setAnimationDidStopSelector: @selector(animationDone:finished:context:)];
        [UIView commitAnimations];
        
        nameLabelLeft.frame = lframeNameLbl;
        valueLabelLeft.frame = lframeLbl;
        secondValueLabelLeft.frame = lframeLbl2;
        if (lumpsumLabelLeft != nil)
            lumpsumLabelLeft.frame = lframeLumpLbl;
        
        UILabel *tnameLabel = nameLabelLeft;
        UILabel *tvalueLabel = valueLabelLeft;
        UILabel *tsecondValueLabel = secondValueLabelLeft;
        UILabel *tlumpsumValueLabel = lumpsumLabelLeft;
        
        UILabel *t2nameLabel = nameLabel;
        UILabel *t2valueLabel = valueLabel;
        UILabel *t2secondValueLabel = secondValueLabel;			
        UILabel *t2lumpsumValueLabel = lumpsumLabel;
        
        nameLabel = nameLabelRight;
        valueLabel = valueLabelRight;
        secondValueLabel = secondValueLabelRight;	
        lumpsumLabel = lumpsumLabelRight;
        
        nameLabelLeft = t2nameLabel;
        valueLabelLeft = t2valueLabel;
        secondValueLabelLeft = t2secondValueLabel;	
        lumpsumLabelLeft = t2lumpsumValueLabel;
        
        nameLabelRight = tnameLabel;
        valueLabelRight = tvalueLabel;
        secondValueLabelRight = tsecondValueLabel;		
        lumpsumLabelRight = tlumpsumValueLabel;
        
    }
    else{
        
        [UIView beginAnimations: @"move cells" context:nil];
        [UIView setAnimationDuration: 0.6];	
        nameLabel.frame = frameNameLbl;
        valueLabel.frame = frameLbl;
        secondValueLabel.frame = frameLbl2;
        
        nameLabelLeft.frame = lframeNameLbl;
        valueLabelLeft.frame = lframeLbl;
        secondValueLabelLeft.frame = lframeLbl2;			
        
        if (lumpsumLabel != nil)
            lumpsumLabel.frame = frameLumpsumLbl;	
        if (lumpsumLabelLeft != nil)
            lumpsumLabelLeft.frame = lframeLumpLbl;			
        
        [UIView setAnimationDelegate: self];
        [UIView setAnimationDidStopSelector: @selector(animationDone:finished:context:)];
        [UIView commitAnimations];
        
        nameLabelRight.frame = rframeNameLbl;
        valueLabelRight.frame = rframeLbl;
        secondValueLabelRight.frame = rframeLbl2;			
        if (lumpsumLabelRight != nil)
            lumpsumLabelRight.frame = rframeLumpLbl;	
        
        UILabel *tnameLabel = nameLabelRight;
        UILabel *tvalueLabel = valueLabelRight;
        UILabel *tsecondValueLabel = secondValueLabelRight;		
        UILabel *tlumpsumValueLabel = lumpsumLabelRight;
        
        UILabel *t2nameLabel = nameLabel;
        UILabel *t2valueLabel = valueLabel;
        UILabel *t2secondValueLabel = secondValueLabel;			
        UILabel *t2lumpsumValueLabel = lumpsumLabel;
        
        nameLabel = nameLabelLeft;
        valueLabel = valueLabelLeft;
        secondValueLabel = secondValueLabelLeft;		
        lumpsumLabel = lumpsumLabelLeft;
        
        nameLabelRight = t2nameLabel;
        valueLabelRight = t2valueLabel;
        secondValueLabelRight = t2secondValueLabel;		
        lumpsumLabelRight = t2lumpsumValueLabel;
        
        nameLabelLeft = tnameLabel;
        valueLabelLeft = tvalueLabel;
        secondValueLabelLeft = tsecondValueLabel;		
        lumpsumLabelLeft = tlumpsumValueLabel;		
    }	
}

@end
