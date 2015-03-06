//
//  NavigationViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define sectionCount 3

#define studyNavigationsCount 0
#define lifeNavigationCount 1
#define otherNavigationCount 2

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Navigation.h"
#import "WebViewController.h"
#import "AddNavigationViewController.h"

@class NavigationViewController;

@protocol NavigationViewControllerDelegate <NSObject>
- (void)NavigationViewControllerDidBack:(NavigationViewController *)controller;
@end

@interface NavigationViewController : UITableViewController <WebViewControllerDelegate,AddNavigationViewControllerDelegate,ADBannerViewDelegate>

@property (nonatomic, weak) id <NavigationViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *studyNavigations;
@property (nonatomic, strong) NSMutableArray *lifeNavigations;
@property (nonatomic, strong) NSMutableArray *otherNavigations;
@property (nonatomic, strong) NSURL *URLToWebView;
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet ADBannerView *adView;

-(IBAction)back:(id)sender;
-(void)archiveNavigations;

@end
