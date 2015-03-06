//
//  LighterViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-15.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "LighterViewController.h"
#import "NHAppDelegate.h"

@implementation LighterViewController

@synthesize delegate;
@synthesize lighterImage;
@synthesize lighter;
@synthesize mainView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

//-------------------------------------------------------
- (void)toggleFlashlight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //if (device.torchMode == AVCaptureTorchModeOff)
    if (lighter.on){
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    } else {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}
- (IBAction)lighterChange:(id)sender{
    if ([sender isOn]) {
        lighterImage.image = [UIImage imageNamed:@"Light.png"];
    } else {
        lighterImage.image = [UIImage imageNamed:@"Dark.png"];
    }
    [self toggleFlashlight];
}

//-------------------------------------------------------

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lighterImage.userInteractionEnabled=YES;
    UISwipeGestureRecognizer *rightSwipeRecognizer;
    rightSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                  action:@selector(back:)];
    rightSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    rightSwipeRecognizer.numberOfTouchesRequired=1;
    [lighterImage addGestureRecognizer:rightSwipeRecognizer];
    
    UISwipeGestureRecognizer *upSwipeRecognizer;
    upSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                  action:@selector(back:)];
    upSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
    upSwipeRecognizer.numberOfTouchesRequired=1;
    [lighterImage addGestureRecognizer:upSwipeRecognizer];
    
    mainView.backgroundColor=[UIColor blackColor];
    lighter.alpha=0.1;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    lighterImage.alpha = appDelegate.torchBrightness;
    if ([device hasTorch] == YES && appDelegate.torchIsON == YES)
    {
        lighter.hidden=NO;
        [self toggleFlashlight];
    }else if ([device hasTorch] == YES && appDelegate.torchIsON == NO){
        lighter.hidden=NO;
        [lighter setOn:NO];
        lighterImage.image = [UIImage imageNamed:@"Dark.png"];
    }else{
        lighter.hidden=YES;
        lighterImage.image = [UIImage imageNamed:@"Dark.png"];
        return;
    }
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    UITapGestureRecognizer *leftSwipeRecognizer;
    leftSwipeRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                 action:@selector(changeImage:)];
    leftSwipeRecognizer.numberOfTouchesRequired=1;
    leftSwipeRecognizer.numberOfTapsRequired=1;
    [lighterImage addGestureRecognizer:leftSwipeRecognizer];
    
    
}

- (void)changeImage:(UITapGestureRecognizer *)recognizer{
    //[lighter sendActionsForControlEvents:UIControlEventTouchUpInside];
    if (lighter.on) {
        lighter.on=NO;
    }else {
        lighter.on=YES;
    }
    [self lighterChange:lighter];
}

- (void)back:(UISwipeGestureRecognizer *)recognizer{
    [self.delegate LighterViewControllerDidBack:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
