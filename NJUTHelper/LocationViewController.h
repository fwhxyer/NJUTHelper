//
//  LocationViewController.h
//  NJUT_C_S_
//
//  Created by Wayne Fan on 12-5-3.
//  Copyright (c) 2012年 南京工业大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class LocationViewController;

@protocol LocationViewControllerDelegate <NSObject>
- (void)LocationViewControllerDidBack:(LocationViewController *)controller;
@end

@interface LocationViewController : UIViewController
    <CLLocationManagerDelegate>
{
    CLLocationManager *locMan;
    CLLocation *recentLocation;
    IBOutlet UIView *mainView;
    IBOutlet UILabel *distancLabel;
    IBOutlet UIView *distanceView;
    IBOutlet UIView *waitView;
    IBOutlet UIImageView *directionArrowSouthFix;
    IBOutlet UIImageView *directionArrowNJUT;
    IBOutlet UIImageView *chineseCharater1;
    IBOutlet UIImageView *chineseCharater2;
    IBOutlet UIImageView *chineseCharater3;
    IBOutlet UIImageView *chineseCharater4;
    IBOutlet UIImageView *chineseCharater5;
    CGAffineTransform oldDelta;
}

@property (nonatomic,weak) id <LocationViewControllerDelegate> delegate;
@property (nonatomic,retain) UIView *mainView;
@property (strong,nonatomic) CLLocationManager *locMan;
@property (retain,nonatomic) CLLocation *recentLocation;
@property (retain,nonatomic) UILabel *distancLabel;
@property (retain,nonatomic) UIView *distanceView;
@property (retain,nonatomic) UIView *waitView;
@property (retain,nonatomic) UIImageView *directionArrowSouthFix;
@property (retain,nonatomic) UIImageView *directionArrowNJUT;
@property (retain,nonatomic) UIImageView *chineseCharater1;
@property (retain,nonatomic) UIImageView *chineseCharater2;
@property (retain,nonatomic) UIImageView *chineseCharater3;
@property (retain,nonatomic) UIImageView *chineseCharater4;
@property (retain,nonatomic) UIImageView *chineseCharater5;

-(double)headingToLocation:(CLLocationCoordinate2D)desired
                    current:(CLLocationCoordinate2D)current;

@end
