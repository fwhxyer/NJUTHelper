//
//  NHViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "NHViewController.h"
#import "NHAppDelegate.h"

@interface NHViewController ()

@end

@implementation NHViewController

@synthesize firstImageView;
@synthesize leftButton;
@synthesize rightButton;
@synthesize middleButton;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GetNavigation"])
    {
        UINavigationController *navigationController =
        segue.destinationViewController;
        NavigationViewController
        *navigationViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
        navigationViewController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"GetToolBar"])
    {
        UINavigationController *navigationController =
        segue.destinationViewController;
        ToolBarViewController
        *toolBarViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
        toolBarViewController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"GetSetting"])
    {
        UINavigationController *navigationController =
        segue.destinationViewController;
        SettingViewController *settingViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
        settingViewController.delegate = self;
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    firstImageView.userInteractionEnabled=YES;
    UISwipeGestureRecognizer *rightSwipeRecognizer;
    rightSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                  action:@selector(foundRightSwipe:)];
    rightSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    rightSwipeRecognizer.numberOfTouchesRequired=1;
    [firstImageView addGestureRecognizer:rightSwipeRecognizer];
    
    UISwipeGestureRecognizer *leftSwipeRecognizer;
    leftSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                 action:@selector(foundLeftSwipe:)];
    leftSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;
    leftSwipeRecognizer.numberOfTouchesRequired=1;
    [firstImageView addGestureRecognizer:leftSwipeRecognizer];
    
    UISwipeGestureRecognizer *upSwipeRecognizer;
    upSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                 action:@selector(foundUpSwipe:)];
    upSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionUp;
    upSwipeRecognizer.numberOfTouchesRequired=1;
    [firstImageView addGestureRecognizer:upSwipeRecognizer];
}

-(void)viewDidAppear:(BOOL)animated{
    NHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    switch (appDelegate.gotoInitViewTmp) {
        case 1:
            [rightButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            appDelegate.gotoInitViewTmp=0;
            break;
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
            [leftButton sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)foundRightSwipe:(UISwipeGestureRecognizer *)recognizer{
    //firstImageView.image=[UIImage imageNamed:@"Default.png"];
    [leftButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)foundLeftSwipe:(UISwipeGestureRecognizer *)recognizer{
    //firstImageView.image=[UIImage imageNamed:@"background3.jpg"];
    [rightButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)foundUpSwipe:(UISwipeGestureRecognizer *)recognizer{
    //firstImageView.image=[UIImage imageNamed:@"background3.jpg"];
    [middleButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - NavigationViewControllerDelegate

-(void) NavigationViewControllerDidBack:(NavigationViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ToolBarViewControllerDelegate

-(void) ToolBarViewControllerDidBack:(ToolBarViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SettingViewControllerDelegate

-(void) SettingViewControllerDidBack:(SettingViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
