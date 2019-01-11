//
//  UIColor+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "UIColor+Supplement.h"

@implementation UIColor (Supplement)

/** RGBA颜色设置 */
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

/** 随机色 */
+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random()%256 / 255.0 green:arc4random()%256 / 255.0 blue:arc4random()%256 / 255.0 alpha:1.0];
}

/** 十六进制颜色值转UIColor，透明度为1.0 */
+ (UIColor *)colorWithHex:(UInt32)hex {
    return [UIColor colorWithHex:hex alpha:1.0];
}

/** 十六进制颜色值转UIColor，透明度自定义 */
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex >> 16) & 0xFF) / 255.0
                           green:((hex >> 8) & 0xFF) / 255.0
                            blue:(hex & 0xFF) / 255.0
                           alpha:alpha];
}

/** 十六进制颜色字符串转UIColor，透明度为1.0 */
+ (UIColor *)colorWithHexString:(NSString*)colorString {
    return [UIColor colorWithHexString:colorString alpha:1.0];
}

/** 十六进制颜色字符串转UIColor，透明度自定义 */
+ (UIColor *)colorWithHexString:(NSString*)colorString alpha:(CGFloat)alpha {
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/** 将UIColor转换成16进制字符串 */
- (NSString *)HEXString {
    UIColor* color = self;
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[1] * 255.0),
            (int)((CGColorGetComponents(color.CGColor))[2] * 255.0)];
}

/** 翻转颜色 */
- (UIColor *)invertedColor {
    NSArray *components = [self componentArray];
    return [UIColor colorWithRed:1.0 - [components[0] doubleValue] green:1.0 - [components[1] doubleValue] blue:1.0 - [components[2] doubleValue] alpha:[components[3] doubleValue]];
}

- (NSArray *)componentArray {
    CGFloat red, green, blue, alpha;
    const CGFloat *components = CGColorGetComponents([self CGColor]);
    if(CGColorGetNumberOfComponents([self CGColor]) == 2) {
        red = components[0];
        green = components[0];
        blue = components[0];
        alpha = components[1];
    }else {
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    return @[@(red), @(green), @(blue), @(alpha)];
}

/** 半透明颜色 */
- (UIColor *)translucentColor {
    CGFloat hue = 0.0, saturation = 0.0, brightness = 0.0, alpha = 0.0;
    //获得颜色的色调、饱和度、亮度和透明度
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    return [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:alpha * 0.5];
}


@end
