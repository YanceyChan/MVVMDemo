//
//  LoginViewModel.h
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/7.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

typedef void(^successBlock)(id result);
typedef void(^failureBlock)(NSError *error);

@interface LoginViewModel : NSObject
//手机号码
@property (strong, nonatomic) NSString *phoneNumber;
//密码
@property (strong, nonatomic) NSString *password;
/// 按钮能否点击
@property (nonatomic, strong) RACSignal *validLoginSignal;
/// 登录按钮点击执行的命令
@property (nonatomic, strong) RACCommand *loginCommand;

@property (assign, nonatomic) BOOL bRemenberAccount;
@property (assign, nonatomic) BOOL bAutoLogin;


//登录网络请求
- (void)loginWithSuccess:(successBlock)successBlock failuer:(failureBlock)failureBlock;
@end
