//
//  ChartAppViewController.m
//  ChartApp
//
//  Created by Sheldon Lee-Loy on 4/15/09.
//  Copyright 2009 cellinova inc. All rights reserved.
//

#import "TwoBarChartController.h"

@implementation TwoBarChartController

@synthesize chartObj;

- (id)init{
    if (self = [super init]){
    }
    return self;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            );
}

- (BOOL)shouldAutorotate{
    return YES;
}

/* ios 6 rotation methods */
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskLandscapeRight;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation duration:(NSTimeInterval)duration{
    if (chartArea != nil){
        [chartArea removeFromSuperview];
        [chartArea release];
        chartArea = nil;
    }
    if (yaxis != nil){
        [yaxis removeFromSuperview];
        [yaxis release];
        yaxis = nil;
    }
    if (xaxis != nil){
        [xaxis removeFromSuperview];
        [xaxis release];
        xaxis = nil;
    }
    if (imageView != nil){
        [imageView removeFromSuperview];
        [imageView release];
        imageView = nil;
    }
    if (headerView != nil){
        [headerView removeFromSuperview];
        [headerView release];
        headerView = nil;
    }
    
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    if(toOrientation != UIInterfaceOrientationPortrait && toOrientation != UIInterfaceOrientationPortraitUpsideDown){
        float screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        /// background
        imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 10, screenWidth, 290)];
        NSString *path=[[NSBundle mainBundle] pathForResource: @"LoanAnalyzerBkg" ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile: path] retain];
        imageView.image = image;
        [image release];
        [self.view addSubview: imageView];
        
        /// add header image view
        headerView = [[UIImageView alloc] init];
        headerView.frame = CGRectMake(0, 0, screenWidth, 30);
        
        //main lbl
        UILabel *mainLabel = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:16.0 bold:YES];
        mainLabel.frame = CGRectMake(40, 5, 150, 18);
        mainLabel.text =  chartObj.title;
        mainLabel.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview: mainLabel];
        [mainLabel release];
        
        RoundRectView *seqLegend = [[RoundRectView alloc] initWithFrameColor: CGRectMake(275, 8, 15, 15) red: 0.0 green: 0.8059 blue: 0.9078 alpha: 1.0];
        [headerView addSubview: seqLegend];
        [seqLegend release];
        
        UILabel *seqOneLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
        seqOneLbl.frame = CGRectMake(300, 6, 100, 18);
        seqOneLbl.text =@"Principal";
        seqOneLbl.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview: seqOneLbl];
        [seqOneLbl release];
        
        seqLegend = [[RoundRectView alloc] initWithFrameColor: CGRectMake(385, 8, 15, 15) red: 1.0 green: 0.0 blue: 0.0 alpha: 1.0];
        [headerView addSubview: seqLegend];
        [seqLegend release];
        
        UILabel *seqTwoLbl = [self newLabelWithPrimaryColor: [UIColor whiteColor] selectedColor:[UIColor whiteColor] fontSize:12.0 bold:NO];
        seqTwoLbl.frame = CGRectMake(410, 6, 100, 18);
        seqTwoLbl.text =@"Balance";
        seqTwoLbl.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview: seqTwoLbl];
        [seqTwoLbl release];
        
        path=[[NSBundle mainBundle] pathForResource: @"displayBkg" ofType:@"png"];
        image = [[UIImage imageWithContentsOfFile: path] retain];
        headerView.image = image;
        [image release];
        [self.view addSubview: headerView];
        
        chartArea = [[TwoBarChartArea alloc] initWithFrameChart: CGRectZero chart: chartObj];
        chartArea.backgroundColor = [UIColor clearColor];
        [self.view addSubview: chartArea];
        yaxis = [[YAxisView alloc] initWithFrameChart: CGRectZero chart: chartObj axisWidthVal: 50];
        yaxis.backgroundColor = [UIColor clearColor];
        [self.view addSubview: yaxis];
        xaxis = [[XAxisView alloc] initWithFrameChart: CGRectZero chart: chartObj];
        xaxis.backgroundColor = [UIColor clearColor];
        [self.view addSubview: xaxis];
        
        CGRect frame = CGRectMake(0, 30, screenWidth, 290);
        [self layoutChart: frame];
    }
}

- (UILabel *) newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
    UIFont *font;
    if (bold){
        font = [UIFont boldSystemFontOfSize:fontSize];
    }
    else{
        font = [UIFont systemFontOfSize:fontSize];
    }
    
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    newLabel.backgroundColor = [UIColor clearColor];
    newLabel.opaque = YES;
    newLabel.textColor = primaryColor;
    newLabel.highlightedTextColor = selectedColor;
    newLabel.font = font;
    
    return newLabel;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
}

-(void) layoutChart:(CGRect) frame{
    
    imageView.frame = frame;
    int xAxisWidth = 50;
    int yAxisWidth = 50;
    int xPadding = 10;
    int yPadding = 20;
    
    float coordXMin = frame.origin.x+xPadding+yAxisWidth;
    float coordYMin = frame.origin.y+yPadding;
    float coordWidth = frame.size.width - 2*xPadding - yAxisWidth;
    float coordHeight = frame.size.height - 2*yPadding - xAxisWidth;
    chartObj.coordMaxX = coordWidth;
    chartObj.coordMaxY = coordHeight;
    [chartObj initialize];
    
    CGRect yAxisFrame = CGRectMake(coordXMin-yAxisWidth, coordYMin, yAxisWidth+coordWidth, coordHeight);
    CGRect xAxisFrame = CGRectMake(coordXMin, coordYMin+coordHeight, coordWidth, xAxisWidth);
    CGRect chartAreaFrame = CGRectMake(coordXMin, coordYMin, coordWidth, coordHeight);
    
    chartArea.frame = chartAreaFrame;
    yaxis.frame = yAxisFrame;
    xaxis.frame = xAxisFrame;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        CGRect origFrame = 	self.view.frame;
        CGRect frame = CGRectMake(origFrame.origin.x, origFrame.origin.y+20, origFrame.size.width, origFrame.size.height);
        self.view.frame = frame;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [headerView release];
    [chartObj release];
    [chartArea release];
    [yaxis release];
    [xaxis release];
    [imageView release];
    [super dealloc];
}

@end
