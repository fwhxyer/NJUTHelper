//
//  AddNoteViewController.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController
@synthesize mainView;
@synthesize textField;
@synthesize textView;
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
    
    [textField becomeFirstResponder];
}

-(IBAction)cancel:(id)sender{
    [self.delegate addNoteViewControllerDidCancel:self];
}

-(IBAction)done:(id)sender{
    Note *note=[Note alloc];
    note.title = textField.text;
    note.detail = textView.text;
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    [datef setDateFormat:@"HH:mm:ss    MM月dd日    yyyy年"];
    note.date = [datef stringFromDate:[NSDate date]];
    
    if ([note.title isEqualToString:@""])
        [self.delegate addNoteViewControllerDidCancel:self];
    else
        [self.delegate addNoteViewController:self didAddNote:note];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
