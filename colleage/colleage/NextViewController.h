//
//  NextViewController.h
//  BmobIMDemo
//
//  Created by Bmob on 14-6-25.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
@interface NextViewController : UIViewController<UIAlertViewDelegate,MFMailComposeViewControllerDelegate>{
    
    MBProgressHUD *hud;
}


-(void)goback;
//显示加载器
-(void) showProgressing:(NSString*)info;
//显示吐司
-(void) showToast:(NSString*)info;
//隐藏
-(void)hide;
//没有事件响应的弹出框
- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg;
//通过故事版获取视图控制器
-(id)getViewController:(NSString *) identify;
@end
