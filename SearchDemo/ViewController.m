//
//  ViewController.m
//  SearchDemo
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 阿布. All rights reserved.
//

#import "ViewController.h"
#import "AbuSearchView.h"
@interface ViewController ()<AbuSearchViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AbuSearchView * searchView;
/**
 * tableView
 */
@property (nonatomic, strong) UITableView    * tableView;

/**
 * 数据源
 */
@property (nonatomic, strong) NSMutableArray * data;

@end

@implementation ViewController

static NSString * ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.tableView];
    HS_WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.navigationController.navigationBar addSubview:self.searchView];
}

- (void)searchView:(AbuSearchView *)searchView resultStcokList:(NSMutableArray *)stcokList
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (self.data.count) {
            [self.data removeAllObjects];
        }
        if (stcokList.count > 0) {
            
            [self.data addObjectsFromArray:stcokList];
        }
        else
        {
            [self.data addObjectsFromArray:stcokList];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)searchBarShouldBeginEditing:(AbuSearchView *)searchBar{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
    
}
- (void)searchBarTextDidBeginEditing:(AbuSearchView *)searchBar{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (BOOL)searchBarShouldEndEditing:(AbuSearchView *)searchBar{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
}
- (void)searchBarTextDidEndEditing:(AbuSearchView *)searchBar{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBar:(AbuSearchView *)searchBar textDidChange:(NSString *)searchText{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    NSLog(@"%@",searchText);
    
}
- (BOOL)searchBar:(AbuSearchView *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    return YES;
    
}
- (void)searchBarSearchButtonClicked:(AbuSearchView *)searchBar{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    
}
- (void)searchBarCancelButtonClicked:(AbuSearchView *)searchBar{
//    NSLog(@"%s: Line-%d", __func__, __LINE__);
    if (self.data.count > 0) {
        [self.data removeAllObjects];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.data.count > 0) {
        return self.data.count > 50 ? 50 : self.data.count;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AbuSearchViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AbuSearchViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row < self.data.count) {
        cell.model = self.data[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.data.count > 0) {
        return 44;
    }
    else
    {
        return 0;
    }
}


#pragma mark - 懒加载
- (AbuSearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[AbuSearchView alloc]initWithFrame:CGRectMake(0, 3, self.view.frame.size.width, 30)];
        _searchView.delegate = self;
        _searchView.placeholder = @"股票名称/代码/全拼";
    }
    return _searchView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[AbuSearchViewCell class] forCellReuseIdentifier:ID];
    }
    return _tableView;
}

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
