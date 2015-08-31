//
//  CommonUtil.m
//  colleage
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil
//定义navigationItem的title
+(UILabel*)navigationTitleViewWithTitle:(NSString *)title{
    
    UILabel *titleLabel        = [[UILabel alloc] init];
    titleLabel.frame           = CGRectMake(100, 0, 120, 44);
    titleLabel.font            = [UIFont boldSystemFontOfSize:20];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = title;
    titleLabel.textColor       = [UIColor whiteColor];
    return titleLabel;
}
@end
