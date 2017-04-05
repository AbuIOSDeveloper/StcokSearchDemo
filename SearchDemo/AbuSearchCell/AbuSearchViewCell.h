//
//  AbuSearchViewCell.h
//  阿布搜索Demo
//
//  Created by 阿布 on 17/3/15.
//  Copyright © 2017年 阿布. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AbuStcokModel;

@interface AbuSearchViewCell : UITableViewCell

/**
 * 股票名称
 */
@property (nonatomic, strong) UILabel       * name;

/**
 * 股票code
 */
@property (nonatomic, strong) UILabel       * code;

/**
 * 股票市场
 */
@property (nonatomic, strong) UILabel       * market;
/**
 * 分割线
 */
@property (nonatomic, strong) UIView        * lineView;

/**
 * 模型
 */
@property (nonatomic, strong) AbuStcokModel * model;
@end
