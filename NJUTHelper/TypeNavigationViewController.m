//
//  TypeNavigationViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-18.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "TypeNavigationViewController.h"

@interface TypeNavigationViewController ()

@end

@implementation TypeNavigationViewController{
    NSUInteger selectedIndex;
}
@synthesize delegate;
@synthesize type;
@synthesize study;
@synthesize life;
@synthesize other;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([type isEqualToString:@"学习相关"]) {
        selectedIndex = 0;
        study.accessoryType = UITableViewCellAccessoryCheckmark;
    }else if ([type isEqualToString:@"生活相关"]) {
        selectedIndex = 1;
        life.accessoryType = UITableViewCellAccessoryCheckmark;
    }else if ([type isEqualToString:@"其他"]) {
        selectedIndex = 2;
        other.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    study.accessoryType = UITableViewCellAccessoryNone;
    life.accessoryType = UITableViewCellAccessoryNone;
    other.accessoryType = UITableViewCellAccessoryNone;
    selectedIndex = indexPath.section;
    NSString *theType = [NSString alloc];
    switch (selectedIndex) {
        case 0:
            study.accessoryType = UITableViewCellAccessoryCheckmark;
            theType = study.textLabel.text;
            break;
        case 1:
            life.accessoryType = UITableViewCellAccessoryCheckmark;
            theType = life.textLabel.text;
            break;
        case 2:
            other.accessoryType = UITableViewCellAccessoryCheckmark;
            theType = other.textLabel.text;
            break;
        default:
            break;
    }
    [self.delegate typeNavigationViewController:self didSelectType:theType];
}

@end
