//
//  MyModel.h
//  SeperatDataSourceTest
//
//  Created by YS_Chan on 15/7/24.
//  Copyright (c) 2015年 YS_Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *identifier;

- (instancetype)initWithName:(NSString *)name Age:(NSString *)age Address:(NSString *)address Identifier:(NSString *)identifier;
@end
