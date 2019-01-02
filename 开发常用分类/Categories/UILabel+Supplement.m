//
//  UILabel+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "UILabel+Supplement.h"

@implementation UILabel (Supplement)

//一次性初始化
+ (UILabel *)labelWithFrame:(CGRect)frame text:(nullable NSString *)text font:(UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    if (textColor) {
        label.textColor = textColor;
    }else {
        label.textColor = [UIColor blackColor];
    }
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    return label;
}

//动态设置label的高度
+ (UILabel *)dynamicHeightLabelWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width text:(NSString *)text font:(UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy};
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, width, size.height)];
    label.numberOfLines = 0;
    label.font = font;
    label.text = text;
    if (textColor) {
        label.textColor = textColor;
    }else {
        label.textColor = [UIColor blackColor];
    }
    label.textAlignment = textAlignment;
    return label;
}

//动态计算label尺寸
- (CGSize)calculateLabelSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace{
    //方式一
//    return [self sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    //方式二
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    if (lineSpace > 0.0) {
        paragraphStyle.lineSpacing = lineSpace;
    }
    NSDictionary *attributes;
    if (wordSpace > 0.0) {
        attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy, NSKernAttributeName: @(wordSpace)};
    }else {
        attributes = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy};
    }
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //判断内容是否只有一行: (目前高度 - 字体高度) <= 行间距
    if ((size.height - font.lineHeight) <= paragraphStyle.lineSpacing){
        //如果只有一行，进行判断内容中是否全部为汉字
        if ([self containChinese:text]) {
            //修正后高度为：目前高度 - 一个行间距
            size = CGSizeMake(size.width, size.height - paragraphStyle.lineSpacing);
        }
    }
    return size;
}

//判断内容中是否全部为汉字
- (BOOL)containChinese:(NSString *)string {
    for(int i=0; i< [string length];i++){ int a = [string characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

//设置label的行间距
- (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedStr;
    [label sizeToFit];
}

//设置label的字间距
- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

//设置label行间距和字间距
- (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

//设置label部分字体的颜色
- (void)setTextColor:(UIColor *)color atRange:(NSRange)range {
    [self setTextAttributes:@{NSForegroundColorAttributeName: color} atRange:range];
}

//设置label部分字体的大小
- (void)setTextFont:(UIFont *)font atRange:(NSRange)range {
    [self setTextAttributes:@{NSFontAttributeName: font} atRange:range];
}

//设置label部分文字的颜色和大小
- (void)setTextColor:(UIColor *)color font:(UIFont *)font atRange:(NSRange)range {
    [self setTextAttributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: font} atRange:range];
}

//设置label部分文字属性
- (void)setTextAttributes:(NSDictionary *)attributes atRange:(NSRange)range {
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    for (NSString *name in attributes) {
        [mutableAttributedString addAttribute:name value:[attributes objectForKey:name] range:range];
    }
    self.attributedText = mutableAttributedString;
}

@end
