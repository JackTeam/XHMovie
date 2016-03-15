//
//  XHBaseCameraViewController.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHBaseCameraViewController.h"

@interface XHBaseCameraViewController () <XHEaseTableViewDelegate>
// 适配器
@property (nonatomic, assign) BOOL isiPhone5;
@property (nonatomic, assign) BOOL deviceIsIpad;
@property (nonatomic, assign) CGFloat filterScrollViewHeight;
@property (nonatomic, assign) CGFloat topToolbarViewHeight;

@end

@implementation XHBaseCameraViewController
@synthesize items = _items;

#pragma mark - Action

- (void)_filterItemSelect:(NSInteger)index {
    
}

- (void)_filterEdting:(NSInteger)index {
    XHCameraType currentCameraType = index;
    if (self.cameraType == currentCameraType)
        return;
    self.cameraType = currentCameraType;
    [self.easeTableView reloadData];
}

#pragma mark - Propertys

- (void)setFilters:(NSArray *)filters {
    if (!filters)
        return;
    _filters = filters;
}

- (void)setScenes:(NSArray *)scenes {
    if (!scenes)
        return;
    _scenes = scenes;
}

- (void)setScenesCategirys:(NSArray *)scenesCategirys {
    if (!scenesCategirys)
        return;
    _scenesCategirys = scenesCategirys;
}

- (void)setItems:(NSArray *)items {
    if (!items)
        return;
    _items = items;
    [self _setupBottomToolBar];
}

- (NSArray *)items {
    if (!_items) {
        _items = [[NSArray alloc] init];
    }
    return _items;
}

#pragma mark - UI Setup

- (void)_setupBottomToolBar {
    XHItemScrollToolBar *itemScrollToolBar = [[XHItemScrollToolBar alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - kXHItemScrollToolBarHeight, CGRectGetWidth(self.view.bounds), kXHItemScrollToolBarHeight)];
    itemScrollToolBar.itemWidth = self.itemWidth;
    itemScrollToolBar.itemPaddingX = self.itemPaddingX;
    itemScrollToolBar.itemPaddingY = self.itemPaddingY;
    itemScrollToolBar.items = self.items;
    itemScrollToolBar.selectIndex = self.selectIndex;
    [self.view addSubview:itemScrollToolBar];
    
    [itemScrollToolBar reloadData];
}

- (void)_setupFilterHorizontalTableView {
    CGRect frameRect = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds), self.filterScrollViewHeight);
    _easeTableView = [[XHEaseTableView alloc] initWithFrame:frameRect numberOfColumns:14 ofWidth:60];
	_easeTableView.delegate = self;
	_easeTableView.tableView.backgroundColor = [UIColor clearColor];
	_easeTableView.tableView.separatorColor = [UIColor clearColor];
    _easeTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_easeTableView.cellBackgroundColor = [UIColor blackColor];
    _easeTableView.defaultSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.view addSubview:self.easeTableView];
}

#pragma mark - Animation

- (void)_showEaseTableView:(BOOL)isShow {
    self.isShowContainarView = isShow;
    CGRect containarViewFrame = self.easeTableView.frame;
    if (isShow) {
        containarViewFrame.origin.y -= self.filterScrollViewHeight + kXHItemScrollToolBarHeight;
    } else {
        containarViewFrame.origin.y += self.filterScrollViewHeight + kXHItemScrollToolBarHeight;
    }
    [UIView animateWithDuration:0.37 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.easeTableView.frame = containarViewFrame;
    } completion:^(BOOL finished) {
        if (isShow) {
            [self.easeTableView reloadData];
        }
    }];
}

#pragma mark - Life cycle

- (void)_setupBase {
    self.itemWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 5.0;
    self.cameraType = kXHFilter;
    
    self.isiPhone5 = [UIDevice de_isiPhone5];
    self.deviceIsIpad = [UIDevice de_isPad];
    // 这里判断需要换为iPhone5 4的判断
    if (self.isiPhone5) {
        self.filterScrollViewHeight = 100;
        self.topToolbarViewHeight = 80;
    } else {
        self.filterScrollViewHeight = 60;
        if (self.deviceIsIpad) {
            self.topToolbarViewHeight = 100;
        } else {
            self.topToolbarViewHeight = 50;
        }
    }
}

- (id)init {
    self = [super init];
    if (self) {
        [self _setupBase];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.isShowContainarView)
        [self _showEaseTableView:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self _setupFilterHorizontalTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - help method

- (UIImage *)_getImageForIndex:(NSInteger )index {
    NSString *imageName = nil;
    UIImage *filterImage = nil;
    switch (self.cameraType) {
        case kXHSceces: {
            imageName = [NSString stringWithFormat:@"Sceces%d", index];
            break;
        }
        case kXHFilter: {
            imageName = [NSString stringWithFormat:@"Filter%d", index];
            break;
        }
        default:
            break;
    }
    filterImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
    return filterImage;
}

- (NSString *)_getTextForIndex:(NSInteger)index {
    switch (self.cameraType) {
        case kXHSceces:
            return @"漫画场景";
            break;
        case kXHFilter:
            return @"漫画滤镜";
            break;
        case kXHElements:
            return nil;
            break;
        case kXHDialogBox:
            return nil;
            break;
        default:
            break;
    }
}

#pragma mark - border help method

- (void)borderIsSelected:(BOOL)selected forView:(XHFilterItem *)filterItem {
	NSString *borderImageName	= (selected) ? @"selected_border.png" : @"image_border.png";
	filterItem.borderImageView.image			= [UIImage imageNamed:borderImageName];
}

#pragma mark - XHEaseTableViewDelegate

- (UIView *)easyTableView:(XHEaseTableView *)easyTableView viewForRect:(CGRect)rect {
    XHFilterItem *filterItem = [[XHFilterItem alloc] initWithFrame:rect];
	
	return filterItem;
}

- (void)easyTableView:(XHEaseTableView *)easyTableView setDataForView:(UIView *)view forIndexPath:(NSIndexPath*)indexPath {
    NSInteger index = indexPath.row;
    XHFilterItem *filterItem = (XHFilterItem *)view;
    
    filterItem.itemImageView.image = [self _getImageForIndex:index];
    
    filterItem.itemLabel.text = [self _getTextForIndex:index];
    
    // selectedIndexPath can be nil so we need to test for that condition
    BOOL isSelected = (easyTableView.selectedIndexPath) ? ([easyTableView.selectedIndexPath compare:indexPath] == NSOrderedSame) : NO;
    [self borderIsSelected:isSelected forView:filterItem];
}

- (void)easyTableView:(XHEaseTableView *)easyTableView selectedView:(UIView *)selectedView atIndexPath:(NSIndexPath *)indexPath deselectedView:(UIView *)deselectedView {
    NSInteger select = indexPath.row;
    switch (self.cameraType) {
        case kXHSceces: {
            if (select == self.currentSelectScenesIndex)
                return;
            
            self.currentSelectScenesIndex = select;
            [self _filterItemSelect:self.currentSelectScenesIndex];
            break;
        }
        case kXHFilter: {
            if (select == self.currentSelectFilterIndex)
                return;
            
            self.currentSelectFilterIndex = select;
            [self _filterItemSelect:self.currentSelectFilterIndex];
            break;
        }
        default:
            break;
    }
    [self borderIsSelected:YES forView:(XHFilterItem *)selectedView];
	
	if (deselectedView)
		[self borderIsSelected:NO forView:(XHFilterItem *)deselectedView];
}

@end
