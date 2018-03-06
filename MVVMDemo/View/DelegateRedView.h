//
//  DelegateRedView.h
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/6.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DelegateRedView;
@protocol DelegateRedViewDelegate<NSObject>
@optional
- (void)didClickRedView;
@end

@interface DelegateRedView : UIView
@property (weak, nonatomic) id<DelegateRedViewDelegate> delegate;

- (void)clickView:(UIGestureRecognizer *)gestureRecognizer;

@end
