//
//  JASampleSearchController.m
//  UISearchControllerDemo
//
//  Created by Jacob on 2017/5/27.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JASampleSearchController.h"
//vc
#import "JASampleSearchResultController.h"
//view
#import "JADisplayCell.h"
//category
#import "UIImage+Util.h"

@interface JASampleSearchController ()<UITableViewDelegate, UITableViewDataSource, JASampleSearchResultControllerDelegate, UISearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *originalData;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic, strong) JASampleSearchResultController *resultController;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSString *selectedItem;

@end

@implementation JASampleSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的位置";
    [self setUpInit];
    [self setUpSearchController];
    [self setUpTableView];
}

- (void)setUpInit {
    self.originalData = [NSMutableArray array];
    //产生 数字+随机字母字符串
    for (NSInteger i =0; i<50; i++) {
        [self.originalData addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }
}

//产生随机字母字符串
- (NSString *)shuffledAlphabet {
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    
    NSString *strTest = [[NSString alloc] init];
    for (int i=0; i<5; i++) {
        int x = arc4random() % 25;
        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
    }
    return strTest;
}


- (void)setUpSearchController {
    self.resultController = [[JASampleSearchResultController alloc] init];
    self.resultController.orinalData = self.originalData;
    self.resultController.delegate = self;
    //创建UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultController];
    //设置代理
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self.resultController;
    self.searchController.searchBar.tintColor = RGBA(255, 115, 133, 1);
    self.searchController.searchBar.placeholder= @"搜索附近的地方";
    self.searchController.searchBar.backgroundImage = [UIImage ja_imageWithColor:RGBA(240, 240, 240, 1)]; //去掉searchBar上下线黑线
    //    self.searchController.searchBar.barTintColor = RGBA(240, 240, 240, 1);//设置背景色，用上面就不用这个
    
    //UISearchController的显示样式属性，以下默认值都为YES
    //搜索时，背景变暗色
//    self.searchController.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
//    self.searchController.obscuresBackgroundDuringPresentation = NO;
    //搜索时,是否隐藏导航栏
//    self.searchController.hidesNavigationBarDuringPresentation = NO;
    
    //位置
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,JAScreenW ,JAScreenH)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = 61;
    // 添加 searchbar 到 headerview
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview: self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JADisplayCell class]) bundle:nil] forCellReuseIdentifier:JADisplayCellID];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.originalData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JADisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:JADisplayCellID];
    cell.textLabel.text = self.originalData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.selectedBlock) {
                self.selectedBlock(self.originalData[indexPath.row]);
            }
        }];
        
    });
}

#pragma mark - JASampleSearchResultControllerDelegate
- (void)searchResultController:(JASampleSearchResultController *)searchResultController didSelectedItem:(NSString *)item {
    @weakify(self)
    self.searchController.active = NO;
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            @strongify(self);
            if (self.selectedBlock) {
                self.selectedBlock(item);
            }
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
