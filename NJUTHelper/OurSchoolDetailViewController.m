//
//  OurSchoolDetailViewController.m
//  校园手机伴侣
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "OurSchoolDetailViewController.h"

@interface OurSchoolDetailViewController ()

@end

@implementation OurSchoolDetailViewController
@synthesize mainView;
@synthesize navigationItem;
@synthesize photoView;
@synthesize textView;
@synthesize tmpDetail;
@synthesize tmpPhoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainView.backgroundColor = [UIColor underPageBackgroundColor];
    
    textView.text = tmpDetail;
    photoView.image = tmpPhoto;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
