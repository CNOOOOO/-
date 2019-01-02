//
//  UIImage+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "UIImage+Supplement.h"

#define TargetValue 1280

@implementation UIImage (Supplement)

/** 用颜色生成image */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 截取部分图像 */
- (UIImage *)subImageWithRect:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect subBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(subBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subBounds, subImageRef);
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return image;
}

/** 等比例缩放 */
- (UIImage *)scaleToSize:(CGSize)size {
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    float verticalRadio = size.height * 1.0 / height;
    float horizontalRadio = size.width * 1.0 / width;
    float radio = 1;
    if(verticalRadio > 1 && horizontalRadio > 1) {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    } else {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    width = width * radio;
    height = height * radio;
    int x = (size.width - width) / 2;
    int y = (size.height - height) / 2;
    
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(x, y, width, height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//获得屏幕图像
+ (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)view withFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(frame);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}

//压缩图片尺寸
- (UIImage *)compressedImageSize {
    //宽高比
    CGFloat ratio = self.size.width / self.size.height;
    //目标大小
    CGFloat targetW = TargetValue;
    CGFloat targetH = TargetValue;
    
    if (self.size.width < TargetValue && self.size.height < TargetValue) {
        //宽、高均 <= 1280，图片尺寸大小保持不变
        return self;
    }else if(self.size.width > TargetValue && self.size.height > TargetValue) {
        //宽高均 > 1280
        if (ratio > 1) {
            //宽大于高，取较小值(高)等于1280，较大值等比例压缩
            targetH = TargetValue;
            targetW = targetH * ratio;
        }else {
            //高大于宽，取较小值(宽)等于1280，较大值等比例压缩
            targetW = TargetValue;
            targetH = targetW / ratio;
        }
    }else {
        //宽或高 > 1280
        if (ratio > 2) {
            //宽图，图片尺寸大小保持不变
            targetW = self.size.width;
            targetH = self.size.height;
        }else if(ratio < 0.5) {
            //长图，图片尺寸大小保持不变
            targetW = self.size.width;
            targetH = self.size.height;
        }else if(ratio > 1) {
            //宽大于高，取较大值(宽)等于1280，较小值等比例压缩
            targetW = TargetValue;
            targetH = targetW / ratio;
        }else {
            //高大于宽，取较大值(高)等于1280，较小值等比例压缩
            targetH = TargetValue;
            targetW = targetH * ratio;
        }
    }
    UIGraphicsBeginImageContext(CGSizeMake(targetW, targetH));
    [self drawInRect:CGRectMake(0, 0, targetW, targetH)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
    NSLog(@"After compressing size, image size = %ld KB", (long)data.length / 1024);
    return newImage;
}

//压缩图片质量
- (NSData *)compressedImageQualityWithScale:(CGFloat)scale {
    NSData *data = UIImageJPEGRepresentation(self, scale);
    NSLog(@"After compressing quality, image size = %ld KB", (long)data.length / 1024);
    return data;
}

//根据每兆压缩后的大小，同时压缩尺寸和质量，该方法压缩后的大小由原图大小决定（大的压缩后比小的压缩后大）
- (NSData *)compressedImageWithPerMegabyteLength:(CGFloat)length {
    UIImage *image = [self compressedImageSize];
    
    CGFloat scale = 1;
    NSData *data = UIImageJPEGRepresentation(image, scale);
    //计算出图片有多少兆
    CGFloat M = data.length / 1024 / 1024;
    CGFloat purposeLength;
    if (M <= 1.0) {//小于等于1兆
        purposeLength = length;
    }else {//大于1兆
        purposeLength = M * length;
    }
    NSLog(@"Before compressing quality, image size = %ld KB",(long)data.length/1024);
    if (data.length <= purposeLength) {
        return data;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        scale = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, scale);
        //NSLog(@"Compression = %.1f", scale);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < purposeLength * 0.9) {
            min = scale;
        } else if (data.length > purposeLength) {
            max = scale;
        } else {
            break;
        }
    }
    NSLog(@"After compressing, image size = %ld KB", (long)data.length / 1024);
    return data;
}

//压缩图片使图片文件小于指定大小（压缩后所有图片都小于指定的大小）
- (NSData *)compressImageWithMaxLength:(NSUInteger)maxLength {
    // Compress by quality(二分法)
    CGFloat scale = 1;
    NSData *data = UIImageJPEGRepresentation(self, scale);
    NSLog(@"Before compressing quality, image size = %ld KB",(long)data.length/1024);
    if (data.length <= maxLength) {
        return data;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        scale = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, scale);
        //NSLog(@"Compression = %.1f", scale);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = scale;
        } else if (data.length > maxLength) {
            max = scale;
        } else {
            break;
        }
    }
    NSLog(@"After compressing quality, image size = %ld KB", (long)data.length / 1024);
    if (data.length <= maxLength) {
        return data;
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
//        NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, scale);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    NSLog(@"After compressing size loop, image size = %ld KB", (long)data.length / 1024);
    return data;
}


@end
