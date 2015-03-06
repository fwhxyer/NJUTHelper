//
//  ToolBarViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-15.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "ToolBarViewController.h"
#import "NHAppDelegate.h"

@interface ToolBarViewController (){
    Boolean isHideButtons;
    bool bannerIsVisible;
}

@end

@implementation ToolBarViewController

@synthesize delegate;
@synthesize front;
@synthesize mainCollectionView;
@synthesize toolBar0;
@synthesize toolBar1;
@synthesize toolBar2;
//@synthesize toolBar3;
@synthesize toolBar4;
@synthesize toolBar5;
@synthesize toolBar6;
@synthesize backgroundImage;
@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize label5;
@synthesize label6;
@synthesize toolBar7;
@synthesize toolBar8;
@synthesize adView;

-(IBAction) initCamera :(id)sender
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        front = UIImagePickerControllerCameraDeviceFront;
        if (front)
            imagePicker.cameraDevice = front;
        imagePicker.showsCameraControls = NO;
        CGRect frame =[[UIScreen mainScreen] bounds];
        Mirror* mirror = [[Mirror alloc] initWithFrame:frame];
        [imagePicker.cameraOverlayView addSubview:mirror];
        mirror.imagePicker=imagePicker;
        mirror.imagePicker.delegate=self;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self presentViewController:imagePicker animated:NO completion:NULL];
    }
    else {
        [self presentModalViewController:imagePicker animated:NO];
    }
    /*
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self presentModalViewController:imagePicker animated:NO];/Users/fwhxyer/Desktop/NJUTHelper/NJUTHelper/background.png
/Users/fwhxyer/Desktop/NJUTHelper/NJUTHelper/default.png
     */
}
/*已经移动到SettingView
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
 #pragma mark - contectUSDelegate
 
 -(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
 if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
 [self dismissViewControllerAnimated:YES completion:NULL];
 }
 else {
 [self dismissModalViewControllerAnimated:YES];
 }
 }

*/
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
    
    bannerIsVisible=YES;
    adView.delegate=self;
    
    imagePicker = [[UIImagePickerController alloc] init];
    
    mainCollectionView.backgroundColor = [UIColor underPageBackgroundColor];
    
    //backgroundImage.image=[UIImage imageNamed:@"toolBarBackground.png"];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"ToolBarBackground.png"];
    UIImage *img=[UIImage imageWithContentsOfFile:path];
    if (!img) {
        img=nil;
    }
    [backgroundImage setImage:img];

    
    mainCollectionView.userInteractionEnabled=YES;
    UISwipeGestureRecognizer *leftSwipeRecognizer;
    leftSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                 action:@selector(foundRightSwipe:)];
    leftSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionLeft;
    leftSwipeRecognizer.numberOfTouchesRequired=1;
    [mainCollectionView addGestureRecognizer:leftSwipeRecognizer];
    /*
    backgroundImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapRecognizer;
    tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBackground:)];
    tapRecognizer.numberOfTapsRequired=1;
    tapRecognizer.numberOfTouchesRequired=1;
    [backgroundImage addGestureRecognizer:tapRecognizer];
    
    
    [mainCollectionView registerClass:[ToolBarCell class]
           forCellWithReuseIdentifier:@"ToolBarCell"];
    [self.collectionView reloadData];    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:
                              [UIImage imageNamed:@"backgroundHint.png"]];
    imageView.center = self.collectionView.center;
    [self.collectionView addSubview:imageView];    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100,250,253,137)];
    imageView.image = [UIImage imageNamed:@"箭头4.png"];
    [mainCollectionView addSubview:imageView];
    [mainCollectionView sendSubviewToBack:imageView];
    UIImageView  *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10,190,93,170)];
    imageView1.image = [UIImage imageNamed:@"箭头2.png"];
    [mainCollectionView addSubview:imageView1];
    [mainCollectionView sendSubviewToBack:imageView1];
     */
}

