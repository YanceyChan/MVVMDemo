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
#import <MBProgressHUD/MBProgressHUD.h>
#import "MainPageViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) LoginViewModel *loginViewModel;
@property (strong, nonatomic) UILabel *phoneNumberLabel;
@property (strong, nonatomic) UITextField *phoneNumberTextField;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel *autoLoginLabel;
@property (strong, nonatomic) UISwitch *autoLoginSwitch;
@property (strong, nonatomic) UILabel *remenberAccountLabel;
@property (strong, nonatomic) UISwitch *remenberAccountSwitch;
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
    
    self.autoLoginLabel = ({
        UILabel *autoLoginLabel = [[UILabel alloc] init];
        autoLoginLabel.text = @"自动登录";
        autoLoginLabel.textColor = [UIColor grayColor];
        autoLoginLabel.font = [UIFont systemFontOfSize:14];
        autoLoginLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:autoLoginLabel];
        autoLoginLabel;
    });
    
    self.autoLoginSwitch = ({
        UISwitch *autoLoginSwitch = [[UISwitch alloc] init];
        [self.view addSubview:autoLoginSwitch];
        autoLoginSwitch;
    });
    
    self.remenberAccountSwitch = ({
        UISwitch *remenberAccountSwitch = [[UISwitch alloc] init];
        [self.view addSubview:remenberAccountSwitch];
        remenberAccountSwitch;
    });
    
    self.remenberAccountLabel = ({
        UILabel *remenberAccountLabel = [[UILabel alloc] init];
        remenberAccountLabel.text = @"记住用户名";
        remenberAccountLabel.textColor = [UIColor grayColor];
        remenberAccountLabel.font = [UIFont systemFontOfSize:14];
        remenberAccountLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:remenberAccountLabel];
        remenberAccountLabel;
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
    
    [self.remenberAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.width.equalTo(@80);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
    }];
    
    [self.remenberAccountSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remenberAccountLabel.mas_right).offset(10);
        make.centerY.equalTo(self.remenberAccountLabel);
    }];
    
    [self.autoLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remenberAccountLabel);
        make.top.equalTo(self.remenberAccountLabel.mas_bottom).offset(40);
        make.width.equalTo(self.remenberAccountLabel);
    }];
    
    [self.autoLoginSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.autoLoginLabel.mas_right).offset(10);
        make.centerY.equalTo(self.autoLoginLabel);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.phoneNumberTextField);
        make.top.equalTo(self.autoLoginLabel.mas_bottom).offset(80);
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
    
//    RACChannelTo(self.loginViewModel, bRemenberAccount) = self.remenberAccountSwitch.rac_newOnChannel;
    //上面价下面
    RACChannelTerminal *channelA = RACChannelTo(self.loginViewModel, bRemenberAccount);
    //双向绑定
    [self.remenberAccountSwitch.rac_newOnChannel subscribe:channelA];
    [channelA subscribe:self.remenberAccountSwitch.rac_newOnChannel];
    
    RACChannelTo(self.loginViewModel, bAutoLogin) = self.autoLoginSwitch.rac_newOnChannel;

    //action方法绑定
    [[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside]
      doNext:^(id x) {
//          @strongify(self);
          NSLog(@"doNext");
          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      }]
     subscribeNext:^(UIButton *sender) {
         @strongify(self);
         NSLog(@"loginCommand");
//         [self.loginViewModel.loginCommand execute:nil];
         
         @weakify(self);
         [self.loginViewModel loginWithSuccess:^(id result) {
             @strongify(self);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"result:%@", result);
             MainPageViewController *vc = [[MainPageViewController alloc] init];
             vc.title = result[@"msg"];
             [self.navigationController pushViewController:vc animated:YES];
         } failuer:^(NSError *error) {
             @strongify(self);
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *errorMsg = error.userInfo[@"errorMsg"];
             UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
             [alertC addAction:action];
             [self presentViewController:alertC animated:YES completion:nil];
         }];
     }];
    
    //获取数据成功处理
//    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        MainPageViewController *vc = [[MainPageViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
//
//
//    [[self.loginViewModel.loginCommand.errors doNext:^(NSError * _Nullable x) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }] subscribeNext:^(NSError * _Nullable x) {
//        NSString *errorMsg = x.userInfo[@"errorMsg"];
//        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//        [alertC addAction:action];
//
//        [self presentViewController:alertC animated:YES completion:nil];
//    }];
}

@end
