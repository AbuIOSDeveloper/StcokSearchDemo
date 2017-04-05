//
//  AbuSearchView.m
//  SearchDemo
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 阿布. All rights reserved.
//

#import "AbuSearchView.h"

@interface AbuSearchView()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, strong) UIImageView * iconView;

@property (nonatomic, strong) UIImageView * iconCenterView;

@property (nonatomic, assign) AbuSearchBarIconAlign iconAlignTemp;

/**
 * 股票数据
 */
@property (nonatomic, strong) NSMutableArray   * stcokArray;

/**
 * 匹配结果数据
 */
@property (nonatomic, retain) NSMutableArray   * resultArr;

@end

@implementation AbuSearchView

- (instancetype)init
{
    self = [super init];
    if (self) {
       [self setUI];
       [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        [self initData];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
        
    }
}

- (void)setUI{
    
    [self addSubview:self.textField];
    [self addSubview:self.cancelButton];
    self.cancelButton.hidden = YES;
    self.textField.layer.cornerRadius = 6;
    self.textField.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)initData
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.stcokArray = [AbuStcokList getStcokData];
    });
}



- (void)setIconAlign:(AbuSearchBarIconAlign)iconAlign
{
    if (!_iconAlignTemp) {
        _iconAlignTemp = iconAlign;
    }
    _iconAlign = iconAlign;
    [self ajustIconWith:iconAlign];
}

-(void)ajustIconWith:(AbuSearchBarIconAlign)iconAlign{
    if (_iconAlign == SearchBarIconAlignCenter) { //是否居中
        _iconCenterView.hidden = NO;
        
        self.textField.frame = CGRectMake(7, 7, self.frame.size.width-7*2, 30);
        self.textField.textAlignment = NSTextAlignmentCenter;
        
        CGSize titleSize;
        if (!self.text || ![self.text isEqualToString:@""]) {
            titleSize =  [self.text sizeWithAttributes: @{NSFontAttributeName:self.textField.font}];
        }else{
            titleSize =  [self.placeholder?:@"" sizeWithAttributes: @{NSFontAttributeName:_textField.font}];
            
        }
        
        CGFloat x = self.textField.frame.size.width/2 - titleSize.width/2-25;
        if (!_iconCenterView) {
            _iconCenterView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Search"]];
            _iconCenterView.contentMode = UIViewContentModeScaleAspectFit;
            [self.textField addSubview:_iconCenterView];
        }
        if (x > 0) {
            _iconCenterView.frame = CGRectMake(x, 0, _iconCenterView.frame.size.width, _iconCenterView.frame.size.height);
            self.textField.leftView = nil;
        }else{
            _iconCenterView.hidden = YES;
            self.textField.leftView = _iconView;
        }
        
    }
    else
    {
        _iconCenterView.hidden = YES;
        
        [UIView animateWithDuration:1 animations:^{
            self.textField.textAlignment = NSTextAlignmentLeft;
            _iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Search"]];
            _iconView.contentMode = UIViewContentModeScaleAspectFit;
            self.textField.leftView = _iconView;
            self.textField.leftViewMode =  UITextFieldViewModeAlways;
        }];
    }
}

-(NSString *)text
{
    return _textField.text;
}

-(void)setText:(NSString *)text
{
    _textField.text = text?:@"";
}

/**
 * 设置字体大小
 */
-(void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    [_textField setFont:_textFont];
}

/**
 * 设置边框样式
 */
-(void)setTextBorderStyle:(UITextBorderStyle)textBorderStyle{
    _textBorderStyle = textBorderStyle;
    _textField.borderStyle = textBorderStyle;
}

/**
 * 设置textColor
 */
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [_textField setTextColor:_textColor];
}

/**
 * 设置iconImage
 */
-(void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    ((UIImageView*)_textField.leftView).image = _iconImage;
}

/**
 * 设置placeholder
 */
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
    [self setIconAlign:_iconAlign];
}

/**
 * 设置背景图片
 */
-(void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    
}

/**
 * 设置TextFiled的键盘样式
 */
-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    _textField.keyboardType = _keyboardType;
}

/**
 * 设置TextFiled的inputView
 */
-(void)setInputView:(UIView *)inputView{
    _inputView = inputView;
    _textField.inputView = _inputView;
}

/**
 * 设置TextFiled的inputAccessoryView
 */
-(void)setInputAccessoryView:(UIView *)inputAccessoryView{
    _inputAccessoryView = inputAccessoryView;
    _textField.inputAccessoryView = _inputAccessoryView;
}

/**
 * 设置placeholderColor
 */
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    NSAssert(_placeholder, @"Please set placeholder before setting placeholdercolor");
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 6)
    {
        [_textField setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    else
    {
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
    }
}

/**
 * 响应事件
 */
-(BOOL)resignFirstResponder
{
    return [_textField resignFirstResponder];
}

/**
 * 取消按钮
 */
-(void)cancelButtonTouched
{
    _textField.text = @"";
    [_textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)])
    {
        [self.delegate searchBarCancelButtonClicked:self];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:@""];
    }
}

