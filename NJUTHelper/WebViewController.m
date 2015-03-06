//
//  WebViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize delegate;
@synthesize webView;
@synthesize urlFromNavigation;
@synthesize activityIndicatorView;

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
    webView.backgroundColor=[UIColor underPageBackgroundColor];
    [super viewDidLoad];
    webView.scalesPageToFit =YES;
    webView.delegate =self;
    NSString *abc=[urlFromNavigation absoluteString];
    NSString *bcd=[[NSString alloc] initWithFormat:@"http://%@", abc];
    NSURL *nsurl=[[NSURL alloc] initWithString:bcd];
    [webView loadRequest:[NSURLRequest requestWithURL:nsurl]];
    
    activityIndicatorView.hidesWhenStopped = YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    UIApplication* app = [ UIApplication  sharedApplication ];
    app.networkActivityIndicatorVisible = YES;
    
    [activityIndicatorView startAnimating] ;
}

-(IBAction)userWebViewDidFinishLoad:(id)sender{
    [webView stopLoading];
    [self webViewDidFinishLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIApplication* app = [ UIApplication  sharedApplication ];
    app.networkActivityIndicatorVisible = NO;
    
    [activityIndicatorView stopAnimating] ;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *tmp=[error localizedDescription];
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:tmp  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    if ([tmp isEqualToString:@"The Internet connection appears to be offline."])
        [alterview show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender
{
    [self.delegate WebViewControllerDidBack:self];
}

@end
