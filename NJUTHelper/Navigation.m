//
//  Navigation.m
//  NJUTHelper
//
//  Created by 范 威 on 12-8-13.
//  Copyright (c) 2012年 范 威. All rights reserved.
//
#define keyName @"KEYNAVIGATIONNAME"
#define keyURL @"KEYNAVIGATIONURL"

#import "Navigation.h"

@implementation Navigation

@synthesize name;
@synthesize URL;

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:keyName];
    [aCoder encodeObject:self.URL forKey:keyURL];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:keyName];
        self.URL = [aDecoder decodeObjectForKey:keyURL];
    }
    return self;
}

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
    Navigation *copy = [[[self class] allocWithZone: zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.URL = [self.URL copyWithZone:zone];
    return copy;
}
@end
