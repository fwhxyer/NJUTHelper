//
//  NHViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationViewController.h"
#import "ToolBarViewController.h"
#import "SettingViewController.h"

@interface NHViewController : UIViewController
    <NavigationViewControllerDelegate,ToolBarViewControllerDelegate,SettingViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *firstImageView;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *middleButton;

@end
