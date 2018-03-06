//
//  ViewController.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/6.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "MainViewController.h"
#import <Masonry/Masonry.h>
#import "DelegateDemoViewController.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *listTitleArray;
@end


static NSString * const cellID = @"cellID";

@implementation MainViewController
#pragma mark - Life Cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_Prepare];
}

#pragma mark - Delegate 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = self.listTitleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.listTitleArray[indexPath.row];
    if ([title isEqualToString:@"代理demo"]) {
        DelegateDemoViewController *vc = [[DelegateDemoViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Event Response 事件响应
#pragma mark - NetWork 网络请求
#pragma mark - UI 界面&约束

- (void)p_Prepare {
    [self p_SetupUI];
    [self p_SetupNav];
}

- (void)p_SetupUI {
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        [self.view addSubview:tableView];
        tableView;
    });
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)p_SetupNav {
    self.title = @"MVVMDemo";
    
}

#pragma mark - Private Methods 私有方法
#pragma mark - Getters and Setters
- (NSArray *)listTitleArray {
    if (!_listTitleArray) {
        _listTitleArray = @[@"代理demo"];
    }
    
    return _listTitleArray;
}


@end
