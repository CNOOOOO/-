//
//  NSMutableAttributedString+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2019/1/11.
//  Copyright © 2019年 Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Supplement)

/**
 通过属性字典创建属性字符串(注意：body、font、color、text这几个key命名需要和例子中一致)：
 dic = @{
 @"marker":@{@"font":[UIFont systemFontOfSize:20], @"color": [UIColor redColor], @"text":@"hello"},
 @"body":@{@"font":[UIFont systemFontOfSize:15], @"color":[UIColor blackColor]}
 };
 */
+ (instancetype)attributeWithDic:(NSDictionary *)dic string:(NSString *)string;

@end
