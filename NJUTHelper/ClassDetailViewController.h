//
//  ClassDetailViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ClassDetailViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,retain) IBOutlet UIView *mainView;
@property (nonatomic,retain) IBOutlet UITextField *textField1;
@property (nonatomic,retain) IBOutlet UITextField *textField2;
@property (nonatomic,retain) IBOutlet UITextField *textField3;
@property (nonatomic,retain) IBOutlet UITextField *textField4;
@property (nonatomic,retain) IBOutlet UITextField *textField5;
@property (nonatomic,retain) IBOutlet UITextField *textField6;
@property (nonatomic,retain) IBOutlet UITextField *textField7;
@property (nonatomic,retain) IBOutlet UITextField *textField8;
@property (nonatomic,retain) IBOutlet UITextField *textField9;
@property (nonatomic,retain) IBOutlet UITextField *textField10;
@property (nonatomic,retain) IBOutlet UIImageView *coursePhoto;
@property (nonatomic,retain) IBOutlet UILabel *weekdayLabel;
@property (nonatomic,readwrite) NSInteger indexInCourses;
@property (nonatomic, strong) NSMutableArray *courses;

-(IBAction)hideKeyboard:(id)sender;

@end
