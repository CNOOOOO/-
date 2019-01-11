//
//  UIImageView+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2019/1/10.
//  Copyright © 2019年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Supplement)

/** 通过image和frame创建 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image frame:(CGRect)frame;

/** 通过image、size和center创建 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image size:(CGSize)size center:(CGPoint)center;

/** 通过image和center创建 */
+ (UIImageView *)imageViewWithImage:(UIImage *)image center:(CGPoint)center;

/** 设置imageView的圆角 */
- (void)setFilletedCornerWithRadius:(CGFloat)radius;

/** 设置imageView的圆角和边界线 */
- (void)setFilletedCornerAndBorderWithRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;


@end
