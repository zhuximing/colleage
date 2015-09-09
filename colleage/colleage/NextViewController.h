//
//  NextViewController.h
//  BmobIMDemo
//
//  Created by Bmob on 14-6-25.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface NextViewController : UIViewController{
    
    MBProgressHUD *hud;
}


-(void)goback;
//显示加载器
-(void) showProgressing:(NSString*)info;
//显示吐司
-(void) showToast:(NSString*)info;
//隐藏
-(void)hide;
@end
