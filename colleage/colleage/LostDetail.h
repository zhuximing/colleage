//
//  LostDetail.h
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"

@interface LostDetail : NextViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *wb;
@property  NSString *user_phone;//发布本条信息的用户的电话
@property NSString *lost_id;   //本条信息的id
@property NSString *HttpPath; //请求地址

@end
