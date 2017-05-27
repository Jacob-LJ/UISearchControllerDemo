//
//  JABaseViewController.m
//  UISearchControllerDemo
//
//  Created by Jacob on 2017/5/27.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JABaseViewController.h"

@interface JABaseViewController ()

@end

@implementation JABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"👻%s ---> %@", __PRETTY_FUNCTION__, self.class);
}


@end
