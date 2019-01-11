//
//  UIImageView+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2019/1/10.
//  Copyright © 2019年 Mac2. All rights reserved.
//

#import "UIImageView+Supplement.h"

@implementation UIImageView (Supplement)

/** 通过image和frame创建 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image frame:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = frame;
    return imageView;
}

/** 通过image、size和center创建 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image size:(CGSize)size center:(CGPoint)center {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    imageView.center = center;
    return imageView;
}

/** 通过image和center创建 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image center:(CGPoint)center {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.center = center;
    return imageView;
}

/** 设置imageView的圆角 */
- (void)setFilletedCornerWithRadius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

/** 设置imageView的圆角和边界线 */
- (void)setFilletedCornerAndBorderWithRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    borderLayer.cornerRadius = radius;
    borderLayer.borderWidth = width;
    borderLayer.borderColor = color.CGColor;
    [self.layer addSublayer:borderLayer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    self.layer.mask = layer;
}


@end
