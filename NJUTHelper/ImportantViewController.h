//
//  ImportantViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ImportantViewController : UIViewController <UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate,MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,retain) IBOutlet UIView *mainView;
@property (nonatomic,retain) IBOutlet UITextField *itsName;
@property (nonatomic,retain) IBOutlet UITextField *itsTEL;
@property (nonatomic,retain) IBOutlet UITextField *itsQQ;
@property (nonatomic,retain) IBOutlet UIImageView *itsPhoto;
@property (nonatomic,retain) UIImage *chooseImage;
@property (retain, nonatomic) IBOutlet UIImageView *photoFrame;

-(IBAction)hideKeyboard:(id)sender;
-(IBAction)phoneIt:(id)sender;
-(IBAction)messageAll:(id)sender;
- (IBAction)checkPhotoFrame:(id)sender;

@end
