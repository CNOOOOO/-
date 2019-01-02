//
//  UILabel+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Supplement)

/** 一次性初始化 */
+ (UILabel *)labelWithFrame:(CGRect)frame text:(nullable NSString *)text font:(UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;

/** 动态设置label的高度 */
+ (UILabel *)dynamicHeightLabelWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width text:(NSString *)text font:(UIFont *)font textColor:(nullable UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

/**
 动态计算label尺寸
 @param lineSpace  label行间距（没有设置时传0）
 @param wordSpace  label字间距（没有设置时传0）
 */
- (CGSize)calculateLabelSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

/** 设置label行间距 */
- (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/** 设置label字间距 */
- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/** 设置label行间距和字间距 */
- (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

/** 设置label部分字体的颜色 */
- (void)setTextColor:(UIColor *)color atRange:(NSRange)range;

/** 设置label部分字体的大小 */
- (void)setTextFont:(UIFont *)font atRange:(NSRange)range;

/**设置label部分文字的颜色和大小*/
- (void)setTextColor:(UIColor *)color font:(UIFont *)font atRange:(NSRange)range;

/** 设置label部分文字属性 */
- (void)setTextAttributes:(NSDictionary *)attributes atRange:(NSRange)range;

@end
