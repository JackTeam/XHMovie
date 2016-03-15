//
//  UIButton+XHImageTextPosition.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "UIButton+XHImageTextPosition.h"

@implementation UIButton (XHImageTextPosition)
- (void)setImage:(UIImage *)image imagePosition:(XHImagePosition)imagePosition withTitle:(NSString *)title forState:(UIControlState)stateType {
    CGFloat fontSize = 0;
    if ([UIDevice de_isPad]) {
        fontSize = 30.0f;
    } else {
        fontSize = 20.0f;
    }
    CGSize titleSize = [title sizeWithFont:[UIFont boldSystemFontOfSize:fontSize]];
    [self.imageView setFrame:CGRectMake(0, 0, 20, 20)];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0,
                                              -image.size.width / 2.0,
                                              0.0,
                                              0.0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(.0, 0.0, 0.0, image.size.width - titleSize.width / 2.0)];
    [self setTitle:title forState:stateType];
}
@end
