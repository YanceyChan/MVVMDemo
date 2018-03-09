//
//  User.h
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/7.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *password;
@property (assign, nonatomic) BOOL bRemenberAccount;
@property (assign, nonatomic) BOOL bAutoLogin;
@end
