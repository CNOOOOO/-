//
//  UIColor+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Supplement)

/** RGBA颜色设置 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

/** 随机色 */
+ (UIColor *)randomColor;

/** 十六进制颜色值转UIColor，透明度为1.0 */
+ (UIColor *)colorWithHex:(UInt32)hex;

/** 十六进制颜色值转UIColor，透明度自定义 */
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

/** 十六进制颜色字符串转UIColor，透明度为1.0 */
+ (UIColor *)colorWithHexString:(NSString*)colorString;

/** 十六进制颜色字符串转UIColor，透明度自定义 */
+ (UIColor *)colorWithHexString:(NSString*)colorString alpha:(CGFloat)alpha;

/** 将UIColor转换成16进制字符串 */
- (NSString *)HEXString;

/** 翻转颜色 */
- (UIColor *)invertedColor;

/** 半透明颜色 */
- (UIColor *)translucentColor;

@end
