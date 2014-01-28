//
//  XHRootViewController.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHRootViewController.h"

typedef NS_ENUM(NSInteger, XHCartoonType) {
    kXHCartoonCamera = 1,
    kXHGridPuzzle,
    kXHCartoonVideo,
};

@interface XHRootViewController ()

@property (nonatomic, assign) XHCartoonType cartoonType;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *appNameImageView;

@property (nonatomic, strong) UIView *containarView;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *gridButton;
@property (nonatomic, strong) UIButton *videoButton;

@property (nonatomic, strong) UIImageView *reservedImageView;
@end

@implementation XHRootViewController

#pragma mark - previte method

#pragma mark - navigate Controller

- (void)_pushNewViewController:(UIButton *)sender {
    UIViewController *newViewController = nil;
    
    XHCartoonType currentCartoonType = sender.tag;
    switch (currentCartoonType) {
        case kXHCartoonCamera:
            newViewController = [[NSClassFromString(@"XHCartoonCameraViewController") alloc] init];
            break;
        case kXHGridPuzzle:
            newViewController = [[NSClassFromString(@"XHGridPuzzleViewController") alloc] init];
            break;
        case kXHCartoonVideo:
            newViewController = [[NSClassFromString(@"XHCartoonVideoViewController") alloc] init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:newViewController animated:YES];
    newViewController = nil;
}

#pragma mark - UI

- (void)_enableButtons:(BOOL)isEnable {
    for (UIButton *button in self.containarView.subviews) {
        [button setUserInteractionEnabled:isEnable];
    }
}

- (void)_animationUI {
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        // 弹跳出现
    } completion:^(BOOL finished) {
        // 在这里就开始允许按钮被点击了
        [self _enableButtons:YES];
    }];
}

