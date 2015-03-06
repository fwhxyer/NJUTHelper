//
//  TypeNavigationViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-18.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TypeNavigationViewController;

@protocol TypeNavigationViewControllerDelegate <NSObject>
- (void)typeNavigationViewController:
(TypeNavigationViewController *)controller
                   didSelectType:(NSString *)theType;
@end  

@interface TypeNavigationViewController : UITableViewController

@property (nonatomic, weak) id <TypeNavigationViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *type;
@property (nonatomic,retain) IBOutlet UITableViewCell *study;
@property (nonatomic,retain) IBOutlet UITableViewCell *life;
@property (nonatomic,retain) IBOutlet UITableViewCell *other;

@end
