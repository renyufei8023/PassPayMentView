//
//  NSString+RYF.m
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import "NSString+RYF.h"

@implementation NSString (RYF)

+ (NSString *)pathForDocuments
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)filePathAtDocumentsWithFileName:(NSString *)fileName
{
    return [[self pathForDocuments]stringByAppendingPathComponent:fileName];
}

+ (NSString *)pathForCaches
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
}

+ (NSString *)filePathAtCachesWithFileName:(NSString *)fileName
{
    return [[self pathForCaches]stringByAppendingPathComponent:fileName];
}

+ (NSString *)pathForMainBundle
{
    return [NSBundle mainBundle].bundlePath;
}

+ (NSString *)filePathAtMainBundleWithFileName:(NSString *)fileName
{
    return [[self pathForMainBundle]stringByAppendingPathComponent:fileName];
}

+ (NSString *)pathForTemp
{
    return NSTemporaryDirectory();
}

+ (NSString *)filePathAtTempWithFileName:(NSString *)fileName
{
    return [[self pathForTemp]stringByAppendingPathComponent:fileName];
}

+ (NSString *)pathForPreferences
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES)lastObject];
}

+ (NSString *)filePathAtPrefrencesWithFileName:(NSString *)fileName
{
    return [[self pathForPreferences]stringByAppendingPathComponent:fileName];
}

+ (NSString *)pathForSystemFile:(NSSearchPathDirectory)directory
{
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)lastObject];
}

+ (NSString *)filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName
{
    return [[self pathForSystemFile:directory] stringByAppendingPathComponent:fileName];
}

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *arrts = @{NSFontAttributeName:font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    return [text sizeWithFont:font andMaxSize:maxSize];
}
@end