- (void)_setupUI {
    CGPoint viewCenter = CGPointMake(CGRectGetWidth(self.view.bounds) / 2.0, CGRectGetHeight(self.view.bounds) / 2.0);
    CGFloat sepatorScale = 0;
    if ([UIDevice de_isiPhone5]) {
        sepatorScale = 1.7;
    } else {
        if ([UIDevice de_isPad]) {
            sepatorScale = 3.2;
        } else {
            sepatorScale = 1.35;
        }
    }
    
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MenuBackground"]];
    [self _setupViewFrame:self.view.bounds inView:_backgroundImageView];
    [self.view addSubview:self.backgroundImageView];
    
    _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meicon.png"]];
    CGFloat iconImageViewSize = 130;
    CGRect iconImageViewFrame = CGRectMake(viewCenter.x - iconImageViewSize / 2.0, viewCenter.y - iconImageViewSize * sepatorScale, iconImageViewSize, iconImageViewSize);
    [self _setupViewFrame:iconImageViewFrame inView:_iconImageView];
    [self.view addSubview:self.iconImageView];
    
    _appNameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meicon.png"]];
    CGSize appNameImageViewSize = CGSizeMake(iconImageViewSize * 0.75, iconImageViewSize * 0.3);
    CGRect appNameImageViewFrame = CGRectMake(viewCenter.x - appNameImageViewSize.width / 2.0, CGRectGetMaxY(_iconImageView.frame) + 10, appNameImageViewSize.width, appNameImageViewSize.height);
    [self _setupViewFrame:appNameImageViewFrame inView:_appNameImageView];
    [self.view addSubview:self.appNameImageView];
    
    
    
    
    CGFloat containarViewHeight = 0;
    CGSize buttonSize;
    CGFloat paddingBetwwenWithAppNameImageViewAndContainarView = 0;
    if ([UIDevice de_isiPhone5]) {
        containarViewHeight = 200;
        buttonSize = CGSizeMake(200, 45);
        paddingBetwwenWithAppNameImageViewAndContainarView = 70;
    } else {
        if ([UIDevice de_isPad]) {
            containarViewHeight = 400;
            buttonSize = CGSizeMake(220, 65);
            paddingBetwwenWithAppNameImageViewAndContainarView = 200;
        } else {
            containarViewHeight = 140;
            buttonSize = CGSizeMake(200, 35);
            paddingBetwwenWithAppNameImageViewAndContainarView = 38;
        }
    }
    
    _containarView = [[UIView alloc] initWithFrame:CGRectZero];
    _containarView.alpha = 1.;
    CGRect containarViewFrame = CGRectMake(viewCenter.x - buttonSize.width / 2.0,  CGRectGetMaxY(appNameImageViewFrame) + paddingBetwwenWithAppNameImageViewAndContainarView, buttonSize.width, containarViewHeight);
    [self _setupViewFrame:containarViewFrame inView:_containarView];
    
    
    self.cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect cameraButtonFrame = CGRectMake(0, 0, buttonSize.width, buttonSize.height);
    [self _setupViewFrame:cameraButtonFrame inView:_cameraButton];
    [_cameraButton addTarget:self action:@selector(_pushNewViewController:) forControlEvents:UIControlEventTouchUpInside];
    _cameraButton.tag = kXHCartoonCamera;
    [_cameraButton setImage:[UIImage imageNamed:@"meicon.png"] imagePosition:kXHHorizontalDirection withTitle:NSLocalizedString(@"相机", @"相机") forState:UIControlStateNormal];
    [_cameraButton setBackgroundImage:[UIImage imageNamed:@"MenuBackground"] forState:UIControlStateNormal];
    
    
    self.gridButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect gridButtonFrame = CGRectMake(0, CGRectGetMaxY(_cameraButton.frame) + 15, buttonSize.width, buttonSize.height);
    [self _setupViewFrame:gridButtonFrame inView:_gridButton];
    [_gridButton addTarget:self action:@selector(_pushNewViewController:) forControlEvents:UIControlEventTouchUpInside];
    _gridButton.tag = kXHGridPuzzle;
    [_gridButton setImage:[UIImage imageNamed:@"meicon.png"] imagePosition:kXHHorizontalDirection withTitle:NSLocalizedString(@"微电影", @"微电影") forState:UIControlStateNormal];
    [_gridButton setBackgroundImage:[UIImage imageNamed:@"MenuBackground"] forState:UIControlStateNormal];
    
    self.videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect videoButtonFrame = CGRectMake(0, CGRectGetMaxY(_gridButton.frame) + 15, buttonSize.width, buttonSize.height);
    [self _setupViewFrame:videoButtonFrame inView:_videoButton];
    [_videoButton addTarget:self action:@selector(_pushNewViewController:) forControlEvents:UIControlEventTouchUpInside];
    _videoButton.tag = kXHCartoonVideo;
    [_videoButton setImage:[UIImage imageNamed:@"meicon.png"] imagePosition:kXHHorizontalDirection withTitle:NSLocalizedString(@"四格图纸", @"四格图纸") forState:UIControlStateNormal];
    [_videoButton setBackgroundImage:[UIImage imageNamed:@"MenuBackground"] forState:UIControlStateNormal];
    
    [_containarView addSubview:self.cameraButton];
    [_containarView addSubview:self.gridButton];
    [_containarView addSubview:self.videoButton];
    
    [self _enableButtons:NO];
    
    [self.view addSubview:self.containarView];
    
    _reservedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meicon.png"]];
    CGSize reservedImageViewSize = CGSizeMake(iconImageViewSize * 0.9, iconImageViewSize * 0.15);
    CGRect reservedImageViewFrame = CGRectMake(viewCenter.x - reservedImageViewSize.width / 2.0, CGRectGetMaxY(self.view.bounds) - reservedImageViewSize.height - reservedImageViewSize.height * 0.3, reservedImageViewSize.width, reservedImageViewSize.height);
    [self _setupViewFrame:reservedImageViewFrame inView:_reservedImageView];
    [self.view addSubview:self.reservedImageView];
}

- (void)_setupViewFrame:(CGRect)frame inView:(UIView *)inView {
    inView.frame = frame;
}

#pragma mark - Life cycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _animationUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self _setupUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.iconImageView = nil;
    
    self.appNameImageView = nil;
    
    self.cameraButton = nil;
    self.gridButton = nil;
    self.videoButton = nil;
    self.containarView = nil;
    
    self.reservedImageView = nil;
}

@end
