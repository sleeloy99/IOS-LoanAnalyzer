//
//  PercentKeyPadViewController.m
//
//  Created by Sheldon Lee-Loy on 2/16/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "PercentKeyPadViewController.h"

@implementation PercentKeyPadViewController

/// Key IDS
NSInteger const DECIMAL_KEY_ID = -2;
NSInteger const RETURN_KEY_ID = -1;

/// SLIDER CONSTANTS
NSInteger const MINMAX_SLIDER_PRECISION = 100;
NSInteger const MINMAX_SLIDER_PRECENT_FACTOR = 10;

@synthesize compoundPeriodCtrl;
@synthesize labelValue, cmpLbl, btnOne, btnTwo, btnThree, btnFour, btnFive, btnSix, btnSeven, btnEight, btnNine, btnDecimal, btnReturn, btnZero;
@synthesize btnStatusBar, upImageBtn, displayStr;
@synthesize twoModeView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        isExpanded = NO;
        decimalPlace = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoaded = NO;
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    windowHieght = screenHeight - 64.0f;
    
    self.twoModeView.minHeight = 125;
    self.twoModeView.maxHeight = 255;
    //add image view
    imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 18, 320, 40);
    
    NSString *path=[[NSBundle mainBundle] pathForResource: @"displayBkg" ofType:@"png"];
    UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
    imgView.image = image;
    [image release];
    [self.view addSubview: imgView];
    imgView.hidden = YES;
    
    path=[[NSBundle mainBundle] pathForResource: @"calcBkg" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    ((UIImageView *)self.view).image = image;
    [image release];
    
    
    path=[[NSBundle mainBundle] pathForResource: @"headerBkg" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    
    [btnStatusBar setBackgroundImage:image forState: UIControlStateNormal];
    btnStatusBar.backgroundColor = [UIColor clearColor];
    [btnStatusBar.titleLabel setFont: [UIFont boldSystemFontOfSize:12.0]];
    [btnStatusBar setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnStatusBar setTitle: @"Interest Rate" forState:UIControlStateNormal];
    [image release];
    
    path=[[NSBundle mainBundle] pathForResource: @"arrowUp" ofType:@"png"];
    image = [[UIImage imageWithContentsOfFile: path] retain];
    [upImageBtn setBackgroundImage:image forState: UIControlStateNormal];
    [image release];
    
    path=[[NSBundle mainBundle] pathForResource: @"numberBtn" ofType:@"png"];
    image = [UIImage imageWithContentsOfFile: path];
    
    [btnOne setBackgroundImage:image forState: UIControlStateNormal];
    btnOne.backgroundColor = [UIColor clearColor];
    
    [btnTwo setBackgroundImage:image forState: UIControlStateNormal];
    btnTwo.backgroundColor = [UIColor clearColor];
    [btnThree setBackgroundImage:image forState: UIControlStateNormal];
    btnThree.backgroundColor = [UIColor clearColor];
    [btnFour setBackgroundImage:image forState: UIControlStateNormal];
    btnFour.backgroundColor = [UIColor clearColor];
    [btnFive setBackgroundImage:image forState: UIControlStateNormal];
    btnFive.backgroundColor = [UIColor clearColor];
    [btnSix setBackgroundImage:image forState: UIControlStateNormal];
    btnSix.backgroundColor = [UIColor clearColor];
    [btnSeven setBackgroundImage:image forState: UIControlStateNormal];
    btnSeven.backgroundColor = [UIColor clearColor];
    [btnEight setBackgroundImage:image forState: UIControlStateNormal];
    btnEight.backgroundColor = [UIColor clearColor];
    [btnNine setBackgroundImage:image forState: UIControlStateNormal];
    btnNine.backgroundColor = [UIColor clearColor];
    NSString *backSpacePath=[[NSBundle mainBundle] pathForResource: @"backSpace" ofType:@"png"];
    UIImage *backSpaceImg = [UIImage imageWithContentsOfFile: backSpacePath];
    
    [btnReturn setBackgroundImage:backSpaceImg forState: UIControlStateNormal];
    btnReturn.backgroundColor = [UIColor clearColor];
    [btnZero setBackgroundImage:image forState: UIControlStateNormal];
    btnZero.backgroundColor = [UIColor clearColor];
    [btnDecimal setBackgroundImage:image forState: UIControlStateNormal];
    btnDecimal.backgroundColor = [UIColor clearColor];
    
    [btnOne.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnOne setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnTwo.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnTwo setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnThree.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnThree setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnFour.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnFour setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnFive.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnFive setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnSix.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnSix setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnSeven.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnSeven setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnEight.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnEight setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnNine.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnNine setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnReturn.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnReturn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnZero.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
    [btnZero setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [btnDecimal.titleLabel setFont: [UIFont boldSystemFontOfSize:16.0]];
    [btnDecimal setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    
    labelValue = [[UILabel alloc] initWithFrame: CGRectMake(0, 20, 320, 40)];
    labelValue.textAlignment = NSTextAlignmentCenter;
    labelValue.backgroundColor = [UIColor clearColor];
    labelValue.textColor = [UIColor whiteColor];
    labelValue.font = [UIFont boldSystemFontOfSize:20.0];
    [self.view addSubview: labelValue];
    
    increment = .25f;
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        compoundPeriodCtrl.tintColor = [UIColor whiteColor];
    }
    
    [self setControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
}


-(void) sliderTouchUp: (id) sender{
    [self updateMinMaxLabels];
    //need to update chart
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

- (void) updateMinMaxLabels{
    
    if ((self.slider.maximumValue == self.slider.value) || (self.slider.minimumValue == self.slider.value)){
        double newMax;
        double newMin;
        //check if slider is at maximum amount
        
        if (self.slider.maximumValue == self.slider.value){
            newMax = self.slider.maximumValue*increment*1.5+minValue;
            newMin = self.slider.maximumValue*increment*.5+minValue;
        }
        else if (self.slider.minimumValue == self.slider.value){
            newMax = maxValue-self.slider.maximumValue*increment*.5;
            newMin = minValue-self.slider.maximumValue*increment*.5;
        }
        if ((newMin >=0) && (newMax <= MINMAX_SLIDER_PRECISION)){
            minValue = newMin;
            maxValue = newMax;
            
            [UIView beginAnimations: nil context: nil];
            [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration: 0.5f];
            
            self.slider.value = ((int)(self.slider.maximumValue/2+.5f));
            
            //format string
            NSNumber *aNumber = [NSNumber numberWithDouble: maxValue/MINMAX_SLIDER_PRECISION];
            NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
            
            [aFormatter setNumberStyle: NSNumberFormatterPercentStyle];
            
            self.maxLbl.text = [aFormatter stringFromNumber: aNumber];
            
            aNumber = [NSNumber numberWithDouble: minValue/MINMAX_SLIDER_PRECISION];
            
            self.minLbl.text = [aFormatter stringFromNumber: aNumber];
            
            [aFormatter release];
            
            [UIView commitAnimations];
        }
    }
}

- (void) setControls{
    CompoundPeriodEnum compoundPeriodVal = 0;
    switch ([[ModelObject instance].selectedObject.compoundPeriod getCompoundValue]) {
        case CMONTHLY:
            compoundPeriodVal = 0;
            break;
        case CANNUAL:
            compoundPeriodVal = 1;
            break;
        case CSEMIANNUAL:
            compoundPeriodVal = 2;
            break;
        default:
            break;
    }
    compoundPeriodCtrl.selectedSegmentIndex = compoundPeriodVal;
    [self initializeSliderMinMax];
}

- (void) compoundPeriodChanged: (id) sender{
    CompoundPeriodEnum compoundPeriodVal = CMONTHLY;
    switch (compoundPeriodCtrl.selectedSegmentIndex) {
        case 0:
            compoundPeriodVal = CMONTHLY;
            break;
        case 1:
            compoundPeriodVal = CANNUAL;
            break;
        case 2:
            compoundPeriodVal = CSEMIANNUAL;
            break;
        default:
            break;
    }
    
    [[ModelObject instance].selectedObject.compoundPeriod setCompoundValue: compoundPeriodVal];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

/***************
 *Num KeyPad Methods
 ***************/

- (IBAction) pressZero:(id) sender{
    if ((self.displayStr != nil) && [self.displayStr length] > 0){
        [self keyPressed:0];
    }
}
- (IBAction) pressOne:(id) sender{
    [self keyPressed:1];
}
- (IBAction) pressTwo:(id) sender{
    [self keyPressed:2];
}
- (IBAction) pressThree:(id) sender{
    [self keyPressed:3];
}
- (IBAction) pressFour:(id) sender{
    [self keyPressed:4];
}
- (IBAction) pressFive:(id) sender{
    [self keyPressed:5];
}
- (IBAction) pressSix:(id) sender{
    [self keyPressed:6];
}
- (IBAction) pressSeven:(id) sender{
    [self keyPressed:7];
}
- (IBAction) pressEight:(id) sender{
    [self keyPressed:8];
}
- (IBAction) pressNine:(id) sender{
    [self keyPressed:9];
}
- (IBAction) pressDecimal:(id) sender{
    [self keyPressed:DECIMAL_KEY_ID];
}
- (IBAction) pressReturn:(id) sender{
    [self keyPressed:RETURN_KEY_ID];
}

- (void)setLabelText: (NSString*) label{
    labelValue.text = label;
}

- (void) keyPressed: (int) value{
    NSString *oldDisplayStr = [self.displayStr copy];
    if (value == RETURN_KEY_ID){
        if ([self.displayStr length] > 0){
            int len = (int)[self.displayStr length]-1;
            self.displayStr = [oldDisplayStr substringToIndex:len];
            NSString *decimal = [oldDisplayStr substringFromIndex:len];
            
            if ([decimal isEqualToString: @"."]){
                decimalPlace = NO;
            }
        }
        else
            self.displayStr = @"";
    }
    else if (value == DECIMAL_KEY_ID){
        if (!decimalPlace){
            self.displayStr = [NSString stringWithFormat: @"%@%@", self.displayStr, @"."];
        }
        decimalPlace = YES;
    }
    else{
        self.displayStr = [NSString stringWithFormat: @"%@%d", self.displayStr, value];
    }
    
    NSRange textRange = [self.displayStr rangeOfString: @"."];
    BOOL okayToUpdate = YES;
    
    /// Check to see if decimal place is greater than 2 precision points
    if (textRange.location != NSNotFound){
        if (((textRange.location) > 4) || (([self.displayStr length] - textRange.location) > 5)){
            okayToUpdate = NO;
        }
    }
    else if ([self.displayStr length] > 4){
        okayToUpdate = NO;
    }
    
    if (okayToUpdate){
        
        [self setLabelText: [NSString stringWithFormat: @"%@%%", self.displayStr]];
        if ([self.displayStr length] == 0){
            numberValue = 0;
        }
        else{
            numberValue = [self.displayStr floatValue];
        }
        if ((self.displayStr!= nil)){
            [[ModelObject instance].selectedObject.interestRate setPercentValue: numberValue];
        }
        [self sendUpdateNotification];
    }
    else{
        self.displayStr = oldDisplayStr;
    }
    [oldDisplayStr release];
}

- (void) sendUpdateNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

-(void) closeView: (id) sender{
    if (isExpanded){
        [self expandView: !isExpanded];
    }
    
    [super closeView: sender];
}

-(BOOL) getIsExpanded{
    return isExpanded;
}

-(void) setIsExpanded: (BOOL) expand{
    isExpanded = expand;
}

- (void) expandView: (BOOL) expand{
    
    CGRect rec = self.view.frame;
    double alpha, alphaInverse;
    
    NSString *path;
    UIImage *image;
    
    if ([self getIsExpanded] != expand){
        [self setIsExpanded: expand];
        if (expand){
            path=[[NSBundle mainBundle] pathForResource: @"arrowDown" ofType:@"png"];
            image = [[UIImage imageWithContentsOfFile: path] retain];
            
            rec.origin.y = windowHieght - self.twoModeView.maxHeight;
            alpha = 0;
            alphaInverse = 1;
            numberValue = [[ModelObject instance].selectedObject.interestRate getPercentValue];
            //need to update calc label
            NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
            
            NSNumber *aNumber = [NSNumber numberWithFloat: numberValue];
            
            [aFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
            [aFormatter setMaximumIntegerDigits: 4];
            
            NSString *newText = [aFormatter stringFromNumber: aNumber];
            NSRange textRange = [newText rangeOfString: @"."];
            decimalPlace = textRange.location != NSNotFound;
            
            self.displayStr = newText;
            labelValue.text = [NSString stringWithFormat: @"%@%%", newText];
            
            [aFormatter release];
        }
        else{
            path=[[NSBundle mainBundle] pathForResource: @"arrowUp" ofType:@"png"];
            image = [[UIImage imageWithContentsOfFile: path] retain];
            
            rec.origin.y = windowHieght- self.twoModeView.minHeight;
            alpha = 1;
            alphaInverse = 0;
            //need to update min max slider
            [self initializeSliderMinMax];
        }
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration: 0.5f];
        [upImageBtn setBackgroundImage:image forState: UIControlStateNormal];
        
        [self setAlphaControls: alpha alphaInverse:alphaInverse];
        self.view.frame = CGRectMake(rec.origin.x, rec.origin.y, rec.size.width, rec.size.height);
        [UIView commitAnimations];
        [self expandControls: expand];
        [image release];
        
    }
}

- (void) setAlphaControls: (double) alpha alphaInverse: (double) alphaInverse{
    maxLbl.alpha = alpha;
    minLbl.alpha = alpha;
    cmpLbl.alpha = alpha;
    slider.alpha = alpha;
    compoundPeriodCtrl.alpha = alpha;
    
    btnOne.alpha = alphaInverse;
    btnTwo.alpha = alphaInverse;
    btnThree.alpha = alphaInverse;
    btnFour.alpha = alphaInverse;
    btnFive.alpha = alphaInverse;
    btnSix.alpha = alphaInverse;
    btnSeven.alpha = alphaInverse;
    btnEight.alpha = alphaInverse;
    btnNine.alpha = alphaInverse;
    btnDecimal.alpha = alphaInverse;
    btnReturn.alpha = alphaInverse;
    btnZero.alpha = alphaInverse;
    labelValue.alpha = alphaInverse;
}

- (void) expandControls: (BOOL) expand{
    imgView.hidden = !expand;
    btnOne.hidden = !expand;
    btnTwo.hidden = !expand;
    btnThree.hidden = !expand;
    btnFour.hidden = !expand;
    btnFive.hidden = !expand;
    btnSix.hidden = !expand;
    btnSeven.hidden = !expand;
    btnEight.hidden = !expand;
    btnNine.hidden = !expand;
    btnDecimal.hidden = !expand;
    btnReturn.hidden = !expand;
    btnZero.hidden = !expand;
    labelValue.hidden = !expand;
    slider.hidden = expand;
}

- (void) displaySelectedView: (BOOL) show{
    
    CGRect rec = self.view.frame;
    
    if (show){
        rec.origin.y = windowHieght - self.twoModeView.minHeight;
    }
    else{
        [self expandView: NO];
        rec.origin.y = windowHieght + self.twoModeView.minHeight;
    }
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.5f];
    self.view.frame = CGRectMake(rec.origin.x, rec.origin.y, rec.size.width, rec.size.height);
    [UIView commitAnimations];
    if (show == NO){
        [[NSNotificationCenter defaultCenter] postNotificationName: @"closingkeypad" object: self];
    }
}

- (void) expandSelectedView: (id) sender{
    BOOL newState = ![self getIsExpanded];
    [self expandView: newState];
}

- (void) initializeSliderMinMax{
    float tmpValue = [[ModelObject instance].selectedObject.interestRate getPercentValue];
    
    float tmpMinValue = 0;
    while (tmpMinValue < tmpValue){
        tmpMinValue += MINMAX_SLIDER_PRECENT_FACTOR;
    }
    
    minValue = tmpMinValue-MINMAX_SLIDER_PRECENT_FACTOR;
    maxValue = tmpMinValue+MINMAX_SLIDER_PRECENT_FACTOR;
    
    self.slider.value = (int)((tmpValue-minValue)/(increment)+0.5f);
    
    //format string
    NSNumber *aNumber = [NSNumber numberWithFloat: maxValue/MINMAX_SLIDER_PRECISION];
    NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
    
    [aFormatter setNumberStyle: NSNumberFormatterPercentStyle];
    
    self.maxLbl.text = [aFormatter stringFromNumber: aNumber];
    
    aNumber = [NSNumber numberWithFloat: minValue/MINMAX_SLIDER_PRECISION];
    
    self.minLbl.text = [aFormatter stringFromNumber: aNumber];
    
    [aFormatter release];
}

- (void) slideEvent: (id) sender{
    numberValue = [self trueValue];
    [[ModelObject instance].selectedObject.interestRate setPercentValue: numberValue];	
}

- (float) trueValue{
    return ((int)(self.slider.value+.5f))*increment+minValue;
}

- (void)dealloc {
    [displayStr release];
    [cmpLbl release];
    [imgView release];
    [btnStatusBar release];	
    [compoundPeriodCtrl release];
    [upImageBtn release];
    [btnStatusBar release];
    [twoModeView release];
    [labelValue release];
    [btnOne release]; 
    [btnTwo release]; 
    [btnThree release]; 
    [btnFour release]; 
    [btnFive release]; 
    [btnSix release]; 
    [btnSeven release]; 
    [btnEight release]; 
    [btnNine release]; 
    [btnDecimal release]; 
    [btnReturn release]; 
    [btnZero release];			
    [super dealloc];
}

@end

