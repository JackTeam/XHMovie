//
//  XHFilterItem.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHFilterItem.h"
#import "UIDevice+XHDevices.h"

#define kItemLabelHeight 10

@implementation XHFilterItem

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        BOOL isiPhone5 = [UIDevice de_isiPhone5];
        
        CGFloat padding = 3.8;
        CGRect itemImageViewFrame;
        if (isiPhone5) {
            itemImageViewFrame = CGRectMake(padding, padding, CGRectGetWidth(self.bounds) - padding * 2, CGRectGetWidth(self.bounds) - padding * 2);
        } else {
            itemImageViewFrame = CGRectMake(padding, padding, CGRectGetWidth(self.bounds) - padding * 2, CGRectGetHeight(self.bounds) - padding * 2);
        }
        
        _itemImageView = [[UIImageView alloc] initWithFrame:itemImageViewFrame];
        _itemImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        CGRect itemLabelFrame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), kItemLabelHeight);
        
        // 这里判断需要换为iPhone5 4的判断
        if (isiPhone5) {
            itemLabelFrame.origin.y -= kItemLabelHeight * 3;
        } else {
            itemLabelFrame.origin.y -= kItemLabelHeight * 1.4;
        }
        
        _itemLabel = [[UILabel alloc] initWithFrame:itemLabelFrame];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        _itemLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        _itemLabel.textColor = [UIColor whiteColor];
        _itemLabel.backgroundColor = [UIColor clearColor];
        
        _borderImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _borderImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self addSubview:self.itemImageView];
        [self addSubview:self.itemLabel];
        [self addSubview:self.borderImageView];
    }
    return self;
}

- (void)dealloc {
    self.itemImageView = nil;
    self.borderImageView = nil;
    self.itemLabel = nil;
}

@end
