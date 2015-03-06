//
//  SettingViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-17.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "SettingInitViewController.h"

@class SettingViewController;

@protocol SettingViewControllerDelegate <NSObject>
- (void)SettingViewControllerDidBack:(SettingViewController *)controller;
@end

@interface SettingViewController : UITableViewController <SettingInitViewControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, weak) id <SettingViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UITableView *mainTableView;
@property (nonatomic,retain) IBOutlet UILabel *InitViewSeletcedDetailLabel;
@property (nonatomic,retain) IBOutlet UISwitch *torchIsON;
@property (nonatomic,retain) IBOutlet UISlider *torchBrightness;
@property (nonatomic, strong) NSMutableArray *studyNavigations;
@property (nonatomic, strong) NSMutableArray *lifeNavigations;
@property (nonatomic, strong) NSMutableArray *otherNavigations;

-(IBAction)buttonBack:(id)sender;
-(IBAction)contectUS:(id)sender;
-(IBAction)initWithDefaultNavigations:(id)sender;

@end
