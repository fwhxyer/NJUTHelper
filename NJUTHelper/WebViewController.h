//
//  WebViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@protocol WebViewControllerDelegate <NSObject>
- (void) WebViewControllerDidBack:(WebViewController *)controller;

@end

@interface WebViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIActivityIndicatorView *activityIndicatorView;
}

@property (nonatomic, weak) id <WebViewControllerDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSURL *urlFromNavigation;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicatorView;

-(IBAction)back:(id)sender;
-(IBAction)userWebViewDidFinishLoad:(id)sender;

@end
