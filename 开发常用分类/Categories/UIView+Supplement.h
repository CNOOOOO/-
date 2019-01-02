//
//  UIView+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2018/8/16.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Supplement)

/** view的原点 */
@property (nonatomic, assign) CGPoint cn_origin;

/** view的原点X(可理解成视图的左边) */
@property (nonatomic, assign) CGFloat cn_originX;

/** view的原点Y(可理解成视图的顶部) */
@property (nonatomic, assign) CGFloat cn_originY;

/** view的尺寸 */
@property (nonatomic, assign) CGSize cn_size;

/** view的宽度 */
@property (nonatomic, assign) CGFloat cn_width;

/** view的高度 */
@property (nonatomic, assign) CGFloat cn_height;

/** 视图的右边对应的X轴的坐标 */
- (CGFloat)cn_right;

/** 视图的底部对应的Y轴的坐标 */
- (CGFloat)cn_bottom;

/** 视图中心点对应X轴的坐标 */
@property (nonatomic, assign) CGFloat cn_centerX;

/** 视图中心点对应Y轴的坐标 */
@property (nonatomic, assign) CGFloat cn_centerY;

/** 画圆角 */
- (void)viewWithCornerRadius:(CGFloat)radius;

/** 画带描边的圆角 */
- (void)viewWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

@end
