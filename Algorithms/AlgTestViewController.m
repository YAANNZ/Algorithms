//
//  AlgTestViewController.m
//  Algorithms
//
//  Created by InbasisZyn on 2020/12/23.
//  Copyright © 2020 zynabc. All rights reserved.
//

#import "AlgTestViewController.h"

@interface AlgTestViewController ()

@end

@implementation AlgTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 求第n个费纳波契数
    // 0 1 1 2 3 5 8 13
    NSLog(@"%d", [self fib:32]);
    NSLog(@"%d", [self fib2:32]);
    
    /* 算法评判标准
     1. 时间复杂度
        指令执行次数（执行时间）
     2. 空间复杂度
        程序执行占用空间
     3. 正确性、可读性、健壮性
     */
    /* 大O表示法
     */
}

- (int)fib:(int)input
{
    if (input <= 1) {
        return input;
    }
    
    return [self fib:input - 1] + [self fib:input - 2];
}

- (int)fib2:(int)input
{
    if (input <= 1) {
        return input;
    }
    
    int first = 0;
    int second = 1;
    for (int i = 0; i < input - 1; i++) {
        int sum = first + second;
        first = second;
        second = sum;
    }
    
    return second;
}


@end