/**
 * 样式
 */
-(void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type
{
    _textField.autocapitalizationType = type;
}
#pragma --mark textfield delegate
/**
 * textField应该输入时调用
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(_iconAlignTemp == SearchBarIconAlignCenter){
        self.iconAlign = SearchBarIconAlignLeft;
    }
    [UIView animateWithDuration:0.1 animations:^{
        _cancelButton.hidden = NO;
        _textField.frame = CGRectMake(7, 7, _cancelButton.frame.origin.x-7, 30);
        //        _textField.transform = CGAffineTransformMakeTranslation(-_cancelButton.frame.size.width,0);
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)])
    {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}

/**
 * textField开始输入时调用
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
    {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

/**
 * textField应该结束时输入时调用
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)])
    {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}

/**
 * textField结束输入时调用
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(_iconAlignTemp == SearchBarIconAlignCenter){
        self.iconAlign = SearchBarIconAlignCenter;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        _cancelButton.hidden = YES;
        _textField.frame = CGRectMake(7, 7, self.frame.size.width-7*2, 30);
        //        _textField.transform = CGAffineTransformMakeTranslation(-_cancelButton.frame.size.width,0);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
    {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

/**
 * 监听textField值的变化
 */
-(void)textFieldDidChange:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:textField.text];
    }
    NSString * stringValue = textField.text;
    if (stringValue.length > 0) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            if (self.resultArr) {
                [self.resultArr removeAllObjects];
            }
            NSInteger iEqual = 0;//全匹配
            for (AbuStcokModel * model in self.stcokArray) {
                BOOL isSure = [self searchEqualToString:model.cnName string:stringValue] ||
                [self searchEqualToString:model.cnSpellAbbr string:stringValue] ||
                [self searchEqualToString:model.cnSpell string:stringValue] ||
                [self searchEqualToString:model.code string:stringValue] ||
                [self searchEqualToString:model.dataType string:stringValue] ||
                [self searchEqualToString:model.ftName string:stringValue] ||
                [self searchEqualToString:model.enName string:stringValue];
                if (isSure) {
                    if ([self.resultArr containsObject:model]) {
                        continue;
                    } else {
                        [self.resultArr insertObject:model atIndex:iEqual];
                        ++iEqual;
                    }
                }
                else
                {
                    NSString * searchString = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",model.cnName,model.cnSpellAbbr,model.cnSpell,model.code,model.dataType,model.ftName,model.enName];
                    if ([searchString rangeOfString:stringValue].location != NSNotFound) {
                        
                        [self.resultArr addObject:model];
                    }
                }
            }
            if (self.resultArr.count > 0) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:resultStcokList:)]) {
                    [self.delegate searchView:self resultStcokList:self.resultArr];
                }
            }
           
           
        });
    }
    else
    {
        if (self.resultArr.count) {
            [self.resultArr removeAllObjects];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:resultStcokList:)]) {
            [self.delegate searchView:self resultStcokList:self.resultArr];
        }
    }
}

//股票搜索全匹配比较函数
- (BOOL) searchEqualToString:(NSString*) text string:(NSString*) searchString {
    NSString *searchText = [text lowercaseString];
    NSString *searchStr = [searchString lowercaseString];
    BOOL b = NO;
    
    if (nil != searchText && ![searchText isEqualToString:@""] &&
        nil != searchStr && ![searchStr isEqualToString:@""])
        b = [searchText isEqualToString:searchStr];
    return b;
}

/**
 * 改变值
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)])
    {
        return [self.delegate searchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

/**
 * 清空textField的值
 */
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:@""];
    }
    return YES;
}

/**
 * 应该返回textField的值
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
    {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}

#pragma Mark - 懒加载
- (NSMutableArray *)stcokArray
{
    if (!_stcokArray) {
        _stcokArray = [NSMutableArray array];
    }
    return _stcokArray;
}

- (NSMutableArray *)resultArr
{
    if (!_resultArr) {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _cancelButton.frame = CGRectMake(self.frame.size.width-60, 7, 60, 30);
        [_cancelButton addTarget:self
                          action:@selector(cancelButtonTouched)
                forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
    return _cancelButton;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(7, 7, self.frame.size.width-7*2, 30)];
        _textField.delegate = self;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.enablesReturnKeyAutomatically = YES;
        _textField.font = [UIFont systemFontOfSize:14.0f];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self
                       action:@selector(textFieldDidChange:)
             forControlEvents:UIControlEventEditingChanged];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //for dspa
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.layer.cornerRadius = 3.0f;
        _textField.layer.masksToBounds = YES;
        _textField.layer.borderColor = [[UIColor colorWithWhite:0.783 alpha:1.000] CGColor];
        _textField.layer.borderWidth = 0.5f;
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}

@end
