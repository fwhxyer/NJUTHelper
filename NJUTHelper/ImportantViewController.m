//
//  ImportantViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define kItsName @"KEYITSNAME"
#define kItsTel @"KEYITSTEL"
#define kItsQQ @"KEYITSQQ"
#define kItsPhoto @"KEYITSPHOTO"
#define kItsPhotoFrame @"KEYITSPHOTOFRAME"

#import "ImportantViewController.h"

@interface ImportantViewController (){
    NSString *nameOfPhotoFrame;
}

@end

@implementation ImportantViewController
@synthesize mainView;
@synthesize itsName;
@synthesize itsTEL;
@synthesize itsQQ;
@synthesize itsPhoto;
@synthesize chooseImage;
@synthesize photoFrame;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
-(NSString *)archivePath{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:];
}
*/
-(void)saveImage{    
    UIImage *image=itsPhoto.image;
    NSData *data;
    NSString *filepath;
    data = UIImagePNGRepresentation(image);
    filepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Important.png"];
    
    /*if (UIImagePNGRepresentation(image) == nil) {
     
     data = UIImageJPEGRepresentation(image, 1);
     filepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Important.jpg"];
     
     } else {
     */
    
    [data writeToFile:filepath atomically:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:itsName.text forKey:kItsName];
    [userDefaults setObject:itsTEL.text forKey:kItsTel];
    [userDefaults setObject:itsQQ.text forKey:kItsQQ];
    [userDefaults setObject:nameOfPhotoFrame forKey:kItsPhotoFrame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainView.backgroundColor = [UIColor underPageBackgroundColor];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    itsName.text=[userDefaults stringForKey:kItsName];
    itsTEL.text=[userDefaults stringForKey:kItsTel];
    itsQQ.text=[userDefaults stringForKey:kItsQQ];
    nameOfPhotoFrame=[userDefaults stringForKey:kItsPhotoFrame];
    /*
     NSLog(@"%@",nameOfPhotoFrame);
    if ([nameOfPhotoFrame isEqualToString:@"取消相框"]){
        photoFrame.alpha=0;
    }else{
        photoFrame.alpha=1;
        [photoFrame setImage:[UIImage imageNamed:[nameOfPhotoFrame stringByAppendingString:@".png"]]];
    }
    */
    [self UIStyle:nameOfPhotoFrame];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Important.png"];
    UIImage *img=[UIImage imageWithContentsOfFile:path];
    if (!img) {
        img=[UIImage imageNamed:@"background2.jpg"];
    }
    [itsPhoto setImage:img];
    
    itsPhoto.userInteractionEnabled=YES;
    UITapGestureRecognizer *leftSwipeRecognizer;
    leftSwipeRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                               action:@selector(choosePhoto:)];
    leftSwipeRecognizer.numberOfTouchesRequired=1;
    leftSwipeRecognizer.numberOfTapsRequired=1;
    [itsPhoto addGestureRecognizer:leftSwipeRecognizer];
}

-(void)choosePhoto:(UITapGestureRecognizer *)recognizer{
    [self hideKeyboard:nil];
    UIActionSheet *actionSheet;
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除照片" otherButtonTitles:@"拍照", @"从相册选择", nil];
    actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"删除照片"]){
        [itsPhoto setImage:[UIImage imageNamed:@"background2.jpg"]];
    }else if ([buttonTitle isEqualToString:@"拍照"]){
        [self initCamera:1];
    }else if ([buttonTitle isEqualToString:@"从相册选择"]){
        [self initCamera:0];
    }else {
        [self UIStyle:buttonTitle];
    }
}

-(void)UIStyle:(NSString *)buttonTitle{
    if ([buttonTitle isEqualToString:@"取消相框"]){
        photoFrame.alpha = 0;
        nameOfPhotoFrame=buttonTitle;
        mainView.backgroundColor = [UIColor underPageBackgroundColor];
    }else if ([buttonTitle isEqualToString:@"夕阳之晖"]){
        photoFrame.alpha = 1.0f;
        nameOfPhotoFrame=buttonTitle;
        mainView.backgroundColor = [UIColor orangeColor];
        [photoFrame setImage:[UIImage imageNamed:@"夕阳之晖.png"]];
    }else if ([buttonTitle isEqualToString:@"热情友谊"]){
        photoFrame.alpha = 1.0f;
        nameOfPhotoFrame=buttonTitle;
        mainView.backgroundColor = [UIColor greenColor];
        [photoFrame setImage:[UIImage imageNamed:@"热情友谊.png"]];
    }else if ([buttonTitle isEqualToString:@"永恒爱情"]){
        photoFrame.alpha = 1.0f;
        nameOfPhotoFrame=buttonTitle;
        mainView.backgroundColor = [UIColor redColor];
        [photoFrame setImage:[UIImage imageNamed:@"永恒爱情.png"]];
    }else if ([buttonTitle isEqualToString:@"卡通风尚"]){
        photoFrame.alpha = 1.0f;
        nameOfPhotoFrame=buttonTitle;
        mainView.backgroundColor = [UIColor purpleColor];
        [photoFrame setImage:[UIImage imageNamed:@"卡通风尚.png"]];
    }
}

-(void)initCamera:(int)section{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)phoneIt:(id)sender{
    NSString *tel = [[NSString alloc]initWithFormat:@"tel://%@",itsTEL.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
}

-(IBAction)messageAll:(id)sender{
    //NSString *message = [[NSString alloc]initWithFormat:@"sms://%@",itsTEL.text];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:message]];
    
    if ([MFMessageComposeViewController canSendText]) {        
        NSArray *emailAddresses=[[NSArray alloc]initWithObjects:itsTEL.text, nil];
        MFMessageComposeViewController *mailComposer;
        mailComposer=[[MFMessageComposeViewController alloc]init];
        mailComposer.messageComposeDelegate=self;
        mailComposer.recipients = emailAddresses;
        NSString *tmp = [[NSString alloc]initWithFormat:
                    @"哈哈哈，%@你是由iphone客户端《校园手机伴侣》评选的我最珍视的人哦！balabala……" ,itsName.text];
        mailComposer.body = tmp;
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

- (IBAction)checkPhotoFrame:(id)sender {
    [self hideKeyboard:nil];
    UIActionSheet *actionSheet;
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择相框" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"取消相框" otherButtonTitles:@"夕阳之晖", @"热情友谊", @"永恒爱情", @"卡通风尚" , nil];
    actionSheet.actionSheetStyle = UIBarStyleBlackTranslucent;
    [actionSheet showInView:self.view];    
}

-(IBAction)hideKeyboard:(id)sender{
    [itsName resignFirstResponder];
    [itsTEL resignFirstResponder];
    [itsQQ resignFirstResponder];
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{ // Create a graphics image context
    UIGraphicsBeginImageContext(newSize); // Tell the old image to draw in this new context, with the desired // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)]; // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext(); // End the context
    UIGraphicsEndImageContext(); // Return the new image.
    return newImage;
}

#pragma mark - UIImagePickerControllerDelegate

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
    
    [itsPhoto setImage:image];
    [self saveImage];
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)viewDidUnload {
    [self setPhotoFrame:nil];
    [super viewDidUnload];
}
@end
