//
//  MainPageViewController.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/8.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "MainPageViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface MainPageViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
