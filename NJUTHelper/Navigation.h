//
//  Navigation.h
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Navigation : NSObject <NSCoding,NSCopying>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *URL;

@end
