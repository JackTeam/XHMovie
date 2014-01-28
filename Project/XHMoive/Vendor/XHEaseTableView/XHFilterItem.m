//
//  XHFilterItem.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
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
