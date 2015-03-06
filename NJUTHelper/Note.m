//
//  Note.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-19.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define keyName1 @"KEYNOTETITLE"
#define keyName2 @"KEYNOTEDETAIL"
#define keyName3 @"KEYNOTEDATE"

#import "Note.h"

@implementation Note

@synthesize title;
@synthesize detail;
@synthesize date;

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:keyName1];
    [aCoder encodeObject:self.detail forKey:keyName2];
    [aCoder encodeObject:self.date forKey:keyName3];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:keyName1];
        self.detail = [aDecoder decodeObjectForKey:keyName2];
        self.date = [aDecoder decodeObjectForKey:keyName3];
    }
    return self;
}

@end
