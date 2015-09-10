//
//  NextTableViewController.h
//  colleage
//
//  Created by Apple on 15/9/8.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface NextTableViewController : UITableViewController{

    MBProgressHUD *hud;
}
//显示加载器
-(void) showProgressing:(NSString*)info;
//显示吐司
-(void) showToast:(NSString*)info;
//隐藏
-(void)hide;
@end
