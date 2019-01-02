//
//  UIView+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "UIView+Supplement.h"

@implementation UIView (Supplement)

//view的原点
- (CGPoint)cn_origin {
    return self.frame.origin;
}

- (void)setCn_origin:(CGPoint)cn_origin {
    CGRect frame = self.frame;
    frame.origin = cn_origin;
    self.frame = frame;
}

//view的原点X(可理解成视图的左边)
- (CGFloat)cn_originX {
    return self.frame.origin.x;
}

- (void)setCn_originX:(CGFloat)cn_originX {
    CGRect frame = self.frame;
    frame.origin.x = cn_originX;
    self.frame = frame;
}

//view的原点Y(可理解成视图的顶部)
- (CGFloat)cn_originY {
    return self.frame.origin.y;
}

- (void)setCn_originY:(CGFloat)cn_originY {
    CGRect frame = self.frame;
    frame.origin.y = cn_originY;
    self.frame = frame;
}

//view的尺寸
- (CGSize)cn_size {
    return self.frame.size;
}

- (void)setCn_size:(CGSize)cn_size {
    CGRect frame = self.frame;
    frame.size = cn_size;
    self.frame = frame;
}

//view的宽度
- (CGFloat)cn_width {
    return self.frame.size.width;
}

- (void)setCn_width:(CGFloat)cn_width {
    CGRect frame = self.frame;
    frame.size.width = cn_width;
    self.frame = frame;
}

//view的高度
- (CGFloat)cn_height {
    return self.frame.size.height;
}

- (void)setCn_height:(CGFloat)cn_height {
    CGRect frame = self.frame;
    frame.size.height = cn_height;
    self.frame = frame;
}

//视图的右边对应的X轴的坐标
- (CGFloat)cn_right {
    return self.frame.origin.x + self.frame.size.width;
}

//视图的底部对应的Y轴的坐标
- (CGFloat)cn_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

//视图中心点对应X轴的坐标
- (CGFloat)cn_centerX {
    return self.center.x;
}

- (void)setCn_centerX:(CGFloat)cn_centerX {
    CGPoint center = self.center;
    center.x = cn_centerX;
    self.center = center;
}

//视图中心点对应Y轴的坐标
- (CGFloat)cn_centerY {
    return self.center.y;
}

- (void)setCn_centerY:(CGFloat)cn_centerY {
    CGPoint center = self.center;
    center.y = cn_centerY;
    self.center = center;
}

//视图设置圆角
- (void)viewWithCornerRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
//    //把某个角设置成圆角
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    [path addClip];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

//视图设置带描边的圆角
- (void)viewWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.lineWidth = width;
    borderLayer.path = path.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

@end