-(void)viewDidAppear:(BOOL)animated{
    NHAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    switch (appDelegate.gotoInitViewTmp) {
        case 3:
            [toolBar5 sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            [toolBar0 sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 5:
            [toolBar4 sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 6:
            [toolBar1 sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 7:
            [toolBar2 sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        case 8:
            [toolBar6 sendActionsForControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    appDelegate.gotoInitViewTmp=0;
}

-(void)foundRightSwipe:(UISwipeGestureRecognizer *)recognizer{
    [self.delegate ToolBarViewControllerDidBack:self];
}
/*
-(void)changeBackground:(UITapGestureRecognizer *)recognizer{    
    UIActionSheet *actionSheet;
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"更改背景" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"还原默认背景" otherButtonTitles:@"拍照", @"从相册选择", nil];
    actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}
*/
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"还原默认背景"]){
        [backgroundImage setImage:nil];
        
        NSData *data;
        NSString *filepath;
        data = [[NSData alloc]init];
        filepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ToolBarBackground.png"];
        [data writeToFile:filepath atomically:YES];
        
    }else if ([buttonTitle isEqualToString:@"拍照"]){
        [self initBackgroundCamera:1];
    }else if ([buttonTitle isEqualToString:@"从相册选择"]){
        [self initBackgroundCamera:0];
    }
}

-(void)initBackgroundCamera:(int)section{
    UIImagePickerController *uiImagePickerController = [[UIImagePickerController alloc] init];
    
    if (section &&
        [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
        uiImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        uiImagePickerController.showsCameraControls = YES;
    }else{
        uiImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [uiImagePickerController setDelegate:self];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self presentViewController:uiImagePickerController animated:NO completion:NULL];
    }
    else {
        [self presentModalViewController:uiImagePickerController animated:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GetTorch"])
    {
        LighterViewController *lighterViewController =
        segue.destinationViewController;
        lighterViewController.delegate = self;
    }
    if([segue.identifier isEqualToString:@"GetLocation"])
    {
        LocationViewController *locationViewController =
        segue.destinationViewController;
        locationViewController.delegate = self;
    }
    if([segue.identifier isEqualToString:@"GetOurSchool"])
    {
        UINavigationController *navigationController =
        segue.destinationViewController;
        OurSchoolViewController *ourSchoolViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
        ourSchoolViewController.delegate = self;
    }
}

-(IBAction)back:(id)sender{
    [self.delegate ToolBarViewControllerDidBack:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return toolBarCount
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)cv
             cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    ToolBarCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ToolBarCell"
                                                      forIndexPath:indexPath];
    if (!cell) {
        return nil;
    }
    
    NSString *imageName=[[NSString alloc]initWithFormat:@"toolBar%d.png",indexPath.item];
    cell.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [cell.imageView setFrame:cell.contentView.frame];
    [cell.contentView addSubview:cell.imageView];
    
    return cell;
}
 */

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{ // Create a graphics image context
    UIGraphicsBeginImageContext(newSize); // Tell the old image to draw in this new context, with the desired // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)]; // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext(); // End the context
    UIGraphicsEndImageContext(); // Return the new image.
    return newImage;
}

-(void)saveImage{
    UIImage *image=backgroundImage.image;
    NSData *data;
    NSString *filepath;
    data = UIImagePNGRepresentation(image);
    filepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ToolBarBackground.png"];
    
    /*if (UIImagePNGRepresentation(image) == nil) {
     
     data = UIImageJPEGRepresentation(image, 1);
     filepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Important.jpg"];
     
     } else {
     */
    
    [data writeToFile:filepath atomically:YES];
}

- (void)viewDidUnload {
    [self setBackgroundImage:nil];
    [self setLabel1:nil];
    [self setLabel2:nil];
    [self setLabel3:nil];
    [self setLabel4:nil];
    [self setLabel5:nil];
    [self setLabel6:nil];
    [self setToolBar7:nil];
    [self setToolBar8:nil];
    [super viewDidUnload];
}

- (IBAction)changeBackground:(id)sender {
    UIActionSheet *actionSheet;
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"更改背景" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"还原默认背景" otherButtonTitles:@"拍照", @"从相册选择", nil];
    actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

- (IBAction)hideButtons:(UIBarButtonItem *)sender {
    if (isHideButtons){
        sender.title=@"隐身";
        isHideButtons=NO;
        label1.hidden=NO;
        label2.hidden=NO;
        label3.hidden=NO;
        label4.hidden=NO;
        label5.hidden=NO;
        label6.hidden=NO;
        toolBar0.hidden=NO;
        toolBar1.hidden=NO;
        toolBar2.hidden=NO;
        toolBar4.hidden=NO;
        toolBar5.hidden=NO;
        toolBar6.hidden=NO;
        toolBar7.hidden=NO;
        toolBar8.hidden=NO;
    }else{
        sender.title=@"显形";
        isHideButtons=YES;
        label1.hidden=YES;
        label2.hidden=YES;
        label3.hidden=YES;
        label4.hidden=YES;
        label5.hidden=YES;
        label6.hidden=YES;
        toolBar0.hidden=YES;
        toolBar1.hidden=YES;
        toolBar2.hidden=YES;
        toolBar4.hidden=YES;
        toolBar5.hidden=YES;
        toolBar6.hidden=YES;
        toolBar7.hidden=YES;
        toolBar8.hidden=YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (bannerIsVisible)
    {
        adView.hidden = YES;
        bannerIsVisible = NO;
    }
}

#pragma mark - MirrorDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    double times=image.size.width/500;
    
    image = [self imageWithImageSimple:image scaledToSize:
             CGSizeMake(image.size.width/times, image.size.height/times)];
    
    [backgroundImage setImage:image];
    [self saveImage];
    
}

#pragma mark - LighterViewControllerDelegate

-(void) LighterViewControllerDidBack:(LighterViewController *)controller{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - LocationViewControllerDelegate

-(void) LocationViewControllerDidBack:(LocationViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - OurSchoolViewControllerDelegate

-(void) ourSchoolViewControllerDidBack:(OurSchoolViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end