//
//  LighterViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-15.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class LighterViewController;

@protocol LighterViewControllerDelegate <NSObject>
- (void)LighterViewControllerDidBack:(LighterViewController *)controller;
@end

@interface LighterViewController : UIViewController
{
    IBOutlet UISwitch *lighter;
    IBOutlet UIImageView *lighterImage;
}
-(IBAction)lighterChange:(id)sender;

@property (nonatomic,weak) id <LighterViewControllerDelegate> delegate;
@property (retain,nonatomic) UISwitch *lighter;
@property (retain,nonatomic) UIImageView *lighterImage;
@property (retain,nonatomic) IBOutlet UIView *mainView;

@end