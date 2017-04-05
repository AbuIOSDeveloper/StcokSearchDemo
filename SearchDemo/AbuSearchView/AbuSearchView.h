//
//  AbuSearchView.h
//  SearchDemo
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 阿布. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AbuSearchBarIconAlign) {
    SearchBarIconAlignLeft,
    SearchBarIconAlignCenter
};

@class AbuSearchView;
@protocol AbuSearchViewDelegate <UIBarPositioningDelegate>

@optional

-(BOOL)searchBarShouldBeginEditing:(AbuSearchView *)searchBar;                      
- (void)searchBarTextDidBeginEditing:(AbuSearchView *)searchBar;
- (BOOL)searchBarShouldEndEditing:(AbuSearchView *)searchBar;
- (void)searchBarTextDidEndEditing:(AbuSearchView *)searchBar;
- (void)searchBar:(AbuSearchView *)searchBar textDidChange:(NSString *)searchText;
/**
 * 匹配数据回调
 */
- (void)searchView:(AbuSearchView *)searchView resultStcokList:(NSMutableArray *)stcokList;
- (BOOL)searchBar:(AbuSearchView *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)searchBarSearchButtonClicked:(AbuSearchView *)searchBar;
- (void)searchBarCancelButtonClicked:(AbuSearchView *)searchBar;

@end

@interface AbuSearchView : UIView
@property(nonatomic,copy)   NSString              * text;

@property(nonatomic,retain) UIColor               * textColor;

@property(nonatomic,retain) UIFont                * textFont;

@property(nonatomic,copy)   NSString              * placeholder;

@property(nonatomic,retain) UIColor               * placeholderColor;

@property(nonatomic,retain) UIImage               * iconImage;

@property(nonatomic,retain) UIImage               * backgroundImage;

@property(nonatomic,retain) UIButton              * cancelButton; //lazy


@property(nonatomic,assign) UITextBorderStyle       textBorderStyle;

@property(nonatomic)        UIKeyboardType          keyboardType;

@property(nonatomic)        AbuSearchBarIconAlign   iconAlign;     //text aligh model


@property (nonatomic, readwrite, retain) UIView   * inputAccessoryView;

@property (nonatomic, readwrite, retain) UIView   * inputView;

@property (nonatomic, weak) id<AbuSearchViewDelegate> delegate;

-(BOOL)resignFirstResponder;

-(void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type;

@end
