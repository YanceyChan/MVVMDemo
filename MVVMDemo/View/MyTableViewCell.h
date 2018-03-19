//
//  MyTableViewCell.h
//  SeperatDataSourceTest
//
//  Created by YS_Chan on 15/7/24.
//  Copyright (c) 2015年 YS_Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyModel;

@interface MyTableViewCell : UITableViewCell
+ (UINib *)nib;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@end

//分类
@interface MyTableViewCell (ConfigureCell)
- (void)configureCellWithModel:(MyModel *)myModel;
@end