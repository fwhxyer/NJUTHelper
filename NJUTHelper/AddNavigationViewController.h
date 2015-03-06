//
//  AddNavigationViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-18.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeNavigationViewController.h"
#import "Navigation.h"

@class AddNavigationViewController;

@protocol AddNavigationViewControllerDelegate <NSObject>
- (void)AddNavigationViewControllerDidCancel:
(AddNavigationViewController *)controller;
- (void)AddNavigationViewController:
(AddNavigationViewController *)controller didAddNavigation:(Navigation *)navigation withType:(NSInteger) type;
//- (void)AddNavigationViewControllerDidRefresh:(AddNavigationViewController *)controller;
@end

@interface AddNavigationViewController : UITableViewController <TypeNavigationViewControllerDelegate>

//@property (strong, nonatomic) IBOutlet UITableViewCell *refreshDefaultCell;
@property (nonatomic, weak) id <AddNavigationViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *URLTextField;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
//- (IBAction)refresh:(id)sender;

@end
