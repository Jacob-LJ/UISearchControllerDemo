//
//  JASampleSearchResultController.h
//  UISearchControllerDemo
//
//  Created by Jacob on 2017/5/27.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "JABaseViewController.h"
@class JASampleSearchResultController;

@protocol JASampleSearchResultControllerDelegate <NSObject>

@required
- (void)searchResultController:(JASampleSearchResultController *)searchResultController didSelectedItem:(NSString *)item;

@end

@interface JASampleSearchResultController : JABaseViewController<UISearchResultsUpdating>

@property (nonatomic, copy) NSMutableArray *orinalData;
@property (nonatomic, weak) id<JASampleSearchResultControllerDelegate> delegate;

@end
