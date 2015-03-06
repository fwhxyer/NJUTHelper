//
//  ClassViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-19.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define kNotes @"KEYNOTES"

#import "ClassViewController.h"

@interface ClassViewController (){
    NSArray *weekdays;
    NSInteger indexInSelected;
    NSInteger noteSelected;
}

@end

@implementation ClassViewController
@synthesize mainView;
@synthesize notes;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initWithDefaultNotes{
    notes=[[NSMutableArray alloc]initWithObjects:nil];
    
    
    Note *note;
    
    note = [Note alloc];
    note.title = [[NSString alloc]initWithFormat:@"备忘"];
    
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"HH:mm:ss    MM月dd日    yyyy年"];
    note.date = [datef stringFromDate:[NSDate date]];
    
    note.detail = [[NSString alloc]initWithFormat:@"%@时，\n您开始使用工具【繁忙课程表】，请接收来自开发团队最诚挚的欢迎与感谢！",note.date];
    
    [notes addObject:note];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainView.backgroundColor = [UIColor underPageBackgroundColor];
    
    weekdays =[[NSArray alloc]initWithObjects:
               @"星期一",
               @"星期二",
               @"星期三",
               @"星期四",
               @"星期五",
               @"星期六",
               @"星期日",
               nil];
    
    self.notes = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    if (self.notes == nil) {
        [self initWithDefaultNotes];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self view] endEditing:animated];
    [self archiveNavigations];
}

-(NSString *)archivePath{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:kNotes];
}

-(void)archiveNavigations {
    [NSKeyedArchiver archiveRootObject:notes toFile:[self archivePath]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"GetClassDetail"])
    {
        ClassDetailViewController *classDetailViewController=segue.destinationViewController;
        classDetailViewController.indexInCourses=indexInSelected;
    }
    if([segue.identifier isEqualToString:@"GetAddNote"])
    {
        AddNoteViewController *addNoteViewController = segue.destinationViewController;
        addNoteViewController.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"GetNoteDetail"]) {
        NoteDetailViewController *noteDetailViewControll = segue.destinationViewController;
        noteDetailViewControll.delegate = self;
        noteDetailViewControll.note = [notes objectAtIndex:noteSelected];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [weekdays count];
        case 1:
            return [notes count];
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"课程表";
        case 1:
            return @"备忘";
        default:
            return @"未知分组";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            NSString *CellIdentifier = @"WeekDayCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.textLabel.text=[weekdays objectAtIndex:indexPath.row];
            return cell;
        }
        case 1:{
            NSString *CellIdentifier = @"NoteCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            Note *note=[notes objectAtIndex:indexPath.row];
            cell.textLabel.text=note.title;
            cell.detailTextLabel.text=note.date;
            return cell;
        }
        default:
            return nil;
    }    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            break;
        case 1:
            if (editingStyle == UITableViewCellEditingStyleDelete)
            {
                [self.notes removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        default:
            break;
    }
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            indexInSelected=indexPath.row;
            break;
        case 1:
            noteSelected = indexPath.row;
            break;
        default:
            break;
    }
    return indexPath;
}

#pragma mark - AddNoteViewControllerDelegate

-(void)addNoteViewControllerDidCancel:(AddNoteViewController *)addNoteViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addNoteViewController:(AddNoteViewController *)addNoteViewController didAddNote:(Note *)note{
    [notes addObject:note];
    NSIndexPath *indexPath =
    [NSIndexPath indexPathForRow:[self.notes count] - 1
                       inSection:1];
    [self.mainView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NoteDetailViewControllerDelegate

-(void)noteDetailViewController:(NoteDetailViewController *)noteDetailViewController didBackWithNote:(Note *)theNote{
    [notes replaceObjectAtIndex:noteSelected withObject:theNote];
}

@end
