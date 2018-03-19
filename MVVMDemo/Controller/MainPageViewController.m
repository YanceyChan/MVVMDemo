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

#import "MyModel.h"
#import "MyTableViewCell.h"
#import "TableViewDataSource.h"

@interface MainPageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *myTabelView;
@property (strong, nonatomic) NSArray *myModels;
@property (strong, nonatomic) TableViewDataSource *dataSoures;
@end

static NSString * const cellIdentifier = @"myCell";

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMyDataArray];
    [self setupUI];
    
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTabelView = ({
        UITableView *tableView = [[UITableView alloc] init];
        [self.view addSubview:tableView];
        [tableView registerNib:[MyTableViewCell nib] forCellReuseIdentifier:cellIdentifier];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    TableViewCellConfigureBlock cellConfigureBlock = ^(MyTableViewCell *cell, MyModel *item){
        //将item应用到cell上的方法
        [cell configureCellWithModel:item];
    };
    self.dataSoures = [[TableViewDataSource alloc]initWithItems:self.myModels cellIdentifier:cellIdentifier configureCellBlock:cellConfigureBlock];
    
    [[self.dataSoures rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(id  _Nullable x) {
        UITableView *tableView = x[0];
        NSIndexPath *tableIndexPath = x[1];
        MyTableViewCell *cell = [tableView cellForRowAtIndexPath:tableIndexPath];
        MyModel *model = cell.model;
        
        NSLog(@"Selected Name:%@", model.name);
    }];
    
    self.myTabelView.dataSource = self.dataSoures;
    self.myTabelView.delegate = self.dataSoures;
}

- (void)createMyDataArray{
    MyModel *jack = [[MyModel alloc]initWithName:@"jack" Age:@"20" Address:@"southStree 17" Identifier:@"1"];
    MyModel *jone = [[MyModel alloc]initWithName:@"jone" Age:@"21" Address:@"north 18" Identifier:@"2"];
    MyModel *may = [[MyModel alloc]initWithName:@"may" Age:@"19" Address:@"westStree 20" Identifier:@"3"];
    MyModel *tony = [[MyModel alloc]initWithName:@"tony" Age:@"18" Address:@"eastStreet" Identifier:@"4"];
    MyModel *marry = [[MyModel alloc]initWithName:@"marry" Age:@"20" Address:@"nononStreet" Identifier:@"5"];
    self.myModels = @[jack, jone, may, tony, marry];
}

@end
