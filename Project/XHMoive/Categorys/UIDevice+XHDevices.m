//
//  UIDevice+XHDevices.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-19.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
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
