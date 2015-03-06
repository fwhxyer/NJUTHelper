//
//  ToolBarViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-15.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Mirror.h"
#import "LighterViewController.h"
#import "LocationViewController.h"
#import "OurSchoolViewController.h"

@class ToolBarViewController;

@protocol ToolBarViewControllerDelegate <NSObject>
-(void) ToolBarViewControllerDidBack:(ToolBarViewController *)controller;
@end

@interface ToolBarViewController : UIViewController <LighterViewControllerDelegate,UIImagePickerControllerDelegate,LocationViewControllerDelegate,OurSchoolViewControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ADBannerViewDelegate>{
    UIImagePickerController* imagePicker;
}

@property (retain, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) id <ToolBarViewControllerDelegate> delegate;
@property (nonatomic,strong) IBOutlet UIView *mainCollectionView;
@property (nonatomic) UIImagePickerControllerCameraDevice front;
@property (nonatomic,retain) IBOutlet UIButton *toolBar0;
@property (nonatomic,retain) IBOutlet UIButton *toolBar1;
@property (nonatomic,retain) IBOutlet UIButton *toolBar2;
//@property (nonatomic,retain) IBOutlet UIButton *toolBar3;
@property (nonatomic,retain) IBOutlet UIButton *toolBar4;
@property (nonatomic,retain) IBOutlet UIButton *toolBar5;
@property (nonatomic,retain) IBOutlet UIButton *toolBar6;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UIButton *toolBar7;
@property (weak, nonatomic) IBOutlet UIButton *toolBar8;
@property (weak, nonatomic) IBOutlet ADBannerView *adView;

-(IBAction)initCamera:(id)sender;
-(IBAction)back:(id)sender;
//-(IBAction)contectUS:(id)sender;
- (IBAction)changeBackground:(id)sender;
- (IBAction)hideButtons:(UIBarButtonItem *)sender;

@end