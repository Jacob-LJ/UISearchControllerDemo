//
//  JADemoNameslListController.m
//  UISearchControllerDemo
//
//  Created by Jacob on 2017/5/27.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JADemoNameslListController.h"
//vc
#import "JASampleSearchController.h"

@interface JADemoNameslListController ()

@end

@implementation JADemoNameslListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
}

- (void)setUpNav {
    self.navigationItem.title = @"UISearchControllerDemosList";
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"分离searchVC和SearchResultUpdater";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //简单使用UISearchController
        JASampleSearchController *sampleSearchVC = [[JASampleSearchController alloc] init];
        sampleSearchVC.selectedBlock = ^(NSString *item) {
            NSLog(@"JASampleSearchController - selectedBlock - item:%@",item);
        };
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sampleSearchVC];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

@end
