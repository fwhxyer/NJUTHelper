//
//  LocationViewController.m
//  NJUT_C_S_
//
//  Created by Wayne Fan on 12-5-3.
//  Copyright (c) 2012年 南京工业大学. All rights reserved.
//

#import "LocationViewController.h"
#define kLocationLatitude 32.07396944
#define kLocationLongitude 118.6389778
#define kSouthLatitude 90
#define kSouthLongitude 0
#define deg2rad 0.0174532925    
#define rad2deg 57.2957795

@implementation LocationViewController

@synthesize mainView;
@synthesize delegate;
@synthesize locMan;
@synthesize recentLocation;
@synthesize distanceView;
@synthesize distancLabel;
@synthesize waitView;
@synthesize directionArrowSouthFix;
@synthesize directionArrowNJUT;
@synthesize chineseCharater1;
@synthesize chineseCharater2;
@synthesize chineseCharater3;
@synthesize chineseCharater4;
@synthesize chineseCharater5;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    locMan = [[CLLocationManager alloc] init];
    locMan.delegate = self;
    locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    locMan.distanceFilter = 1000;          //1609
    [locMan startUpdatingLocation]; 
    if ([CLLocationManager headingAvailable]){ 
        locMan.headingFilter = 1;
        [locMan startUpdatingHeading];      
    }else{
        //hidden
    }
    directionArrowNJUT.center=CGPointMake(160,300);
    directionArrowSouthFix.center=CGPointMake(160,300);
    
    
    UISwipeGestureRecognizer *rightSwipeRecognizer;
    rightSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                  action:@selector(back:)];
    rightSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
    rightSwipeRecognizer.numberOfTouchesRequired=1;
    [mainView addGestureRecognizer:rightSwipeRecognizer];
    
    UISwipeGestureRecognizer *upSwipeRecognizer;
    upSwipeRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                               action:@selector(back:)];
    upSwipeRecognizer.direction=UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
    upSwipeRecognizer.numberOfTouchesRequired=1;
    [mainView addGestureRecognizer:upSwipeRecognizer];
    
}

- (void)back:(UISwipeGestureRecognizer *)recognizer{
    [locMan stopUpdatingLocation];
    [locMan stopUpdatingHeading];
    [self.delegate LocationViewControllerDidBack:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied)
    {
        [manager stopUpdatingLocation];
        locMan = nil;
    }
    waitView.hidden = YES;
    distanceView.hidden = YES;
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation.horizontalAccuracy >=0 )
    {
        self.recentLocation = newLocation;
        CLLocation *Location=[[CLLocation alloc]initWithLatitude:kLocationLatitude longitude:kLocationLongitude];
        CLLocationDistance delta =[Location distanceFromLocation:newLocation];
        long km=((delta*1)+.05)/1000;
        if (km<=1){
            //[locMan stopUpdatingLocation];
            //[locMan stopUpdatingHeading];
            distancLabel.text=@"开始享受你在南工大的美妙时光吧!";
        }else{
            NSNumberFormatter *commaDelimited=[[NSNumberFormatter alloc]init];
            [commaDelimited setNumberStyle:NSNumberFormatterDecimalStyle];
            distancLabel.text=[NSString stringWithFormat:@"你与南京工业大学相距%@千米",[commaDelimited stringFromNumber:[NSNumber numberWithLong:km]]];
        }
        waitView.hidden=YES;
        distanceView.hidden=NO;
        //directionArrowNJUT.hidden = NO;
        //directionArrowSouthFix.hidden = NO;
    }
}

-(double)headingToLocation:(CLLocationCoordinate2D)desired
                    current:(CLLocationCoordinate2D)current{
    double lat1= current.latitude*deg2rad;
    double lat2= desired.latitude*deg2rad;
    double lon1= current.longitude;
    double lon2= desired.longitude;
    double dlon=(lon2-lon1)*deg2rad;
    double y=sin(dlon)*cos(lat2);
    double x= cos(lat1)*sin(lat2)-sin(lat1)*cos(lat2)*cos(dlon);
    double heading=atan2(y, x);
    heading=heading*rad2deg;
    heading=heading+360.0;
    heading=fmod(heading, 360.0);
    return heading;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    directionArrowNJUT.hidden=NO;
    directionArrowSouthFix.hidden=NO;
    if (self.recentLocation != nil && newHeading.headingAccuracy >= 0)
    {
        CLLocation *NJUT=[[CLLocation alloc]
                           initWithLatitude:kLocationLatitude
                           longitude:kLocationLongitude];
        double course = [self headingToLocation:NJUT.coordinate current:recentLocation.coordinate];
        double delta=newHeading.trueHeading - course;
        //changed by i=(int)delta;  directionArrowNJUT=UIImage[i];
        CGAffineTransform transform=CGAffineTransformMakeRotation(-delta*deg2rad);
        [directionArrowNJUT setTransform:transform];
        
        
        CLLocation *south=[[CLLocation alloc]
                           initWithLatitude:kSouthLatitude
                           longitude:kSouthLongitude];
        course = [self headingToLocation:south.coordinate
                                        current:recentLocation.coordinate];
        delta=newHeading.trueHeading - course;
        double deltaAtDeg= delta;
        deltaAtDeg+=360;
        
        int aa=(int)(deltaAtDeg/22.5);
        int bb=(int)deltaAtDeg;
        int c3=bb;
        int c2=c3/10;
        int c1=c2/10;
        c3%=10;
        c2%=10;
        c1%=10;
        
        switch (aa) {
            case 0:case 15:
                chineseCharater1.image=[UIImage imageNamed:@"ZHENG.png"];
                chineseCharater2.image=[UIImage imageNamed:@"North.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
            case 1:case 2:
                chineseCharater1.image=[UIImage imageNamed:@"East.png"];
                chineseCharater2.image=[UIImage imageNamed:@"North.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
            case 3:case 4:
                chineseCharater1.image=[UIImage imageNamed:@"ZHENG.png"];
                chineseCharater2.image=[UIImage imageNamed:@"East.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
            case 5:case 6:
                chineseCharater1.image=[UIImage imageNamed:@"East.png"];
                chineseCharater2.image=[UIImage imageNamed:@"South.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
            case 7:case 8:
                chineseCharater1.image=[UIImage imageNamed:@"ZHENG.png"];
                chineseCharater2.image=[UIImage imageNamed:@"South.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
            case 9:case 10:
                chineseCharater1.image=[UIImage imageNamed:@"West.png"];
                chineseCharater2.image=[UIImage imageNamed:@"South.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
            case 11:case 12:
                chineseCharater1.image=[UIImage imageNamed:@"ZHENG.png"];
                chineseCharater2.image=[UIImage imageNamed:@"West.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
            case 13:case 14:
                chineseCharater1.image=[UIImage imageNamed:@"West.png"];
                chineseCharater2.image=[UIImage imageNamed:@"North.png"];
                chineseCharater3.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c1,@".png"]];
                chineseCharater4.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c2,@".png"]];
                chineseCharater5.image=[UIImage imageNamed:
                                        [NSString stringWithFormat:@"%i%@",c3,@".png"]];
                break;
                
            default:
                break;
        }
        //changed by i=(int)delta;  directionArrowSouthFix=UIImage[i];
        
        //CGAffineTransform transform1=CGAffineTransformMakeRotation(-delta*deg2rad);
        //[directionArrowSouthFix setTransform:transform1];
        
        ////testUsed distancLabel.text=[[NSString alloc]initWithFormat:@"%f",deltaAtDeg ];
    }else{
        directionArrowNJUT.hidden=YES;
        directionArrowSouthFix.hidden=YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
