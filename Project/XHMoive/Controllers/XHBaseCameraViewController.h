//
//  XHBaseCameraViewController.h
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHItemScrollToolBar.h"

#import "XHEaseTableView.h"
#import "XHFilterItem.h"

typedef NS_ENUM(NSInteger, XHCameraType) {
    kXHSceces = 0,
    kXHFilter,
    kXHElements,
    kXHDialogBox
};

@interface XHBaseCameraViewController : XHBaseViewController
// 各种滤镜
@property (nonatomic, strong) NSArray *filters;
// 各种场景
@property (nonatomic, strong) NSArray *scenes;
// 各种场景分类
@property (nonatomic, strong) NSArray *scenesCategirys;
// 底部按钮
@property (nonatomic, strong) NSArray *items;
// 底部的样式
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemPaddingX;
@property (nonatomic, assign) CGFloat itemPaddingY;
@property (nonatomic, assign) NSInteger selectIndex;

// 选择分栏
@property (nonatomic, strong) XHEaseTableView *easeTableView;

// 状态模式
@property (nonatomic, assign) XHCameraType cameraType;
@property (nonatomic, assign) NSInteger currentSelectFilterIndex;
@property (nonatomic, assign) NSInteger currentSelectScenesIndex;
@property (nonatomic, assign) BOOL isShowContainarView;

- (void)_filterEdting:(NSInteger)index;
- (void)_filterItemSelect:(NSInteger)index;
- (UIImage *)_getImageForIndex:(NSInteger )index;
- (NSString *)_getTextForIndex:(NSInteger)index;
@end
