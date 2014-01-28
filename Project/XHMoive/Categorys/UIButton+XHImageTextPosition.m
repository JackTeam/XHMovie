//
//  UIButton+XHImageTextPosition.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
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
