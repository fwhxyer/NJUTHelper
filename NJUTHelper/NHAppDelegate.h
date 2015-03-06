//
//  NHAppDelegate.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define kGotoInitView @"KEYGOTOINITVIEW"
#define kTorchIsON @"KEYTORCHISON"
#define kTorchBrightness @"KEYTORCHBRIGHTNESS"

#import <UIKit/UIKit.h>
#import "sys/utsname.h"

@interface NHAppDelegate : UIResponder <UIApplicationDelegate>{
    NSInteger gotoInitView;
    NSInteger gotoInitViewTmp;
    BOOL torchIsON;
    double torchBrightness;
}

@property (strong, nonatomic) UIWindow *window;
@property (readwrite, nonatomic) NSInteger gotoInitView;
@property (readwrite, nonatomic) NSInteger gotoInitViewTmp;
@property (readwrite, nonatomic) BOOL torchIsON;
@property (readwrite, nonatomic) double torchBrightness;

@end
