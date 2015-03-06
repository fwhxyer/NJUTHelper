//
//  ClassViewController.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-19.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "AddNoteViewController.h"
#import "ClassDetailViewController.h"
#import "NoteDetailViewController.h"

@interface ClassViewController : UITableViewController <AddNoteViewControllerDelegate,NoteDetailViewControllerDelegate>

@property (nonatomic,retain) IBOutlet UITableView *mainView;
@property (nonatomic,retain) NSMutableArray *notes;

@end
