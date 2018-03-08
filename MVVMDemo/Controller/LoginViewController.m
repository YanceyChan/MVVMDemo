//
//  LoginViewController.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/7.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginViewController ()
@property (strong, nonatomic) LoginViewModel *loginViewModel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;
@property (strong, nonatomic) UITextField *phoneNumberTextField;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self bindViewModel];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.phoneNumberLabel = ({
        UILabel *phoneNumberLabel = [[UILabel alloc] init];
        phoneNumberLabel.text = @"手机号";
        phoneNumberLabel.textColor = [UIColor grayColor];
        phoneNumberLabel.font = [UIFont systemFontOfSize:14];
        phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:phoneNumberLabel];
        phoneNumberLabel;
    });
    
    self.phoneNumberTextField = ({
        UITextField *phoneNumberTextField = [[UITextField alloc] init];
        phoneNumberTextField.placeholder = @"请输入手机号";
        phoneNumberTextField.backgroundColor = [UIColor yellowColor];
        phoneNumberTextField.layer.borderColor = [UIColor redColor].CGColor;
        phoneNumberTextField.layer.borderWidth = 0.5;
        phoneNumberTextField.layer.cornerRadius = 5;
        [self.view addSubview:phoneNumberTextField];
        phoneNumberTextField;
    });
    
    self.passwordLabel = ({
        UILabel *passwordLabel = [[UILabel alloc] init];
        passwordLabel.text = @"密码";
        passwordLabel.textColor = [UIColor grayColor];
        passwordLabel.font = [UIFont systemFontOfSize:14];
        passwordLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:passwordLabel];
        passwordLabel;
    });
    
    self.passwordTextField = ({
        UITextField *passwordTextField = [[UITextField alloc] init];
        passwordTextField.placeholder = @"请输入8-16位非纯数字密码";
        passwordTextField.backgroundColor = [UIColor yellowColor];
        passwordTextField.layer.borderColor = [UIColor redColor].CGColor;
        passwordTextField.layer.borderWidth = 0.5;
        passwordTextField.layer.cornerRadius = 5;
        [self.view addSubview:passwordTextField];
        passwordTextField;
    });
    
    self.loginButton = ({
        UIButton *loginButton = [[UIButton alloc] init];
        [loginButton setTitle:@"LOGIN" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginButton setBackgroundColor:[UIColor grayColor]];
        loginButton.layer.cornerRadius = 10;
        [self.view addSubview:loginButton];
        loginButton;
    });
    
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.height.equalTo(@44);
    }];
    
    [self.phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneNumberTextField);
        make.right.equalTo(self.phoneNumberTextField.mas_left).offset(-10);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumberTextField.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.phoneNumberTextField);
        make.height.equalTo(@44);
    }];
    
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordTextField);
        make.right.equalTo(self.passwordTextField.mas_left).offset(-10);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.phoneNumberTextField);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(80);
        make.centerX.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
}

- (void)bindViewModel {
    self.loginViewModel = [[LoginViewModel alloc] init];
    
    @weakify(self);
    
    //绑定self.loginViewModel.phoneNumber -> self.phoneNumberTextField的输入
    //通过程序赋值phoneNumberTextField = @"xxx"，不会触发phoneNumberTextField.rac_textSignal
    RAC(self.loginViewModel , phoneNumber) = [RACSignal merge:@[RACObserve(self.phoneNumberTextField, text),self.phoneNumberTextField.rac_textSignal]];
    
    //绑定self.loginViewModel.password -> self.passwordTextField的输入
    RAC(self.loginViewModel , password) = [RACSignal merge:@[RACObserve(self.passwordTextField, text),self.passwordTextField.rac_textSignal]];
    
    //绑定loginButton的enabled -> self.loginViewModel.validLoginSignal
    RAC(self.loginButton, enabled) = self.loginViewModel.validLoginSignal;
    
    //当self.loginButton.enable改变时，背景颜色也改变
    [RACObserve(self.loginButton, enabled) subscribeNext:^(id  _Nullable x) {
        self.loginButton.backgroundColor = [x boolValue] ? [UIColor orangeColor] : [UIColor grayColor];
    }];

    //action方法绑定
    [[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
//          @strongify(self);
          NSLog(@"doNext");
      }]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         NSLog(@"loginCommand");
         [self.loginViewModel.loginCommand execute:nil];
     }];
    
    //获取数据成功处理
    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    //处理错误
    [self.loginViewModel.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
        NSLog(@"error:%@", x.userInfo[@"errorMsg"]);
    }];
}

@end
