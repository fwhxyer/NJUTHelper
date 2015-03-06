//
//  Mirror.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-16.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import "Mirror.h"

@implementation Mirror
@synthesize imagePicker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton* cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancel setTitle:@"返回工具栏" forState:UIControlStateNormal];
        if (iPhone5) {
            cancel.frame = CGRectMake(0, 538, 320, 50);
        }else
        cancel.frame = CGRectMake(0, 430, 320, 50);
        [cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(countDown) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancel];
    }
    return self;
}

-(void)countDown{
    [imagePicker.delegate imagePickerControllerDidCancel:imagePicker];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
