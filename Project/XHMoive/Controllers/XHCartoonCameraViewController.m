//
//  XHCartoonCameraViewController.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHCartoonCameraViewController.h"

#import "QBImagePickerController.h"

#import "GPUImage.h"

@interface XHCartoonCameraViewController () <QBImagePickerControllerDelegate> {
    GPUImageVideoCamera *videoCamera;
    GPUImageOutput<GPUImageInput> *filter;
    GPUImageView *filterImageView;
    UIImageView *imageView;
}

@end

@implementation XHCartoonCameraViewController

#pragma mark - Action

- (void)_pushLibrarySelectViewController {
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    [self.navigationController presentModalViewController:[[UINavigationController alloc] initWithRootViewController:imagePickerController] animated:YES];
}

- (void)_pushPhotoEditorViewController {
    UIImage *capturePhoto = [filter imageFromCurrentlyProcessedOutput];
    imageView.image = capturePhoto;
    imageView.hidden = NO;
}

- (void)_filterItemSelect:(NSInteger)index {
    NSLog(@"index : %d", index);
    [videoCamera resetBenchmarkAverage];
    [filter removeTarget:filterImageView];
    [videoCamera removeTarget:filter];
    filter = nil;
    filter = [[GPUImageAdaptiveThresholdFilter alloc] init];
    [filter addTarget:filterImageView];
    [videoCamera addTarget:filter];
    [videoCamera prepareForImageCapture];
}

#pragma mark - Setup UI

- (void)_setupVideoCamera {
    CGFloat width = CGRectGetWidth(self.view.bounds);
    filterImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 44, width, width)];
    filterImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    [self.view addSubview:filterImageView];
    imageView = [[UIImageView alloc] initWithFrame:filterImageView.frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    imageView.hidden = YES;
    
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    videoCamera.runBenchmark = YES;
    
    filter = [[GPUImageToonFilter alloc] init];
    [videoCamera addTarget:filter];
    
    [filter addTarget:filterImageView];
}

- (void)_setupItemScrollToolBar {
    if (self.items.count)
        return;
    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:5];
    XHItem *backToRootItem = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"] selectedImage:[UIImage imageNamed:@"tabBar-camera-on"] title:nil itemSelectedBlcok:^(XHItemView *itemView) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
        NSLog(@"index : %d", itemView.item.index);
    }];
    backToRootItem.unHieghtSelect = YES;
    [items addObject:backToRootItem];
    
    XHItem *libraryItem = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"] selectedImage:[UIImage imageNamed:@"tabBar-camera-on"] title:nil itemSelectedBlcok:^(XHItemView *itemView) {
        NSLog(@"index : %d", itemView.item.index);
        [weakSelf _pushLibrarySelectViewController];
    }];
    libraryItem.unHieghtSelect = YES;
    [items addObject:libraryItem];
    
    XHItem *capturePhotoItem = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"] selectedImage:[UIImage imageNamed:@"tabBar-camera-on"] title:nil itemSelectedBlcok:^(XHItemView *itemView) {
        [weakSelf _pushPhotoEditorViewController];
        NSLog(@"index : %d", itemView.item.index);
    }];
    capturePhotoItem.unHieghtSelect = YES;
    [items addObject:capturePhotoItem];
    
    XHItem *scenesItem = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"] selectedImage:[UIImage imageNamed:@"tabBar-camera-on"] title:nil itemSelectedBlcok:^(XHItemView *itemView) {
        NSInteger index = itemView.item.index;
        NSLog(@"index : %d", index);
        [weakSelf _filterEdting:index - 3];
    }];
    [items addObject:scenesItem];
    
    XHItem *filterItem = [[XHItem alloc] initWithNormalImage:[UIImage imageNamed:@"tabBar-camera"] selectedImage:[UIImage imageNamed:@"tabBar-camera-on"] title:@"title5" itemSelectedBlcok:^(XHItemView *itemView) {
        NSInteger index = itemView.item.index;
        NSLog(@"index : %d", index);
        [weakSelf _filterEdting:index - 3];
    }];
    [items addObject:filterItem];
    self.items = items;
}

#pragma mark - Life cycle

- (void)_setup {
    self.selectIndex = 4;
}

- (id)init {
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [videoCamera startCameraCapture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [videoCamera stopCameraCapture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self _setupVideoCamera];
    [self _setupItemScrollToolBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QBImagePickerControllerDelegate

- (void)_dismissImagePickerController
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popToViewController:self animated:YES];
    }
}

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets {
    [self _dismissImagePickerController];
}

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset {
    [self _dismissImagePickerController];
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [self _dismissImagePickerController];
}

@end
