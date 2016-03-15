//
//  UIDevice+XHDevices.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "UIDevice+XHDevices.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation UIDevice (XHDevices)

+ (BOOL)de_isIOS5
{
    return (NSClassFromString(@"NSJSONSerialization") != nil);
}


+ (BOOL)de_isPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? YES : NO;
}


+ (BOOL)de_isPhone
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? YES : NO;
}


+ (BOOL)de_isRetinaDisplay
{
    UIScreen* screen = [UIScreen mainScreen];
    if ([screen respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        [screen respondsToSelector:@selector(scale)]) {
        return screen.scale == 2.0f;
    }
    
    return NO;
}

+ (BOOL)de_isiPhone5 {
    if (iPhone5) {
        return TRUE;
    } else {
        return FALSE;
    }
}
@end
