//
//  TableViewDataSource.m
//  SeperatDataSourceTest
//
//  Created by YS_Chan on 15/7/24.
//  Copyright (c) 2015年 YS_Chan. All rights reserved.
//

#import "TableViewDataSource.h"
#import "MyTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TableViewDataSource()
@property (copy, nonatomic) NSString *cellIdentifier;
@property (strong, nonatomic) NSArray *items;
@property (copy, nonatomic) TableViewCellConfigureBlock configureBlock;
@end

@implementation TableViewDataSource

- (instancetype)init{
    return nil;
}

- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureBlock{
    if (self = [super init]) {
        _cellIdentifier = aCellIdentifier;
        _items = anItems;
        _configureBlock = configureBlock;
//        [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(id  _Nullable x) {
//            NSLog(@"TableViewDataSource:%@", x);
//        }];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return self.items[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
//    /*⬇️使用系统UITableViewCell时，registerNib:这方法不用时，这段不加，崩溃⬇️*/  因为没注册所以重用标识找不到要重用的cell
//    xib创建的，只需要在xib协商reuseID，就不需要再注册cell了。
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellIdentifier];
//    }
//    /*⬆️使用系统UITableViewCell时，registerNib:这方法不用时，这段不加，崩溃⬆️*/

    id item = [self itemAtIndexPath:indexPath];
    self.configureBlock(cell, item);
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@",indexPath);
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
@end
