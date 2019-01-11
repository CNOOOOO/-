//
//  NSString+Supplement.m
//  开发常用分类
//
//  Created by Mac2 on 2019/1/10.
//  Copyright © 2019年 Mac2. All rights reserved.
//

#import "NSString+Supplement.h"

@implementation NSString (Supplement)

/** 计算字符串的宽度 */
- (CGFloat)getWidthWithMaxSize:(CGSize)maxSize font:(CGFloat)font {
    return [self getSizeWithMaxSize:maxSize font:font].width;
}

/** 计算字符串的高度 */
- (CGFloat)getHeightWithMaxSize:(CGSize)maxSize font:(CGFloat)font {
    return [self getSizeWithMaxSize:maxSize font:font].height;
}

/** 根据最大宽高计算字符串的宽高 */
- (CGSize)getSizeWithMaxSize:(CGSize)maxSize font:(CGFloat)font {
    /*
     //有行间距
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
     [paragraphStyle setLineSpacing:10];//调整行间距
     return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
     */
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

//正则表达式
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

/** 联系方式验证 */
- (BOOL)isValidateContactNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,152,157,158,159,178,182,183,184,187,188
     * 联通：130,131,132,152,155,156,166,175,176,185,186
     * 电信：133,1349,153,173,177,180,181,189,199
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|66|7[35-8]|8[0-9]|99)\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,152,157,158,159,178,182,183,184,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0127-9]|78|8[23478])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,166,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|66|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,173,177,180,181,189,199
     22         */
    NSString * CT = @"^1((33|53|7[37]|8[019]|99)[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    if ([self isValidateByRegex:MOBILE] || [self isValidateByRegex:CM] || [self isValidateByRegex:CU] || [self isValidateByRegex:CT] || [self isValidateByRegex:PHS]) {
        return YES;
    }else {
        return NO;
    }
}

/** 邮箱验证 */
- (BOOL)isValidateEmailAddress {
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

/** 精确的身份证号码有效性检测 */
- (BOOL)IDCardNumberAccurateVerify {
    NSString *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        if (length != 15 && length != 18) {
                return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue + 1900;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                 regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch > 0) {
               return YES;
            }else {
                 return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 == 0 || (year % 100 == 0 && year % 4 == 0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                 regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
                         if(numberofMatch > 0) {
                            int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) * 7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) * 9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) * 10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) * 5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) * 8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) * 4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) * 2 + [value substringWithRange:NSMakeRange(7,1)].intValue * 1 + [value substringWithRange:NSMakeRange(8,1)].intValue * 6 + [value substringWithRange:NSMakeRange(9,1)].intValue * 3;
                             int Y = S % 11;
                             NSString *M = @"F";
                             NSString *JYM = @"10X98765432";
                             M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                             if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                                 return YES;// 检测ID的校验位
                             }else {
                                  return NO;
                             }
                        }else {
                             return NO;
                                 }
        default:
            return NO;
    }
}

/** 银行卡号有效性问题Luhn算法
*  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
*  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
*  16 位卡号校验位采用 Luhm 校验方法计算：
*  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
*  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
*  3，将加法和加上校验位能被 10 整除。
*/
- (BOOL)bankCardluhnCheck {
    NSString *lastNum = [[self substringFromIndex:(self.length - 1)] copy];//取出最后一位
    NSString *forwardNum = [[self substringToIndex:(self.length - 1)] copy];//前15或18位
    NSMutableArray *forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < forwardNum.length; i++) {
        NSString *subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
        }
    NSMutableArray *forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count - 1); i > -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
        }
    NSMutableArray *arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray *arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray *arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    for (int i = 0; i < forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i % 2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
            }else {//奇数位
                if (num * 2 < 9) {
                    [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
                    }else {
                        NSInteger decadeNum = (num * 2) / 10;
                        NSInteger unitNum = (num * 2) % 10;
                        [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                        [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
                        }
                }
        }
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
        }];
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
        }];
    __block NSInteger sumEvenNumTotal = 0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
        }];
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    return (luhmTotal % 10 == 0) ? YES : NO;
}

/** 去掉字符串头尾的空格 */
- (NSString *)removeHeadAndFootWhiteSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/** 去掉字符串中的所有空格 */
- (NSString *)removeAllWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/** 去掉字符串头尾的换行 */
- (NSString *)removeHeadAndFootNewlineCharacters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

/** 去掉字符串中的所有换行 */
- (NSString *)removeAllNewlineCharacters {
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

/** 去掉字符串头尾的空格和换行符 */
- (NSString *)removeHeadAndFootWhiteSpaceAndNewlineCharacters {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/** 去掉字符串中的所有空格和换行符 */
- (NSString *)removeAllWhiteSpaceAndNewlineCharacters {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    NSRange range = {0, mutableString.length};
    [mutableString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0, mutableString.length};
    [mutableString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    NSRange range3 = {0, mutableString.length};
    [mutableString replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:range3];
    return mutableString;
}

/** 判断是否为空字符串 */
- (BOOL)isEmptyString {
    //为空
    if (!self) {
        return YES;
    }
    //空格、tab和换行符
    if (![self removeAllWhiteSpaceAndNewlineCharacters].length) {
        return YES;
    }
    return NO;
}

/** 判断字符串是否全为字母 */
- (BOOL)isOnlyContainLetters {
    NSString *regEx = @"^[A-Za-z]*";
    return [self isValidateByRegex:regEx];
}

/** 判断字符串是否全为数字 */
- (BOOL)isOnlyContainNumbers {
    NSString *regEx = @"^[0-9]*";
    return [self isValidateByRegex:regEx];
}

/** 判断字符串是否由数字、字母和下划线组成 */
- (BOOL)isFormOfNumbersAndLettersAndUnderline {
    NSString *regEx = @"^[A-Za-z0-9_]*";//@"^[A-Za-z0-9_]{8,16}" 8~16位
    return [self isValidateByRegex:regEx];
}

/** 字符串转data */
- (NSData *)convertStringToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

/** data转字符串 */
- (NSString *)convertDataToString:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**json字符串转数组或字典 */
- (id)convertJsonToArrayOrDictionary {
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}


@end
