//
//  CommonUtil.h
//  colleage
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonUtil : NSObject{
    
}





//定义navigationItem的title
+(UILabel*)navigationTitleViewWithTitle:(NSString *)title;
//设置字体
+(UIFont*)setFontSize:(CGFloat)size;
+(UIColor*)setColorByR:(float)r G:(float)g   B:(float)b;
//判断是否登陆，如果没有登陆直接跳到登陆界面
+(void)needLoginWithViewController:(UIViewController*)viewController animated:(BOOL)animated ;

//自定义返回按钮,以及点击事件
-(void)customBack:(UIViewController*)controller;
+(NSString*)turnStringToEmojiText:(NSString *)string;
+(NSString *)decodeUnicodeBytes:(char *)stringEncoded;
+ (NSString*) unescapeUnicodeString:(NSString*)string;
+ (NSString*) escapeUnicodeString:(NSString*)string;
@end
