//
//  NoteDetailViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "NoteDetailViewController.h"

@interface NoteDetailViewController ()

@end

@implementation NoteDetailViewController
@synthesize mainView;
@synthesize note;
@synthesize titleTextFiled;
@synthesize detailTextView;
@synthesize dateTextField;
@synthesize delegate;

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
    
    mainView.backgroundColor = [UIColor underPageBackgroundColor];
    
    titleTextFiled.text = note.title;
    detailTextView.text = note.detail;
    dateTextField.text = note.date;
}

-(void)viewWillDisappear:(BOOL)animated{
    note.title = titleTextFiled.text;
    note.detail = detailTextView.text;
    [self.delegate noteDetailViewController:self didBackWithNote:note];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
