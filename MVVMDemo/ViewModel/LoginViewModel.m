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
    
//    @weakify(self);
    
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, phoneNumber),RACObserve(self, password)]
                                               reduce:^(NSString *phoneNubmer, NSString *password){
        return @(phoneNubmer.length > 0 && password.length > 0);
    }] distinctUntilChanged];
    
    
}


@end
