//
//  DelegateDemoViewController.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/6.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "DelegateDemoViewController.h"
#import "DelegateRedView.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface DelegateDemoViewController ()<DelegateRedViewDelegate>

@end

@implementation DelegateDemoViewController
#pragma mark - Life Cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    DelegateRedView *redView = [[DelegateRedView alloc] init];
    redView.delegate = self;
    [self.view addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@50);
        make.center.equalTo(self.view);
    }];
    
    //替代代理
    @weakify(self);
    [[redView rac_signalForSelector:@selector(clickView:)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"clickView RAC \nx:%@", x);
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
//    [[self rac_signalForSelector:@selector(didClickRedView) fromProtocol:@protocol(DelegateRedViewDelegate) ] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"clickView RAC fromProtocol \nx:%@", x);
//        @strongify(self);
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
}

//#pragma mark DelegateRedViewDelegate
//- (void)didClickRedView {
//    NSLog(@"didClickRedView代理");
//}


@end
