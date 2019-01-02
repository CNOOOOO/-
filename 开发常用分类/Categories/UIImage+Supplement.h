//
//  UIImage+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Supplement)

/** 用颜色生成image */
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 截取部分图像 */
- (UIImage *)subImageWithRect:(CGRect)rect;

/** 等比例缩放 */
- (UIImage *)scaleToSize:(CGSize)size;

/** 获得屏幕图像 */
+ (UIImage *)imageFromView:(UIView *)view;

/** 获得某个范围内的屏幕图像 */
+ (UIImage *)imageFromView:(UIView *)view withFrame:(CGRect)frame;

//相比于质量压缩，尺寸压缩容易造成图片模糊
/** 压缩图片尺寸 */
- (UIImage *)compressedImageSize;

/** 压缩图片质量 */
- (NSData *)compressedImageQualityWithScale:(CGFloat)scale;

/**
 同时压缩尺寸和质量
 @param length 每兆(M)压缩后的大小
 */
- (NSData *)compressedImageWithPerMegabyteLength:(CGFloat)length;

/** 压缩图片使图片文件小于指定大小 */
- (NSData *)compressImageWithMaxLength:(NSUInteger)maxLength;

@end
