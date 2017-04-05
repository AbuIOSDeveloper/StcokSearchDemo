//
//  AbuSearchViewCell.m
//  阿布搜索Demo
//
//  Created by 阿布 on 17/3/15.
//  Copyright © 2017年 阿布. All rights reserved.
//

#import "AbuSearchViewCell.h"
#import "AbuStcokModel.h"


@implementation AbuSearchViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.code];
    [self.contentView addSubview:self.market];
    [self.contentView addSubview:self.lineView];
}

- (void)setModel:(AbuStcokModel *)model
{
    _model = model;
    self.code.text = model.code;
    if (nil != model.cnName && ![model.cnName isEqualToString:@""])
    {
        self.name.text = model.cnName;
    }
    else
    {
        self.name.text = model.enName;
    }
    if ([model.code rangeOfString:@"HK"].location != NSNotFound) {
        self.market.layer.backgroundColor = [UIColor redColor].CGColor;
        self.market.text = @"HK";
    }
    else
    {
        self.market.layer.backgroundColor = [UIColor blueColor].CGColor;
        self.market.text = @"US";
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    HS_WeakSelf(weakSelf);
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.top.equalTo(weakSelf.contentView).offset(5);
        make.height.mas_offset(17);
        make.width.equalTo(weakSelf.contentView).offset(-15);
    }];
    [self.market mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.name.mas_left);
        make.top.equalTo(weakSelf.name.mas_bottom).offset(6);
        make.width.mas_offset(20);
        make.height.mas_offset(14);
    }];
    [self.code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.market.mas_right).offset(4);
        make.top.equalTo(weakSelf.market);
        make.height.mas_offset(13);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(15);
        make.right.equalTo(weakSelf.contentView).offset(-15);
        make.bottom.equalTo(weakSelf.contentView);
        make.height.mas_offset(0.5);
    }];
}

- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel new];
        _name.font = [UIFont systemFontOfSize:17];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.textColor = [UIColor blackColor];
    }
    return _name;
}

- (UILabel *)code
{
    if (!_code) {
        _code = [UILabel new];
        _code.font = [UIFont systemFontOfSize:13];
        _code.textAlignment = NSTextAlignmentLeft;
        _code.textColor = [UIColor grayColor];
    }
    return _code;
}

- (UILabel *)market
{
    if (!_market) {
        _market = [UILabel new];
        _market.font = [UIFont systemFontOfSize:13];
        _market.textColor = [UIColor whiteColor];
        _market.textAlignment = NSTextAlignmentCenter;
        _market.layer.cornerRadius = 2;
        _market.clipsToBounds = YES;
    }
    return _market;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
