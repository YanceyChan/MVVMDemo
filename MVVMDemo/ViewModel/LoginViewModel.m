//
//  LoginViewModel.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/7.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "LoginViewModel.h"


@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setupBinding];
    }
    
    return self;
}

- (void)setupBinding {
    
    @weakify(self);
    
    //按钮能否点击的判断条件
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, phoneNumber),RACObserve(self, password)]
                                               reduce:^(NSString *phoneNubmer, NSString *password){
        return @(phoneNubmer.length > 0 && password.length >= 8);
    }] distinctUntilChanged];
    
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        // 这里手机号以及验证码在控制器那里也可以在视图控制器筛选，但同时也可以在viewModel中处理
        // 最好的写法:button.rac_command = viewmodel.loginCommand...把位数判断移到这里
        if (self.phoneNumber.length < 11) {
            return [RACSignal error:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{@"errorMsg":@"请输入正确的手机号码"}]];
            
        }
        if (self.password.length < 8 || self.password.length > 16) {
            return [RACSignal error:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{@"errorMsg":@"密码长度超出范围"}]];
        }
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            @weakify(self);
            /// 发起请求 模拟网络请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                /// 登录成功 保存数据 简单起见 随便存了哈
                /// 保存用户数据 这个逻辑就不要我来实现了吧 假数据参照 [AppDelegate sharedDelegate].account
                /// 模拟成功或者失败
#if 1
                [subscriber sendNext:nil];
                /// 必须sendCompleted 否则command.executing一直为1 导致HUD 一直 loading
                [subscriber sendCompleted];
#else
                /// 失败的回调 我就不处理 现实中开发绝逼不是这样的
                [subscriber sendError:return [RACSignal error:[NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:@{@"errorMsg":@"服务器不给力"}]];];
#endif
            });
            
            return nil;
        }];
    }];
    
    
}


@end
