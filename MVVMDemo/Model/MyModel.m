//
//  MyModel.m
//  SeperatDataSourceTest
//
//  Created by YS_Chan on 15/7/24.
//  Copyright (c) 2015年 YS_Chan. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel

- (instancetype)initWithName:(NSString *)name Age:(NSString *)age Address:(NSString *)address Identifier:(NSString *)identifier{
    self = [super init];
    if (self) {
        self.name = name;
        self.age = age;
        self.address = address;
        self.identifier = identifier;
    }
    return self;
}


@end
