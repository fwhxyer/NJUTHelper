//
//  NoteDetailViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-20.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@class NoteDetailViewController;

@protocol NoteDetailViewControllerDelegate <NSObject>

-(void)noteDetailViewController:(NoteDetailViewController *)noteDetailViewController didBackWithNote:(Note *) theNote;

@end


@interface NoteDetailViewController : UIViewController

@property (nonatomic,weak) id <NoteDetailViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UIView *mainView;
@property (nonatomic,retain) Note *note;
@property (strong, nonatomic) IBOutlet UITextField *titleTextFiled;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
@property (strong, nonatomic) IBOutlet UILabel *dateTextField;

@end
