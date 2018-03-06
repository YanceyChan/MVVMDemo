//
//  DelegateRedView.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/6.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "DelegateRedView.h"

@implementation DelegateRedView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


- (void)clickView:(UIGestureRecognizer *)gestureRecognizer {
    //在点击redView时，代理方法实现
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickRedView)]) {
        [self.delegate didClickRedView];
    }
}

@end
