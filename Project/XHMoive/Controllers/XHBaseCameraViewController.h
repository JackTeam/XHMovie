//
//  XHBaseCameraViewController.h
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
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
