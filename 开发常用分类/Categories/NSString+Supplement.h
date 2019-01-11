//
//  NSString+Supplement.h
//  开发常用分类
//
//  Created by Mac2 on 2019/1/10.
//  Copyright © 2019年 Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Supplement)

/** 计算字符串的宽度 */
- (CGFloat)getWidthWithMaxSize:(CGSize)maxSize font:(CGFloat)font;

/** 计算字符串的高度 */
- (CGFloat)getHeightWithMaxSize:(CGSize)maxSize font:(CGFloat)font;

/** 根据最大宽高计算字符串的宽高 */
- (CGSize)getSizeWithMaxSize:(CGSize)maxSize font:(CGFloat)font;

/** 联系方式验证 */
- (BOOL)isValidateContactNumber;

/** 邮箱验证 */
- (BOOL)isValidateEmailAddress;

/** 精确的身份证号码有效性检测 */
- (BOOL)IDCardNumberAccurateVerify;

/** 银行卡号有效性问题Luhn算法 */
- (BOOL)bankCardluhnCheck;

/** 去掉字符串头尾的空格 */
- (NSString *)removeHeadAndFootWhiteSpace;

/** 去掉字符串中的所有空格 */
- (NSString *)removeAllWhiteSpace;

/** 去掉字符串头尾的换行 */
- (NSString *)removeHeadAndFootNewlineCharacters;

/** 去掉字符串中的所有换行 */
- (NSString *)removeAllNewlineCharacters;

/** 去掉字符串头尾的空格和换行符 */
- (NSString *)removeHeadAndFootWhiteSpaceAndNewlineCharacters;

/** 去掉字符串中的所有空格和换行符 */
- (NSString *)removeAllWhiteSpaceAndNewlineCharacters;

/** 判断是否为空字符串 */
- (BOOL)isEmptyString;

/** 判断字符串是否全为字母 */
- (BOOL)isOnlyContainLetters;

/** 判断字符串是否全为数字 */
- (BOOL)isOnlyContainNumbers;

/** 判断字符串是否由数字、字母和下划线组成 */
- (BOOL)isFormOfNumbersAndLettersAndUnderline;

/** 字符串转data */
- (NSData *)convertStringToData;

/** data转字符串 */
- (NSString *)convertDataToString:(NSData *)data;

/**json字符串转数组或字典 */
- (id)convertJsonToArrayOrDictionary;

@end
