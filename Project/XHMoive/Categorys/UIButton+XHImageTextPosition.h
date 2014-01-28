//
//  UIButton+XHImageTextPosition.h
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XHImagePosition) {
    kXHHorizontalDirection = 0,
    kXHVerticalDirection
};

@interface UIButton (XHImageTextPosition)
- (void)setImage:(UIImage *)image imagePosition:(XHImagePosition)imagePosition withTitle:(NSString *)title forState:(UIControlState)stateType;
@end
