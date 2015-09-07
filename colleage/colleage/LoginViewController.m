//
//  LoginViewController.m
//  colleage
//
//  Created by Apple on 15/9/1.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LoginViewController.h"
#import "CommonUtil.h"
#import "MBProgressHUD.h"
#import "UserService.h"


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"登陆"];
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    
    //用户名输入框的左边图片
    UIImage *image=[UIImage imageNamed:@"login_admin"];
    UIImageView *imageView=[[UIImageView alloc ] initWithImage:image];
    _loginTf.leftView=imageView;
    _loginTf.leftViewMode=UITextFieldViewModeAlways;
    
    //密码输入框的左边图片
    UIImage *image1=[UIImage imageNamed:@"login_key"];
    UIImageView *imageView1=[[UIImageView alloc ] initWithImage:image1];
    _pwdTf.leftView=imageView1;
    _pwdTf.leftViewMode=UITextFieldViewModeAlways;
    
    
    //菊花残初始化
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.tag = kMBProgressTag;
    [self.view addSubview:hud];
    
    
    //登陆按钮的状态enable和disable的背景图片不一样
    [_loginbtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_loginbtn setBackgroundImage:[UIImage imageNamed:@"login_btn_"] forState:UIControlStateHighlighted];
    //设置按钮开始为不可以点击
    _loginbtn.enabled=NO;
    
    //注册用户名和密码是否输入的通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldIsNull:) name:UITextFieldTextDidChangeNotification object:nil];
}



//登陆事件
- (IBAction)login:(id)sender {
    MBProgressHUD *hud = (MBProgressHUD *)[self.view viewWithTag:kMBProgressTag];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"登陆中...";
    [hud show:YES];
    [hud hide:YES afterDelay:10.0f];
    
    
    //异步登陆验证用户名和密码是否合法
    //登陆
    [UserService logInWithUsernameInBackground:_loginTf.text password:_pwdTf.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.labelText = @"用户名或者密码输入错误";
                hud.mode = MBProgressHUDModeText;
                [hud show:YES];
                [hud hide:YES afterDelay:0.7f];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                
            });
            //获取好友列表
            [UserService saveFriendsList];
            //推出改页面
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRoot" object:nil];
        }
    }];
    
    
    
    
}


//通知回调
-(void)textFieldIsNull:(NSNotification*)noti{
    
  
    if ([_loginTf.text length ] == 0 ||[_pwdTf.text length ]==0 ) {
        _loginbtn.enabled = NO;
    }else{
        _loginbtn.enabled = YES;
    }
}

@end
