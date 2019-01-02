//
//  UIButton+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "UIButton+Supplement.h"
#import "UIImage+Supplement.h"
#import <objc/runtime.h>

@implementation UIButton (Supplement)

static char ActionKey;
static char topKey;
static char leftKey;
static char bottomKey;
static char rightKey;


/** Normal状态下的文字 */
- (void)normalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

/** Selected状态下的文字 */
- (void)selectedTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateSelected];
}

/** Highlighted状态下的文字 */
- (void)highlightedTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateHighlighted];
}

/** Normal状态下的文字颜色 */
- (void)normalTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

/** Selected状态下的文字颜色 */
- (void)selectedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateSelected];
}

/** Highlighted状态下的文字颜色 */
- (void)highlightedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateHighlighted];
}

/** Normal状态下用name设置image */
- (void)normalImageWithName:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

/** Normal状态下用color设置image */
- (void)normalImageWithColor:(UIColor *)color {
    [self setImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
}

/** Selected状态下用name设置image */
- (void)selectedImageWithName:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
}

/** Selected状态下用color设置image */
- (void)selectedImageWithColor:(UIColor *)color {
    [self setImage:[UIImage imageWithColor:color] forState:UIControlStateSelected];
}

/** Highlighted状态下用name设置image */
- (void)highlightedImageWithName:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

/** Highlighted状态下用color设置image */
- (void)highlightedImageWithColor:(UIColor *)color {
    [self setImage:[UIImage imageWithColor:color] forState:UIControlStateHighlighted];
}

/** Normal状态下用name设置BackgroundImage */
- (void)normalBackgroundImageWithName:(NSString *)imageName {
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

/** Normal状态下用color设置BackgroundImage */
- (void)normalBackgroundImageWithColor:(UIColor *)color {
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
}

/** Selected状态下用name设置BackgroundImage */
- (void)selectedBackgroundImageWithName:(NSString *)imageName {
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
}

/** Selected状态下用color设置BackgroundImage */
- (void)selectedBackgroundImageWithColor:(UIColor *)color {
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateSelected];
}

/** Highlighted状态下用name设置BackgroundImage */
- (void)highlightedBackgroundImageWithName:(NSString *)imageName {
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
}

/** Highlighted状态下用color设置BackgroundImage */
- (void)highlightedBackgroundImageWithColor:(UIColor *)color {
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateHighlighted];
}

/** 设置系统默认字体的大小 */
- (void)systemFont:(CGFloat)font {
    self.titleLabel.font = [UIFont systemFontOfSize:font];
}

/** 设置字体 */
- (void)font:(UIFont *)font {
    self.titleLabel.font = font;
}

/** 添加点击事件,点击方式UIControlEventTouchUpInside */
- (void)addAction:(ActionBlock)block {
    objc_setAssociatedObject(self, &ActionKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

/** 添加点击事件，点击方式自己定 */
- (void)addAction:(ActionBlock)block forControlEvents:(UIControlEvents)controlEvents {
    objc_setAssociatedObject(self, &ActionKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

//点击事件
- (void)action:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &ActionKey);
    if (block) {
        block(self);
    }
}

/** 扩大button响应范围，不同方向根据给定的大小扩大 */
- (void)enlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right {
    objc_setAssociatedObject(self, &topKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/** 扩大button响应范围,四个方向同时扩大相同大小 */
- (void)enlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber *topEdge = objc_getAssociatedObject(self, &topKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightKey);
    if (topEdge || leftEdge || bottomEdge || rightEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

//重写pointInside方法扩大button响应范围
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    CGRect bounds = self.bounds;
//    //若原热区小于40x40，则放大热区，否则保持原大小不变
//    CGFloat widthDelta = MAX(40.0 - bounds.size.width, 0);
//    CGFloat heightDelta = MAX(40.0 - bounds.size.height, 0);
//    //CGRectInset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>),第一个参数rect：要改变的视图的frame，第二个参数dx：x轴方向平移的值，第三个参数dy：y轴方向平移的值，宽度 -= 2倍dx，高度 -= 2倍dy，即dx,dy为正值，rect缩小，dx,dy为负值，rect放大
//    //CGRectOffset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>),第一个参数rect：要改变的视图的frame，第二个参数dx：x轴方向平移的值，第三个参数dy：y轴方向平移的值
//    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
//    return CGRectContainsPoint(bounds, point);
//}

/** 设置button的image和title的样式 */
- (void)buttonEdgeInsetsWithImageDirection:(ImageDirection)direction space:(CGFloat)space {
    UIImage *image = self.imageView.image;
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, self.titleLabel.bounds.size.height)];
    switch (direction) {
        case ImageDirectionTop:
            self.titleEdgeInsets = UIEdgeInsetsMake(image.size.height * 0.5 + space, -image.size.width * 0.5, -image.size.height * 0.5 - space, image.size.width * 0.5);
            self.imageEdgeInsets = UIEdgeInsetsMake(-size.height * 0.5 - space, size.width * 0.5, size.height * 0.5 + space, -size.width * 0.5);
            break;
        case ImageDirectionBottom:
            self.titleEdgeInsets = UIEdgeInsetsMake(-image.size.height * 0.5 - space, -image.size.width * 0.5, image.size.height * 0.5 + space, image.size.width * 0.5);
            self.imageEdgeInsets = UIEdgeInsetsMake(size.height * 0.5 + space, size.width * 0.5, -size.height * 0.5 - space, -size.width * 0.5);
            break;
        case ImageDirectionRight:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width - space, 0, image.size.width + space);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, size.width + space, 0, -size.width - space);
            break;
        default:
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space, 0, - space);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, - space, 0, space);
            break;
    }
}

@end
