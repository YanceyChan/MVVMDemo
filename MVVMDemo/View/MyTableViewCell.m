//
//  MyTableViewCell.m
//  SeperatDataSourceTest
//
//  Created by YS_Chan on 15/7/24.
//  Copyright (c) 2015年 YS_Chan. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MyModel.h"
@implementation MyTableViewCell
+ (UINib *)nib{
    //注意使用对应的nibName（xib文件名）
    return [UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end



@implementation MyTableViewCell (ConfigureCell)
- (void)configureCellWithModel:(MyModel *)myModel{
    self.model = myModel;
    self.nameLabel.text = myModel.name;
    self.ageLabel.text = myModel.age;
    self.addressLabel.text = myModel.address;
    self.idLabel.text = myModel.identifier;
}
@end


