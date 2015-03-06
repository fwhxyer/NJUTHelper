//
//  Mirror.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-16.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#import <UIKit/UIKit.h>

@interface Mirror : UIView <UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImagePickerController* imagePicker;

@end
