//
//  UIButton+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(UIButton *button);

typedef NS_ENUM(NSInteger, ImageDirection) {
    ImageDirectionTop = 0,
    ImageDirectionLeft,
    ImageDirectionBottom,
    ImageDirectionRight
};

@interface UIButton (Supplement)

/** Normal状态下的文字 */
- (void)normalTitle:(NSString *)title;
/** Selected状态下的文字 */
- (void)selectedTitle:(NSString *)title;
/** Highlighted状态下的文字 */
- (void)highlightedTitle:(NSString *)title;

/** Normal状态下的文字颜色 */
- (void)normalTitleColor:(UIColor *)color;
/** Selected状态下的文字颜色 */
- (void)selectedTitleColor:(UIColor *)color;
/** Highlighted状态下的文字颜色 */
- (void)highlightedTitleColor:(UIColor *)color;

/** Normal状态下用name设置image */
- (void)normalImageWithName:(NSString *)imageName;
/** Normal状态下用color设置image */
- (void)normalImageWithColor:(UIColor *)color;
/** Selected状态下用name设置image */
- (void)selectedImageWithName:(NSString *)imageName;
/** Selected状态下用color设置image */
- (void)selectedImageWithColor:(UIColor *)color;
/** Highlighted状态下用name设置image */
- (void)highlightedImageWithName:(NSString *)imageName;
/** Highlighted状态下用color设置image */
- (void)highlightedImageWithColor:(UIColor *)color;

/** Normal状态下用name设置BackgroundImage */
- (void)normalBackgroundImageWithName:(NSString *)imageName;
/** Normal状态下用color设置BackgroundImage */
- (void)normalBackgroundImageWithColor:(UIColor *)color;
/** Selected状态下用name设置BackgroundImage */
- (void)selectedBackgroundImageWithName:(NSString *)imageName;
/** Selected状态下用color设置BackgroundImage */
- (void)selectedBackgroundImageWithColor:(UIColor *)color;
/** Highlighted状态下用name设置BackgroundImage */
- (void)highlightedBackgroundImageWithName:(NSString *)imageName;
/** Highlighted状态下用color设置BackgroundImage */
- (void)highlightedBackgroundImageWithColor:(UIColor *)color;

/** 设置系统默认字体的大小 */
- (void)systemFont:(CGFloat)font;
/** 设置字体 */
- (void)font:(UIFont *)font;

/** 添加点击事件,点击方式UIControlEventTouchUpInside */
- (void)addAction:(ActionBlock)block;

/** 添加点击事件，点击方式自己定 */
- (void)addAction:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents;

/** 扩大button响应范围，不同方向根据给定的大小扩大 */
- (void)enlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

/** 扩大button响应范围,四个方向同时扩大相同大小 */
- (void)enlargeEdge:(CGFloat)size;

/**
 设置button的image和title的样式
 @param direction image相对于title的方向
 @param space image和title之间的间隔
 */
- (void)buttonEdgeInsetsWithImageDirection:(ImageDirection)direction space:(CGFloat)space;


@end
