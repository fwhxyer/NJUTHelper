//
//  SettingInitViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-19.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingInitViewController;

@protocol SettingInitViewControllerDelegate <NSObject>
- (void)settingInitViewController:
(SettingInitViewController *)controller
                    didSelectInitView:(NSString *)initView index:(NSInteger) initIndex;
@end

@interface SettingInitViewController : UITableViewController {
    NSArray * initView;
    NSInteger selectedIndex;
}

@property (nonatomic,weak) id <SettingInitViewControllerDelegate> delegate;
@property (nonatomic,strong) NSString *InitViewName;

@end
