//
//  LoanController.m
//  LoanAnalyzer
//
//  Created by Sheldon Lee-Loy on 3/26/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "LoanController.h"

@implementation LoanController

- (void) hideTableWithFrame: (CGRect)frame{
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)buildView: (NSTextAlignment) lblAlignment valueAlignment: (NSTextAlignment) valueAlignment backImageStr: (NSString *) backImageStr frame: (CGRect) frame{
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float midPoint = screenWidth / 2;
    
    self.view.frame = frame;
    
    NSString *path=[[NSBundle mainBundle] pathForResource: @"comparebkg" ofType:@"png"];
    UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
    ((UIImageView*)self.view).image = image;
    [image release];
    
    /// add image background view
    imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 0, midPoint, 40);
    
    
    path=[[NSBundle mainBundle] pathForResource: @"displayBkg" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    imgView.image = image;
    [image release];
    [self.view addSubview: imgView];
    
    //back button
    path=[[NSBundle mainBundle] pathForResource: backImageStr ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    int xButtonOffset = 6;
    if (lblAlignment ==  NSTextAlignmentRight)
        xButtonOffset = midPoint - xButtonOffset - 50;
    backButton = [[UIButton buttonWithType: UIButtonTypeCustom] retain];
    backButton.frame = CGRectMake(xButtonOffset, 6, 50, 24);
    [backButton setBackgroundImage:image forState: UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton.titleLabel setFont: [UIFont boldSystemFontOfSize:11.0]];
    [backButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitle: @"Back" forState:UIControlStateNormal];
    [backButton addTarget: self action:@selector(hideTable:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: backButton];
    [image release];
    
    /// labels
    int xTitleOffset = 60;
    if (lblAlignment ==  NSTextAlignmentRight)
        xTitleOffset = midPoint - 180 - xTitleOffset;
    titleLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:20 bold:YES];
    titleLabel.textAlignment = lblAlignment;
    titleLabel.frame  = CGRectMake(xTitleOffset, 5, 180, 35);
    [self.view addSubview: titleLabel];
    [titleLabel release];
    
    detailView = [[UIView alloc] initWithFrame: CGRectMake(0, 40, midPoint, 250)];
    detailView.backgroundColor = [UIColor clearColor];
    isLeft = (valueAlignment ==  NSTextAlignmentRight);
    
    //Principal Column
    int offset = -39;
    int valueX = midPoint-210;
    int arrowX = midPoint-232;
    int labelX = 30;
    int lineX = 25;
    int lumpX = 15;
    int lumpDecor = 50;
    int align = 0;
    if (valueAlignment ==  NSTextAlignmentRight){
        valueX = midPoint - 120-valueX;
        arrowX = midPoint - 12-arrowX;
    }
    if (lblAlignment ==  NSTextAlignmentRight){
        lineX = midPoint - lineX - 210;
        lumpX =  midPoint - lumpX  - 220;
        lumpDecor = midPoint - lumpDecor -12;
        labelX = midPoint-labelX-105;
        align = 1;
    }
    
    principlaAmtLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:YES];
    principlaAmtLbl.textAlignment = valueAlignment;
    principlaAmtLbl.frame  = CGRectMake(valueX, offset+52, 120, 17);
    [detailView addSubview: principlaAmtLbl];
    [principlaAmtLbl release];
    
    UILabel *principlaAmtLbll = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:NO];
    principlaAmtLbll.textAlignment = lblAlignment;
    principlaAmtLbll.frame  = CGRectMake(labelX+(align*30), offset+52, 75, 17);
    principlaAmtLbll.text = @"Principal";
    [detailView addSubview: principlaAmtLbll];
    [principlaAmtLbll release];
    
    principalDiff = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor greenColor] fontSize: 10 bold:YES];
    principalDiff.textAlignment = valueAlignment;
    principalDiff.frame  = CGRectMake(valueX, offset+69, 120, 10);
    [detailView addSubview: principalDiff];
    [principalDiff release];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(lineX, offset+84, 210, 3);
    path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    lineView.image = image;
    [image release];
    [detailView addSubview: lineView];
    [lineView release];
    
    principalArrow = [[UIImageView alloc] init];
    principalArrow.frame = CGRectMake(arrowX, offset+52, 12, 19);
    path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    principalArrow.image = image;
    principalArrow.hidden = YES;
    [image release];
    [detailView addSubview: principalArrow];
    
    //Interest Amount Column
    offset += 40;
    interestAmtLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:YES];
    interestAmtLbl.textAlignment = valueAlignment;
    interestAmtLbl.frame  = CGRectMake(valueX, offset+52, 120, 17);
    [detailView addSubview: interestAmtLbl];
    [interestAmtLbl release];
    
    UILabel *interestAmtLbll = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:NO];
    interestAmtLbll.textAlignment = lblAlignment;
    interestAmtLbll.frame  = CGRectMake(labelX+(align*10), offset+ 52, 95, 17);
    interestAmtLbll.text = @"Interest Amt";
    [detailView addSubview: interestAmtLbll];
    [interestAmtLbll release];
    
    interestAmtDiff = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor greenColor] fontSize: 10 bold:YES];
    interestAmtDiff.textAlignment = valueAlignment;
    interestAmtDiff.frame  = CGRectMake(valueX, offset+69, 120, 10);
    [detailView addSubview: interestAmtDiff];
    [interestAmtDiff release];
    
    interestAmtArrow = [[UIImageView alloc] init];
    interestAmtArrow = [[UIImageView alloc] init];
    interestAmtArrow.frame = CGRectMake(arrowX, offset+52, 12, 19);
    interestAmtArrow.frame = CGRectMake(arrowX, offset+52, 12, 19);
    path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    interestAmtArrow.image = image;
    interestAmtArrow.hidden = YES;
    [image release];
    [detailView addSubview: interestAmtArrow];
    
    lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(lineX, offset+84, 210, 3);
    path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    lineView.image = image;
    [image release];
    [detailView addSubview: lineView];
    [lineView release];
    
    
    //Interest Rate Column
    offset += 40;
    interestRateLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:YES];
    interestRateLbl.textAlignment = valueAlignment;
    interestRateLbl.frame  = CGRectMake(valueX, offset+52, 120, 17);
    [detailView addSubview: interestRateLbl];
    [interestRateLbl release];
    
    UILabel *interestRateLbll = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:NO];
    interestRateLbll.textAlignment = lblAlignment;
    interestRateLbll.frame  = CGRectMake(labelX, offset+ 52, 105, 17);
    interestRateLbll.text = @"Interest Rate";
    [detailView addSubview: interestRateLbll];
    [interestRateLbll release];
    
    interestRateDiff = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor greenColor] fontSize: 10 bold:YES];
    interestRateDiff.textAlignment = valueAlignment;
    interestRateDiff.frame  = CGRectMake(valueX, offset+69, 120, 10);
    [detailView addSubview: interestRateDiff];
    [interestRateDiff release];
    
    interestRateArrow = [[UIImageView alloc] init];
    interestRateArrow.frame = CGRectMake(arrowX, offset+52, 12, 19);
    path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    interestRateArrow.image = image;
    interestRateArrow.hidden = YES;
    [image release];
    
    [detailView addSubview: interestRateArrow];
    lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(lineX, offset+84, 210, 3);
    path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    lineView.image = image;
    [image release];
    [detailView addSubview: lineView];
    [lineView release];
    
    //Amortization Column
    offset += 40;
    amoritizationLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:YES];
    amoritizationLbl.textAlignment = valueAlignment;
    amoritizationLbl.frame  = CGRectMake(valueX, offset+52, 120, 17);
    [detailView addSubview: amoritizationLbl];
    [amoritizationLbl release];
    
    UILabel *amortizationLbll = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:NO];
    amortizationLbll.textAlignment = lblAlignment;
    amortizationLbll.frame  = CGRectMake(labelX, offset+ 52, 105, 17);
    amortizationLbll.text = @"Amortization";
    [detailView addSubview: amortizationLbll];
    [amortizationLbll release];
    
    amoritizationDiff = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor greenColor] fontSize: 10 bold:YES];
    amoritizationDiff.textAlignment = valueAlignment;
    amoritizationDiff.frame  = CGRectMake(valueX, offset+69, 120, 10);
    [detailView addSubview: amoritizationDiff];
    [amoritizationDiff release];
    
    amoritizationArrow = [[UIImageView alloc] init];
    amoritizationArrow.frame = CGRectMake(arrowX, offset+52, 12, 19);
    path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    amoritizationArrow.image = image;
    amoritizationArrow.hidden = YES;
    [image release];
    [detailView addSubview: amoritizationArrow];
    
    lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(lineX, offset+84, 210, 3);
    path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    lineView.image = image;
    [image release];
    [detailView addSubview: lineView];
    [lineView release];
    
    //Payment Amount Column
    offset += 40;
    paymentAmtLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:YES];
    paymentAmtLbl.textAlignment = valueAlignment;
    paymentAmtLbl.frame  = CGRectMake(valueX, offset+52, 120, 17);
    [detailView addSubview: paymentAmtLbl];
    [paymentAmtLbl release];
    
    UILabel *paymentAmtLbll = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize: 16 bold:NO];
    paymentAmtLbll.textAlignment = lblAlignment;
    paymentAmtLbll.frame  = CGRectMake(labelX, offset+ 52, 105, 17);
    paymentAmtLbll.text = @"Payment Amt";
    [detailView addSubview: paymentAmtLbll];
    [paymentAmtLbll release];
    
    paymentAmtDiff = [self newLabelWithPrimaryColor: [UIColor greenColor] selectedColor:[UIColor greenColor] fontSize: 10 bold:YES];
    paymentAmtDiff.textAlignment = valueAlignment;
    paymentAmtDiff.frame  = CGRectMake(valueX, offset+69, 120, 10);
    [detailView addSubview: paymentAmtDiff];
    [paymentAmtDiff release];
    
    paymentAmtArrow = [[UIImageView alloc] init];
    paymentAmtArrow.frame = CGRectMake(arrowX, offset+52, 12, 19);
    path=[[NSBundle mainBundle] pathForResource: @"downarrow" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    paymentAmtArrow.image = image;
    paymentAmtArrow.hidden = NO;
    [image release];
    [detailView addSubview: paymentAmtArrow];
    
    lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(lineX, offset+84, 210, 3);
    path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    lineView.image = image;
    [image release];
    [detailView addSubview: lineView];
    [lineView release];
    
    //lumpsum
    offset += 40;
    
    lumpButton = [[UIButton alloc] initWithFrame: CGRectMake(lumpX, offset+50, 220, 30)];
    //	NSString *path=[[NSBundle mainBundle] pathForResource: @"clear" ofType:@"png"];
    [lumpButton setTitle:@"Lump Sum" forState: UIControlStateNormal];
    lumpButton.backgroundColor = [UIColor clearColor];
    [detailView addSubview: lumpButton];
    lumpButton.hidden = YES;
    [lumpButton addTarget: self action:@selector(showLump:) forControlEvents:UIControlEventTouchUpInside];
    
    
    arrordecorator = [[UIImageView alloc] init];
    arrordecorator.frame = CGRectMake(lumpDecor, offset+55, 12, 19);
    if (lblAlignment ==  NSTextAlignmentRight) {
        path=[[NSBundle mainBundle] pathForResource: @"rightdecorator" ofType:@"png"];
    }
    else {
        path=[[NSBundle mainBundle] pathForResource: @"leftdecorator" ofType:@"png"];
    }
    image = [[UIImage imageWithContentsOfFile: path] retain];
    arrordecorator.image = image;
    arrordecorator.hidden = YES;
    [image release];
    [detailView addSubview: arrordecorator];
    [arrordecorator release];
    
    llineView = [[UIImageView alloc] init];
    llineView.frame = CGRectMake(lineX, offset+84, 210, 3);
    path=[[NSBundle mainBundle] pathForResource: @"whiteline" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    llineView.image = image;
    llineView.hidden = YES;
    [image release];
    [detailView addSubview: llineView];
    
    [self.view addSubview: detailView];
}

- (void)setData:(LoanObject *)loanObject{
    //need to check if principal amount is calculated
    if ([loanObject.principalAmt getDollarValue] == -1)
        [loanObject calculatePrincipalInterestAmt];
    titleLabel.text = loanObject.name;
    amoritizationLbl.text = [loanObject.amortization displayStringShort];
    principlaAmtLbl.text = [loanObject.loanAmount displayString];
    interestRateLbl.text =  [loanObject.interestRate displayString];
    paymentAmtLbl.text = [loanObject.paymentAmount monthlyAmtDisplayStringShort: [loanObject.paymentFreq getFreqValue]];
    interestAmtLbl.text =  [loanObject.interestAmt displayString];
    loanObj = loanObject;
    if ([loanObject.lumpSums count] > 0){
        lumpButton.hidden = NO;
        arrordecorator.hidden = NO;
        llineView.hidden = NO;
    }
    else{
        lumpButton.hidden = YES;
        arrordecorator.hidden = YES;
        llineView.hidden = YES;
    }
    
}

- (void) compareObjectChanged: (LoanObject *) right left: (LoanObject *) left{
    if (right == nil) {
        paymentAmtDiff.text = @"";
        principalDiff.text = @"";
        interestAmtDiff.text = @"";
        interestRateDiff.text = @"";
        amoritizationDiff.text = @"";
        principalArrow.hidden = YES;
        paymentAmtArrow.hidden = YES;
        interestRateArrow.hidden = YES;
        amoritizationArrow.hidden = YES;
        interestAmtArrow.hidden = YES;
    }
    else{
        
        double value =  [left.paymentAmount getDiff: right.paymentAmount];
        paymentAmtDiff.text =  [left.paymentAmount displayDiffString: right.paymentAmount];
        if (value < 0){
            paymentAmtDiff.textColor = [UIColor greenColor];
            paymentAmtArrow.image = [UIImage imageNamed:@"downarrow.png"];
            paymentAmtArrow.hidden = NO;
        }
        else if (value == 0){
            paymentAmtDiff.text = @"";
            paymentAmtArrow.hidden = YES;
        }
        else{
            paymentAmtDiff.textColor = [UIColor yellowColor];
            paymentAmtArrow.image = [UIImage imageNamed:@"uparrow.png"];
            paymentAmtArrow.hidden = NO;
        }
        value =  [left.loanAmount getDiff: right.loanAmount];
        principalDiff.text =  [left.loanAmount displayDiffString: right.loanAmount];
        if (value < 0){
            principalDiff.textColor = [UIColor greenColor];
            principalArrow.image = [UIImage imageNamed:@"downarrow.png"];
            principalArrow.hidden = NO;
        }
        else if (value == 0){
            principalDiff.text = @"";
            principalArrow.hidden = YES;
        }
        else{
            principalDiff.textColor = [UIColor yellowColor];
            principalArrow.image = [UIImage imageNamed:@"uparrow.png"];
            principalArrow.hidden = NO;
        }
        value =  [left.interestAmt getDiff: right.interestAmt];
        interestAmtDiff.text =  [left.interestAmt displayDiffString: right.interestAmt];
        
        if (value < 0){
            interestAmtDiff.textColor = [UIColor greenColor];
            interestAmtArrow.image = [UIImage imageNamed:@"downarrow.png"];
            interestAmtArrow.hidden = NO;
        }
        else if (value == 0){
            interestAmtDiff.text = @"";
            interestAmtArrow.hidden = YES;
        }
        else{
            interestAmtDiff.textColor = [UIColor yellowColor];
            interestAmtArrow.image = [UIImage imageNamed:@"uparrow.png"];
            interestAmtArrow.hidden = NO;
        }
        value =  [left.interestRate getDiff: right.interestRate];
        interestRateDiff.text =  [left.interestRate displayDiffString: right.interestRate];
        
        if (value < 0){
            interestRateDiff.textColor = [UIColor greenColor];
            interestRateArrow.image = [UIImage imageNamed:@"downarrow.png"];
            interestRateArrow.hidden = NO;
        }
        else if (value == 0){
            interestRateDiff.text = @"";
            interestRateArrow.hidden = YES;
        }
        else{
            interestRateDiff.textColor = [UIColor yellowColor];
            interestRateArrow.image = [UIImage imageNamed:@"uparrow.png"];
            interestRateArrow.hidden = NO;
        }
        
        value =  [left.amortization getDiff: right.amortization];
        amoritizationDiff.text =  [left.amortization displayDiffString: right.amortization];
        
        if (value < 0){
            amoritizationDiff.textColor = [UIColor greenColor];
            amoritizationArrow.image = [UIImage imageNamed:@"downarrow.png"];
            amoritizationArrow.hidden = NO;
        }
        else if (value == 0){
            amoritizationDiff.text = @"";
            amoritizationArrow.hidden = YES;
        }
        else{
            amoritizationDiff.textColor = [UIColor yellowColor];
            amoritizationArrow.image = [UIImage imageNamed:@"uparrow.png"];
            amoritizationArrow.hidden = NO;
        }
    }    
}

- (void) showLump: (NSNotification *) notification{
    //slide lump sum table
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float midPoint = screenWidth / 2;
    
    if (lumpSumTableController == nil){
        if (isLeft)
            lumpSumTableController = [[LumpSumTable alloc] initWithFrame: CGRectMake(midPoint*(-1), 40, midPoint, 250) readOnlyVal:YES];
        else
            lumpSumTableController = [[LumpSumTable alloc] initWithFrame: CGRectMake(screenWidth, 40, midPoint, 250) readOnlyVal:YES];
        lumpSumTableController.delegate = self;
        lumpSumTableController.lumpSums = loanObj.lumpSums;
        [self.view addSubview: lumpSumTableController.view];
    }
    [self pushController: lumpSumTableController];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

-(UIView *) getContainerView{
    return self.view;
}

-(void) pushController: (id) pushedTable{
    id <SlideItemTable>  pushedController  = (id <SlideItemTable>) pushedTable;
    
    UIView *parentTable = detailView;
    UIView *pushedView = [pushedController getTableView];
    [pushedController beforePush];
    
    CGRect frame =  CGRectMake(0, pushedView.frame.origin.y, pushedView.bounds.size.width, pushedView.bounds.size.height);
    CGRect tframe;
    if (isLeft)
        tframe =  CGRectMake(-1*parentTable.frame.size.width, parentTable.frame.origin.y, parentTable.frame.size.width, parentTable.frame.size.height);
    else
        tframe =  CGRectMake(2*parentTable.frame.size.width, parentTable.frame.origin.y, parentTable.frame.size.width, parentTable.frame.size.height);
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    pushedView.frame = frame;
    parentTable.frame = tframe;
    [UIView commitAnimations];
}

-(void)animationDone:(NSString*) animationID finished:(NSNumber *)finished context:(void *)context{
    [lumpSumTableController release];
    lumpSumTableController = nil;
}

-(void) popController{	
    if (lumpSumTableController != nil){
        UIView *popedTable = (UIView *)[lumpSumTableController getTableView];
        UIView *parentTable = detailView; 
        CGRect frame;
        CGRect tframe;
        
        if (isLeft){
            frame =  CGRectMake(-1*popedTable.frame.size.width, popedTable.frame.origin.y, popedTable.bounds.size.width, popedTable.frame.size.height);		
        }
        else{
            frame =  CGRectMake(2*popedTable.frame.size.width, popedTable.frame.origin.y, popedTable.bounds.size.width, popedTable.frame.size.height);		
        }
        tframe =  CGRectMake(0, parentTable.frame.origin.y, parentTable.frame.size.width, parentTable.frame.size.height);		
        
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration: 0.5f];
        popedTable.frame = frame;
        parentTable.frame = tframe;
        [UIView setAnimationDelegate: self];
        [UIView setAnimationDidStopSelector: @selector(animationDone:finished:context:)];		
        [UIView commitAnimations];
        
    }
}

- (void)dealloc {
    if (lumpSumTableController != nil){
        [lumpSumTableController release];
    }
    [loanObj release];
    [arrordecorator release];
    [llineView release];
    [lumpButton release];	
    [amoritizationLbl release];
    [amoritizationDiff release];
    [paymentAmtLbl release];
    [paymentAmtDiff release];
    [interestAmtDiff release];
    [interestAmtLbl release];
    [principalDiff release];
    [principlaAmtLbl release];
    [titleLabel release];
    [imgView release];
    [backButton release];
    [principalArrow release];
    [paymentAmtArrow release];
    [interestRateArrow release];
    [amoritizationArrow release];
    [interestAmtArrow release];
    [detailView release];
    [super dealloc];
}

@end
