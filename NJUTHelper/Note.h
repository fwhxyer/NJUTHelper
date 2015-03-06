//
//  Note.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-19.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *detail;
@property (nonatomic,retain) NSString *date;

@end
