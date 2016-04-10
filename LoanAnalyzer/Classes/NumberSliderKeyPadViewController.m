//
//  NumberSliderKeyPadViewController.m
//  
//
//  Created by Sheldon Lee-Loy on 2/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "NumberSliderKeyPadViewController.h"

@implementation NumberSliderKeyPadViewController

@synthesize labelValue, btnOne, btnTwo, btnThree, btnFour, btnFive, btnSix, btnSeven, btnEight, btnNine, btnDecimal, btnReturn, btnZero;
@synthesize btnStatusBar, upImageBtn;
@synthesize twoModeView;
@synthesize minLimit, maxLimit;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dollarObj: (DollarObject *) dollaryObj {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        isExpanded = NO;
        dollarObject = dollaryObj;
        minLimit = 0.0f;
        maxLimit = -1.0f;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoaded = NO;
    float screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    windowHieght = screenHeight - 64.0f;
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

/***************
 *Num KeyPad Methods
 ***************/

- (IBAction) pressZero:(id) sender{
    if ((labelValue.text != nil) && [labelValue.text length] > 0){
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
    [self keyPressed:-2];
}
- (IBAction) pressReturn:(id) sender{
    [self keyPressed:-1];
}

- (void)setLabelText: (NSString*) label{
    labelValue.text = label;
}

- (void) keyPressed: (int) value{
    NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
    if (value == -1){
        double numValueLessOne = floor(numberValue*10);
        numberValue= numValueLessOne/100.0f;
    }
    else if (value == -2){
        numberValue = 0;
    }
    else{
        numberValue = (floor((numberValue*1000)+value))/100.0f;
    }
    
    
    NSNumber *aNumber = [NSNumber numberWithDouble: numberValue];
    
    [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    NSString *newText = [aFormatter stringFromNumber: aNumber];
    [self setLabelText: newText];
    [aFormatter release];
    
    if ((labelValue!= nil) && ([labelValue.text length] > 0)){
        [dollarObject setDollarValue: numberValue];
    }
    [self sendUpdateNotification];
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
            numberValue = [dollarObject getDollarValue];
            //need to update calc label
            NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
            
            NSNumber *aNumber = [NSNumber numberWithDouble: numberValue];
            
            [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            
            NSString *newText = [aFormatter stringFromNumber: aNumber];
            
            labelValue.text = newText;
            
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
    slider.alpha = alpha;
    
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
    if (show == NO)
        [[NSNotificationCenter defaultCenter] postNotificationName: @"closingkeypad" object: self];
    
}

-(void) sliderTouchUp: (id) sender{
    [self updateMinMaxLabels];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"rateAndUpdateChartChanged" object: self];
}

- (void) updateMinMaxLabels{
    
    if ((self.slider.maximumValue == self.slider.value) || (self.slider.minimumValue == self.slider.value)){
        double newMax = 0;
        double newMin = 0;
        double sliderValue = self.slider.value*increment+minValue;
        //check if slider is at maximum amount
        if (self.slider.maximumValue == self.slider.value){
            newMax = self.slider.maximumValue*increment*1.5+minValue;
            newMin = self.slider.maximumValue*increment*.5+minValue;
        }
        else if (self.slider.minimumValue == self.slider.value){
            newMax = maxValue-self.slider.maximumValue*increment*.5;
            newMin = minValue-self.slider.maximumValue*increment*.5;
        }
        if (newMin >= 0){
            if (newMin < minLimit){
                double tmpMinValue = floor(minLimit);
                minValue = tmpMinValue;
                maxValue = tmpMinValue+increment*200.0f;
            }
            else if ((maxLimit > 0) && (newMax > maxLimit)){
                maxValue =  floor(maxLimit);
                minValue = maxValue-increment*200.0f;
            }
            else{
                minValue = newMin;
                maxValue = newMax;
            }
            
            [UIView beginAnimations: nil context: nil];
            [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration: 0.5f];
            self.slider.value = (int)((sliderValue-minValue)*200.0f/(maxValue-minValue)+.5f);
            
            //format string
            NSNumber *aNumber = [NSNumber numberWithDouble: maxValue];
            NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
            
            [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
            
            self.maxLbl.text = [aFormatter stringFromNumber: aNumber];
            
            aNumber = [NSNumber numberWithDouble: minValue];
            
            self.minLbl.text = [aFormatter stringFromNumber: aNumber];
            
            [aFormatter release];
            
            [UIView commitAnimations];
        }
    }
}

- (void) setControls: (DollarObject *) dollarVal{
    dollarObject = dollarVal;
    [self initializeSliderMinMax];
}

- (void) initializeSliderMinMax{
    increment = 1;
    double tmpLoanValue = [dollarObject getDollarValue];
    double tmpValue = tmpLoanValue;
    while (tmpValue >= 1000){
        increment *=10;
        tmpValue = tmpValue/10.0f;
    }
    double tmpMinValue = 0.0;
    increment = increment/2.0f;
    while (tmpMinValue < tmpLoanValue){
        tmpMinValue = tmpMinValue+increment*200.0f;
    }
    
    if (tmpMinValue != 0)
        tmpMinValue = tmpMinValue-increment*200.0f;
    if (tmpMinValue < minLimit){
        tmpMinValue = floor(minLimit);
        minValue = tmpMinValue;
        maxValue = tmpMinValue+increment*200.0f;		
    }
    else if ((maxLimit > 0) && ((tmpMinValue+increment*200.0f) > maxLimit)){
        maxValue =  floor(maxLimit);
        minValue = maxValue-increment*200.0f;
    }
    else{
        minValue = tmpMinValue;
        maxValue = tmpMinValue+increment*200.0f;
    }
    
    self.slider.value = (int)((tmpLoanValue-minValue)*200.0f/(maxValue-minValue)+.5f);
    
    //format string
    NSNumber *aNumber = [NSNumber numberWithDouble: maxValue];
    NSNumberFormatter *aFormatter = [[NSNumberFormatter alloc] init];
    
    [aFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    
    self.maxLbl.text = [aFormatter stringFromNumber: aNumber];
    
    aNumber = [NSNumber numberWithDouble: minValue];
    
    self.minLbl.text = [aFormatter stringFromNumber: aNumber];
    
    [aFormatter release];	
    
}

- (void) expandSelectedView: (id) sender{
    BOOL newState = ![self getIsExpanded];
    [self expandView: newState];
}

- (void) slideEvent: (id) sender{
    numberValue = [self trueValue];
    [dollarObject setDollarValue: numberValue];	
}

- (double) trueValue{
    return ((int)(self.slider.value+.5f))*increment+minValue;
}

- (void)dealloc {    
    [imgView release];
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

