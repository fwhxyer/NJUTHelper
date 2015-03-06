//
//  NavigationViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#import "NavigationViewController.h"
#import "NHAppDelegate.h"

@interface NavigationViewController (){
    bool bannerIsVisible;
}

@end

@implementation NavigationViewController

@synthesize delegate;
@synthesize studyNavigations;
@synthesize lifeNavigations;
@synthesize otherNavigations;
@synthesize URLToWebView;
@synthesize mainTableView;
@synthesize leftButton;
@synthesize adView;

- (NSIndexPath *)tableView:(UITableView *)tableView
willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case studyNavigationsCount:{
            Navigation *tmp=[studyNavigations objectAtIndex:indexPath.row];
            URLToWebView=tmp.URL;
            break;
        }
        case lifeNavigationCount:{
            Navigation *tmp=[lifeNavigations objectAtIndex:indexPath.row];
            URLToWebView=tmp.URL;
            break;
        }

        case otherNavigationCount:{
            Navigation *tmp=[otherNavigations objectAtIndex:indexPath.row];
            URLToWebView=tmp.URL;
            break;
        }
        default:
            break;
    }
    return indexPath;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GetWebView"])
    {
        WebViewController *webViewController =
        segue.destinationViewController;
        webViewController.delegate = self;
        webViewController.urlFromNavigation = URLToWebView;
    }
    if ([segue.identifier isEqualToString:@"GetAddNavigation"])
    {
        UINavigationController *navigationController =
        segue.destinationViewController;
        AddNavigationViewController
        *addNavigationViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
        addNavigationViewController.delegate = self;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case studyNavigationsCount:
            if (editingStyle == UITableViewCellEditingStyleDelete)
            {
                [self.studyNavigations removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        case lifeNavigationCount:
            if (editingStyle == UITableViewCellEditingStyleDelete)
            {
                [self.lifeNavigations removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
        case otherNavigationCount:
            if (editingStyle == UITableViewCellEditingStyleDelete)
            {
                [self.otherNavigations removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            break;
            
        default:
            break;
    }
}

-(IBAction)back:(id)sender{
    [self.delegate NavigationViewControllerDidBack:self];
}

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
    bannerIsVisible=YES;
    adView.delegate=self;
 
    self.studyNavigations = [NSKeyedUnarchiver unarchiveObjectWithFile:
                             [self archivePath:studyNavigationsCount]];
    self.lifeNavigations = [NSKeyedUnarchiver unarchiveObjectWithFile:
                            [self archivePath:lifeNavigationCount]];
    self.otherNavigations = [NSKeyedUnarchiver unarchiveObjectWithFile:
                             [self archivePath:otherNavigationCount]];
    
    if (self.studyNavigations == nil || self.lifeNavigations==nil || self.otherNavigations==nil ) {
        [self initWithDefaultNavigations];
    }
    
    [super viewDidLoad];
    mainTableView.backgroundColor=[UIColor underPageBackgroundColor];
    
    mainTableView.userInteractionEnabled=YES;
    UISwipeGestureRecognizer *leftSwipeRecognizer;
    leftSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                 action:@selector(foundLeftSwipe:)];
    leftSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionRight;
    leftSwipeRecognizer.numberOfTouchesRequired=1;
    [mainTableView addGestureRecognizer:leftSwipeRecognizer];
    
    /*UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(95,230,210,77)];
    imageView.image = [UIImage imageNamed:@"箭头3.png"];
    [mainTableView addSubview:imageView];
    [mainTableView sendSubviewToBack:imageView];
     */
}

-(void)viewDidAppear:(BOOL)animated{
    NHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    switch (appDelegate.gotoInitViewTmp) {
        case 1:
            appDelegate.gotoInitViewTmp=0;
            break;
        default:
            break;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self view] endEditing:animated];
    [self archiveNavigations];
}

- (void)foundLeftSwipe:(UISwipeGestureRecognizer *)recognizer{
    [self.delegate NavigationViewControllerDidBack:self];
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

-(void)initWithDefaultNavigations{
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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case studyNavigationsCount:
            return [studyNavigations count];
        case lifeNavigationCount:
            return [lifeNavigations count];
        case otherNavigationCount:
            return [otherNavigations count];
        default:
            return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case studyNavigationsCount:
            return @"学习相关";
        case lifeNavigationCount:
            return @"生活相关";
        case otherNavigationCount:
            return @"其他";
        default:
            return @"未知分组";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NavigationCell"];
    
    if (cell==nil){
        cell=[[UITableViewCell alloc]initWithFrame:CGRectZero];
    }
    
    switch (indexPath.section) {
        case studyNavigationsCount:{
            Navigation *tmp = [self.studyNavigations objectAtIndex:indexPath.row];
            cell.textLabel.text = tmp.name;
            cell.detailTextLabel.text = [tmp.URL absoluteString];
            break;
        }
        case lifeNavigationCount:{
            Navigation *tmp = [self.lifeNavigations objectAtIndex:indexPath.row];
            cell.textLabel.text = tmp.name;
            cell.detailTextLabel.text = [tmp.URL absoluteString];
            break;
        }
        case otherNavigationCount:{
            Navigation *tmp = [self.otherNavigations objectAtIndex:indexPath.row];
            cell.textLabel.text = tmp.name;
            cell.detailTextLabel.text = [tmp.URL absoluteString];
            break;
        }
            
        default:{
            cell.textLabel.text = @"UnKnown";
            cell.detailTextLabel.text = @"UnKnown";
            break;
        }
    }
    
    return cell;
  
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (bannerIsVisible)
    {
        adView.hidden = YES;
        bannerIsVisible = NO;
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

#pragma mark - WebViewControllerDelegate

- (void)WebViewControllerDidBack:(WebViewController *)controller
{
    UIApplication* app = [ UIApplication  sharedApplication ];
    app.networkActivityIndicatorVisible = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - AddNavigationViewControllerDelegate

- (void)AddNavigationViewControllerDidCancel:(AddNavigationViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)AddNavigationViewController:(AddNavigationViewController *)controller didAddNavigation:(Navigation *)navigation withType:(NSInteger)type{
    switch (type) {
        case 0:{
            [self.studyNavigations addObject:navigation];
            NSIndexPath *indexPath =
            [NSIndexPath indexPathForRow:[self.studyNavigations count] - 1
                               inSection:0];
            [self.mainTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case 1:{
            [self.lifeNavigations addObject:navigation];
            NSIndexPath *indexPath =
            [NSIndexPath indexPathForRow:[self.lifeNavigations count] - 1
                               inSection:1];
            [self.mainTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case 2:{
            [self.otherNavigations addObject:navigation];
            NSIndexPath *indexPath =
            [NSIndexPath indexPathForRow:[self.otherNavigations count] - 1
                               inSection:2];
            [self.mainTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - AddNavigationViewControllerDelegate

- (void)AddNavigationViewControllerDidRefresh:(AddNavigationViewController *)controller
{
    [self initWithDefaultNavigations];
    [mainTableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}*/

@end
