//
//  OurSchoolViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-19.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OurSchoolViewController;

@protocol OurSchoolViewControllerDelegate <NSObject>
-(void)ourSchoolViewControllerDidBack:(OurSchoolViewController *)controller;
@end

@interface OurSchoolViewController : UITableViewController

@property (nonatomic,weak) id <OurSchoolViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UITableView *mainView;

-(IBAction)back:(id)sender;

@end
