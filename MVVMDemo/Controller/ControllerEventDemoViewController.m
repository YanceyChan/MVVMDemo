//
//  ControllerEventDemoViewController.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/6.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "ControllerEventDemoViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

static NSString * const testNotification = @"testNotification";

@interface ControllerEventDemoViewController ()
@property (strong, nonatomic) UIButton *demoButton;
@end

@implementation ControllerEventDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotify) name:testNotification object:nil];
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:testNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"RAC:receiveNotify");
        @strongify(self);
        self.view.backgroundColor = [UIColor yellowColor];
    }];
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.demoButton = [[UIButton alloc] init];
    [self.demoButton setTitle:@"RAC" forState:UIControlStateNormal];
    [self.demoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.demoButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    self.demoButton.backgroundColor = [UIColor redColor];
//    [self.demoButton addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [[self.demoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"RAC clickBtn");
        [[NSNotificationCenter defaultCenter] postNotificationName:testNotification object:nil];
    }];
    [self.view addSubview:self.demoButton];
    [self.demoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.5);
        make.height.equalTo(@44);
    }];
}

- (void)clickBtn {
    NSLog(@"clickBtn");
}

- (void)receiveNotify {
    NSLog(@"receiveNotify");
}

@end
