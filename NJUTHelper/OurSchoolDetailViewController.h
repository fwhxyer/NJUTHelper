//
//  OurSchoolDetailViewController.h
//  校园手机伴侣
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OurSchoolDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,retain) NSString *tmpDetail;
@property (nonatomic,retain) UIImage *tmpPhoto;

@end
