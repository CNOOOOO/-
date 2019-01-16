//
//  NSMutableAttributedString+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2019/1/11.
//  Copyright © 2019年 Mac2. All rights reserved.
//

#import "NSMutableAttributedString+Supplement.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (Supplement)

+ (instancetype)attributeWithDic:(NSDictionary *)dic string:(NSString *)string {
    UIFont *bodyFont, *markerFont;
    UIColor *bodyColor, *markerColor;
    NSRange range = NSMakeRange(0, 0);
    for (NSString *key in [dic allKeys]) {
        if ([key isEqualToString:@"body"]) {//主体
            for (NSString *subKey in dic[key]) {
                if ([subKey isEqualToString:@"font"]) {//字体
                    bodyFont = dic[key][subKey];
                }else if ([subKey isEqualToString:@"color"]) {//颜色
                    bodyColor = dic[key][subKey];
                }
            }
        }else {//需要标记的部分
            for (NSString *subKey in [dic[key] allKeys]) {
                if ([subKey isEqualToString:@"font"]) {//字体
                    markerFont = dic[key][subKey];
                }else if ([subKey isEqualToString:@"color"]) {//颜色
                    markerColor = dic[key][subKey];
                }else if ([subKey isEqualToString:@"text"]) {//被标记的文字
                    range = [string rangeOfString:dic[key][subKey]];
                }
            }
        }
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: bodyColor, NSFontAttributeName: bodyFont, NSParagraphStyleAttributeName: paragraphStyle}];
    [attributedString addAttributes:@{NSForegroundColorAttributeName: markerColor, NSFontAttributeName: markerFont} range:range];
    return attributedString;
}

@end
