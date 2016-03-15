//
//  XHEaseTableView.h
//  iyilunba
//
//  Created by 曾 宪华 on 13-11-22.
//  Copyright (c) 2013年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	EasyTableViewOrientationVertical,
	EasyTableViewOrientationHorizontal
} EasyTableViewOrientation;

@class XHEaseTableView;

@protocol XHEaseTableViewDelegate <NSObject>
- (UIView *)easyTableView:(XHEaseTableView *)easyTableView viewForRect:(CGRect)rect;
- (void)easyTableView:(XHEaseTableView *)easyTableView setDataForView:(UIView *)view forIndexPath:(NSIndexPath*)indexPath;
@optional
- (void)easyTableView:(XHEaseTableView *)easyTableView selectedView:(UIView *)selectedView atIndexPath:(NSIndexPath *)indexPath deselectedView:(UIView *)deselectedView;
- (void)easyTableView:(XHEaseTableView *)easyTableView scrolledToOffset:(CGPoint)contentOffset;
- (void)easyTableView:(XHEaseTableView *)easyTableView scrolledToFraction:(CGFloat)fraction;
- (NSUInteger)numberOfSectionsInEasyTableView:(XHEaseTableView*)easyTableView;
- (NSUInteger)numberOfCellsForEasyTableView:(XHEaseTableView *)view inSection:(NSInteger)section;
- (UIView*)easyTableView:(XHEaseTableView*)easyTableView viewForHeaderInSection:(NSInteger)section;
- (UIView*)easyTableView:(XHEaseTableView*)easyTableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)easyTableView:(XHEaseTableView *)easyTableView heightOrWidthForCellAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface XHEaseTableView : UIView <UITableViewDelegate, UITableViewDataSource> {
@private
	CGFloat		_cellWidthOrHeight;
	NSUInteger	_numItems;
}

@property (nonatomic, unsafe_unretained) id<XHEaseTableViewDelegate> delegate;
@property (nonatomic, readonly, unsafe_unretained) UITableView *tableView;
@property (nonatomic, readonly, unsafe_unretained) NSArray *visibleViews;
@property (nonatomic) NSIndexPath *selectedIndexPath;
@property (nonatomic) NSIndexPath *defaultSelectedIndexPath; // 默认为nil
@property (nonatomic) UIColor *cellBackgroundColor;
@property (nonatomic, readonly) EasyTableViewOrientation orientation;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) NSUInteger numberOfCells;

- (id)initWithFrame:(CGRect)frame numberOfColumns:(NSUInteger)numCells ofWidth:(CGFloat)cellWidth;
- (id)initWithFrame:(CGRect)frame numberOfRows:(NSUInteger)numCells ofHeight:(CGFloat)cellHeight;
- (CGPoint)offsetForView:(UIView *)cell;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (void)setScrollFraction:(CGFloat)fraction animated:(BOOL)animated;
- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
- (UIView *)viewAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath*)indexPathForView:(UIView *)cell;
- (void)reloadData;

@end