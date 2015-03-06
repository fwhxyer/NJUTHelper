//
//  ClassDetailViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define kCourses @"KEYCLASSCOURSES"

#import "ClassDetailViewController.h"

@interface ClassDetailViewController () {
    NSMutableArray *courseDetails;
}

@end

@implementation ClassDetailViewController
@synthesize mainView;
@synthesize textField1;
@synthesize textField2;
@synthesize textField3;
@synthesize textField4;
@synthesize textField5;
@synthesize textField6;
@synthesize textField7;
@synthesize textField8;
@synthesize textField9;
@synthesize textField10;
@synthesize weekdayLabel;
@synthesize indexInCourses;
@synthesize coursePhoto;
@synthesize courses;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initWithDefaultCourses{
    courseDetails= [[NSMutableArray alloc]initWithObjects:nil];
    courses= [[NSMutableArray alloc]initWithObjects:nil];
    for (int j=0; j<7; j++) {
        for (int i=0; i<10; i++)
            if (i!=4) [courseDetails addObject:@""]; else [courseDetails addObject:@"晚自习"];
        [courses addObject:courseDetails];
    }
}

-(NSString *)archivePath{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docDir stringByAppendingPathComponent:kCourses];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainView.backgroundColor = [UIColor underPageBackgroundColor];
    
    switch (indexInCourses) {
        case 0:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"星期一"];
            break;
        case 1:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"星期二"];
            break;
        case 2:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"星期三"];
            break;
        case 3:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"星期四"];
            break;
        case 4:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"星期五"];
            break;
        case 5:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"星期六"];
            break;
        case 6:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"星期日"];
            break;
        default:
            weekdayLabel.text = [[NSString alloc] initWithFormat:@"出错啦"];
            break;
    }

    self.courses = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    
    if (self.courses == nil){
        [self initWithDefaultCourses];
    }
    
    courseDetails=[courses objectAtIndex:indexInCourses];
    textField1.text=[courseDetails objectAtIndex:0];
    textField2.text=[courseDetails objectAtIndex:1];
    textField3.text=[courseDetails objectAtIndex:2];
    textField4.text=[courseDetails objectAtIndex:3];
    textField5.text=[courseDetails objectAtIndex:4];
    textField6.text=[courseDetails objectAtIndex:5];
    textField7.text=[courseDetails objectAtIndex:6];
    textField8.text=[courseDetails objectAtIndex:7];
    textField9.text=[courseDetails objectAtIndex:8];
    textField10.text=[courseDetails objectAtIndex:9];
    
    NSString *tmp = [[NSString alloc]initWithFormat:@"classCourse%d.png",indexInCourses];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:tmp];
    UIImage *img=[UIImage imageWithContentsOfFile:path];
    if (!img) {
        img=[UIImage imageNamed:@"background3.jpg"];
    }
    [coursePhoto setImage:img];
    
    coursePhoto.userInteractionEnabled=YES;
    UITapGestureRecognizer *leftSwipeRecognizer;
    leftSwipeRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                               action:@selector(initCamera:)];
    leftSwipeRecognizer.numberOfTouchesRequired=1;
    leftSwipeRecognizer.numberOfTapsRequired=1;
    [coursePhoto addGestureRecognizer:leftSwipeRecognizer];
}

-(void)initCamera:(UITapGestureRecognizer *)recognizer{
    UIImagePickerController *uiImagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]){
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

-(void)viewWillDisappear:(BOOL)animated{
    NSString *tmp1=[[NSString alloc]initWithString:textField1.text];
    NSString *tmp2=[[NSString alloc]initWithString:textField2.text];
    NSString *tmp3=[[NSString alloc]initWithString:textField3.text];
    NSString *tmp4=[[NSString alloc]initWithString:textField4.text];
    NSString *tmp5=[[NSString alloc]initWithString:textField5.text];
    NSString *tmp6=[[NSString alloc]initWithString:textField6.text];
    NSString *tmp7=[[NSString alloc]initWithString:textField7.text];
    NSString *tmp8=[[NSString alloc]initWithString:textField8.text];
    NSString *tmp9=[[NSString alloc]initWithString:textField9.text];
    NSString *tmp10=[[NSString alloc]initWithString:textField10.text];
    courseDetails = [[NSMutableArray alloc]initWithObjects:
                     tmp1,
                     tmp2,
                     tmp3,
                     tmp4,
                     tmp5,
                     tmp6,
                     tmp7,
                     tmp8,
                     tmp9,
                     tmp10,
               nil];
    [courses replaceObjectAtIndex:indexInCourses withObject:courseDetails];
    
    [NSKeyedArchiver archiveRootObject:courses toFile:[self archivePath]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)hideKeyboard:(id)sender{
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    [textField3 resignFirstResponder];
    [textField4 resignFirstResponder];
    [textField5 resignFirstResponder];
    [textField6 resignFirstResponder];
    [textField7 resignFirstResponder];
    [textField8 resignFirstResponder];
    [textField9 resignFirstResponder];
    [textField10 resignFirstResponder];
}

-(void)saveImage{
    UIImage *image=coursePhoto.image;
    NSData *data;
    NSString *filepath;
    data = UIImagePNGRepresentation(image);
    
    NSString *tmp = [[NSString alloc]initWithFormat:@"Documents/classCourse%d.png",indexInCourses];
    filepath = [NSHomeDirectory() stringByAppendingPathComponent:tmp];
    
    [data writeToFile:filepath atomically:YES];
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
    
    double times=image.size.height/800;
    
    image = [self imageWithImageSimple:image scaledToSize:
             CGSizeMake(image.size.width/times, image.size.height/times)];
    
    [coursePhoto setImage:image];
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

@end
