//
//  TableViewDataSource.h
//  SeperatDataSourceTest
//
//  Created by YS_Chan on 15/7/24.
//  Copyright (c) 2015年 YS_Chan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^TableViewCellConfigureBlock)(id cell, id items);

@interface TableViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>
- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
