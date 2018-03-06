//
//  KVODemoViewController.m
//  MVVMDemo
//
//  Created by PSBC_Yancey on 2018/3/6.
//  Copyright © 2018年 Yancey_Chan. All rights reserved.
//

#import "KVODemoViewController.h"
#import "Person.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface KVODemoViewController ()
@property (strong, nonatomic) Person *person;
@end

@implementation KVODemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.person = [[Person alloc] init];
    self.person.name = @"Mike";
//    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [[self.person rac_valuesForKeyPath:@"name" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"RAC:Name is changed! new = %@",x);
    }];
    self.person.name = @"Jack";
}


//-(void)dealloc{
//    [self.person removeObserver:self forKeyPath:@"name" context:nil];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    if ([keyPath isEqualToString:@"name"]) {
//        NSLog(@"Name is changed! new = %@",[change valueForKey:NSKeyValueChangeNewKey]);
//    }else{
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}



@end
