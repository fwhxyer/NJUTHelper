//
//  AddNoteViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@class AddNoteViewController;

@protocol AddNoteViewControllerDelegate <NSObject>

-(void)addNoteViewControllerDidCancel:(AddNoteViewController *)addNoteViewController;
-(void)addNoteViewController:(AddNoteViewController *)addNoteViewController didAddNote:(Note *)note;

@end

@interface AddNoteViewController : UIViewController

@property (nonatomic,weak) id <AddNoteViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UIView *mainView;
@property (nonatomic,retain) IBOutlet UITextField *textField;
@property (nonatomic,retain) IBOutlet UITextView *textView;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

@end
