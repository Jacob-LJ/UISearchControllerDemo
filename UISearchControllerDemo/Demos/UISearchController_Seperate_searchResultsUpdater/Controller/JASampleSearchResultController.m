//
//  JASampleSearchResultController.m
//  UISearchControllerDemo
//
//  Created by Jacob on 2017/5/27.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JASampleSearchResultController.h"
//view
#import "JADisplayCell.h"

@interface JASampleSearchResultController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UISearchController *searchController;
@property (nonatomic, copy) NSString *searchWord;

@property (nonatomic, strong) NSMutableArray *resultData;

@end

@implementation JASampleSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    [self setUpTableView];
    
}

- (void)setUpInit {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    self.resultData = [NSMutableArray array];
}

- (void)setUpTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    _tableView = tableView;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    tableView.rowHeight = 61;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JADisplayCell class]) bundle:nil] forCellReuseIdentifier:JADisplayCellID];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.resultData.count) {
        self.view.backgroundColor = [UIColor whiteColor];
    } else {
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self.resultData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JADisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:JADisplayCellID];
    cell.textLabel.text = self.resultData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(searchResultController:didSelectedItem:)]) {
        [self.delegate searchResultController:self didSelectedItem:self.resultData[indexPath.row]];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchController.searchBar endEditing:YES];
}

//谓词搜索过滤
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"updateSearchResultsForSearchController");
    if (!self.searchController) {
        self.searchController = searchController;
    }
    
    NSString *searchWord = searchController.searchBar.text;
    self.searchWord = searchWord;
    [self.resultData removeAllObjects];
    
    if (!searchWord.length) {
        [self.tableView reloadData];
    } else {
        [self searchByWord:searchWord];
    }
    
}


- (void)searchByWord:(NSString *)searchWord {
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchWord];
    //过滤数据
    self.resultData = [NSMutableArray arrayWithArray:[self.orinalData filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
