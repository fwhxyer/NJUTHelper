//
//  AddNavigationViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-18.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "AddNavigationViewController.h"

@interface AddNavigationViewController ()

@end

@implementation AddNavigationViewController
//@synthesize refreshDefaultCell;
@synthesize delegate;
@synthesize nameTextField;
@synthesize URLTextField;
@synthesize typeLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickType"])
    {
        TypeNavigationViewController *typeNavigationViewController =
        segue.destinationViewController;
        typeNavigationViewController.delegate = self;
        typeNavigationViewController.type = typeLabel.text;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)cancel:(id)sender
{
    [self.delegate AddNavigationViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    Navigation *navigation = [[Navigation alloc] init];
    navigation.name = self.nameTextField.text;
    NSString *tmp=[[NSString alloc]initWithString:self.URLTextField.text];
    if ([[tmp substringToIndex:7] isEqualToString:@"http://"])
        navigation.URL = [NSURL URLWithString:[tmp substringFromIndex:7]];
    else
        navigation.URL = [NSURL URLWithString:tmp];
    NSInteger type=2;
    if ([typeLabel.text isEqualToString:@"学习相关"])
        type=0;
    else if ([typeLabel.text isEqualToString:@"生活相关"])
        type=1;
    
    if ([[navigation.URL absoluteString]isEqualToString:@""])
        [self.delegate AddNavigationViewControllerDidCancel:self];
    else
        [self.delegate AddNavigationViewController:self didAddNavigation:navigation withType:type];
}

/*
- (IBAction)refresh:(id)sender{
    [self.delegate AddNavigationViewControllerDidRefresh:self];
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
#pragma mark - typeNavigationViewControllerDelegate

- (void)typeNavigationViewController:(TypeNavigationViewController *)controller didSelectType:(NSString *)theType
{
    typeLabel.text = theType;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
