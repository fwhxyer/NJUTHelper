//
//  SettingViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-17.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define studyNavigationsCount 0
#define lifeNavigationCount 1
#define otherNavigationCount 2

#import "SettingViewController.h"
#import "NHAppDelegate.h"
#import "Navigation.h"

@interface SettingViewController ()

@end

@implementation SettingViewController{
    NSArray *tmpInitView;
}

@synthesize InitViewSeletcedDetailLabel;
@synthesize delegate;
@synthesize mainTableView;
@synthesize torchIsON;
@synthesize torchBrightness;
@synthesize studyNavigations;
@synthesize lifeNavigations;
@synthesize otherNavigations;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GetSettingInitView"])
    {
        SettingInitViewController *settingInitViewController =
        segue.destinationViewController;
        settingInitViewController.delegate = self;
        settingInitViewController.InitViewName = InitViewSeletcedDetailLabel.text;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *rightSwipeRecognizer;
    rightSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                  action:@selector(back:)];
    rightSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    rightSwipeRecognizer.numberOfTouchesRequired=1;
    [mainTableView addGestureRecognizer:rightSwipeRecognizer];

    
    NHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    appDelegate.gotoInitView = [userDefaults integerForKey:kGotoInitView];
    appDelegate.torchIsON = [userDefaults boolForKey:kTorchIsON];
    appDelegate.torchBrightness = [userDefaults floatForKey:kTorchBrightness];
    tmpInitView = [NSArray arrayWithObjects:
                @"主页",
                @"导航栏",
                @"工具栏",
                @"最珍视的人",
                @"发光手电筒",
                @"繁忙课程表",
                @"美丽之镜",
                @"心系工大",
                @"我们的工大！",
                nil];
    InitViewSeletcedDetailLabel.text=[tmpInitView objectAtIndex:appDelegate.gotoInitView];
    [torchIsON setOn:appDelegate.torchIsON];
    [torchBrightness setValue:(appDelegate.torchBrightness-0.2)*1.25];
}

- (void)back:(UISwipeGestureRecognizer *)recognizer{
    [self buttonBack:nil];
}

-(IBAction)buttonBack:(id)sender{
    NHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    appDelegate.torchIsON=torchIsON.isOn;
    appDelegate.torchBrightness=(torchBrightness.value)/1.25+0.2;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:appDelegate.torchIsON forKey:kTorchIsON];
    [userDefaults setFloat:appDelegate.torchBrightness forKey:kTorchBrightness];
    
    [self.delegate SettingViewControllerDidBack:self];
}

-(IBAction)contectUS:(id)sender{
    if ([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mailComposer;
        NSArray *emailAddresses=[[NSArray alloc]initWithObjects:@"NJUTHelper@163.com", nil];
        mailComposer=[[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate=self;
        [mailComposer setToRecipients:emailAddresses];
        //
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
            [self presentViewController:mailComposer animated:YES completion:NULL];
        }
        else {
            [self presentModalViewController:mailComposer animated:YES];
        }
    }else{
        UIActionSheet *actionSheet;
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"不知道为什么不能发信息哦！" destructiveButtonTitle:nil otherButtonTitles:nil];
        actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
        [actionSheet showInView:self.view];
    }
}

-(NSString *)archivePath:(NSInteger) index{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    switch (index) {
        case 0:
            return [docDir stringByAppendingPathComponent:@"StudyNavigation"];
            break;
        case 1:
            return [docDir stringByAppendingPathComponent:@"LifeNavigation"];
            break;
        case 2:
            return [docDir stringByAppendingPathComponent:@"OtherNavigation"];
            break;
        default:
            return [docDir stringByAppendingPathComponent:@"UnknownNavigation"];
            break;
    }
}

-(void)archiveNavigations {
    [NSKeyedArchiver archiveRootObject:studyNavigations toFile:
     [self archivePath:studyNavigationsCount]];
    [NSKeyedArchiver archiveRootObject:lifeNavigations toFile:
     [self archivePath:lifeNavigationCount]];
    [NSKeyedArchiver archiveRootObject:otherNavigations toFile:
     [self archivePath:otherNavigationCount]];
}

-(IBAction)initWithDefaultNavigations:(id)sender{    
    NSString *tmpString=[[NSString alloc]initWithFormat:@"你真的要初始化导航栏吗？"];
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:tmpString  delegate:self cancelButtonTitle:@"假的" otherButtonTitles:@"真的", nil];
    [alterview show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"真的"]) {
        
        
        studyNavigations=[[NSMutableArray alloc]initWithObjects:nil];
        lifeNavigations=[[NSMutableArray alloc]initWithObjects:nil];
        otherNavigations=[[NSMutableArray alloc]initWithObjects:nil];
        
        Navigation *tmp=[Navigation alloc];
        tmp.name=@"南京工大主页";
        tmp.URL=[[NSURL alloc]initWithString:@"www.njut.edu.cn"];
        [studyNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"教务处";
        tmp.URL=[[NSURL alloc]initWithString:@"jwc.njut.edu.cn"];
        [studyNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"教务管理系统";
        tmp.URL=[[NSURL alloc]initWithString:@"202.119.248.199"];
        [studyNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"图书馆";
        tmp.URL=[[NSURL alloc]initWithString:@"202.119.248.243:8080/reader/login.php"];
        [studyNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"图书馆掌上书目检索";
        tmp.URL=[[NSURL alloc]initWithString:@"lib.njutmars.com"];
        [studyNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"体育部";
        tmp.URL=[[NSURL alloc]initWithString:@"tyb.njut.edu.cn"];
        [lifeNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"阳光长跑";
        tmp.URL=[[NSURL alloc]initWithString:@"ygcp.njut.edu.cn/Index.aspx"];
        [lifeNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"南工大蹭饭网";
        tmp.URL=[[NSURL alloc]initWithString:@"www.cengf.com"];
        [lifeNavigations addObject:tmp];
        
        tmp=[Navigation alloc];
        tmp.name=@"南工大BBS玄武雅阁";
        tmp.URL=[[NSURL alloc]initWithString:@"bbs.njut.edu.cn/forum.php"];
        [lifeNavigations addObject:tmp];
        

        [self archiveNavigations];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
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
#pragma mark - contectUSDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark - GamePickerViewControllerDelegate

- (void)settingInitViewController:(SettingInitViewController *)controller didSelectInitView:(NSString *)initView index:(NSInteger)initIndex
{
    InitViewSeletcedDetailLabel.text = initView;
    NHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.gotoInitView = initIndex;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:appDelegate.gotoInitView forKey:kGotoInitView];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
