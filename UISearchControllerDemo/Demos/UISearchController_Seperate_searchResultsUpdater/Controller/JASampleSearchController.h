//
//  JASampleSearchController.h
//  UISearchControllerDemo
//
//  Created by Jacob on 2017/5/27.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JABaseViewController.h"

@interface JASampleSearchController : JABaseViewController

@property (nonatomic, copy) void(^selectedBlock)(NSString *item);

@end
