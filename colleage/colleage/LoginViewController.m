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
    //imageView.frame=CGRectMake(8, 2, 20, 20);
    _loginTf.leftView=imageView;
    _loginTf.leftViewMode=UITextFieldViewModeAlways;
    
    //密码输入框的左边图片
    UIImage *image1=[UIImage imageNamed:@"login_key"];
    UIImageView *imageView1=[[UIImageView alloc ] initWithImage:image1];
    _pwdTf.leftView=imageView1;
    _pwdTf.leftViewMode=UITextFieldViewModeAlways;
    
    
    
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
  
    [self showProgressing:@"正在登陆中...."];
    
    
    //异步登陆验证用户名和密码是否合法
    //登陆
    [UserService logInWithUsernameInBackground:_loginTf.text password:_pwdTf.text block:^(BmobUser *user, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self showToast:@"用户名或者密码输入错误"];
            });
            
        }else{
            //获取好友列表
            [UserService saveFriendsList];
            //再到自己的服务器做再一步验证
            [self checkUserInfo];
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


//自己的服务器上验证登陆
-(void)checkUserInfo{
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
   
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:_loginTf.text,@"user_phone",
        _pwdTf.text,@"user_password", nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"welcome/login" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        [self hide];
        
        id json=[completedOperation responseJSON];
        //加载到的数据
        NSDictionary *array=(NSDictionary*)json;
        //保存用户信息
        [self saveUserInfo:array];
        
        //回调
        [self.delegate setImgAndNameAndPhone];
        
        //退出该页面
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } onError:^(NSError *error) {
        
        [self showToast:@"用户名或者密码输入错误"];
    }];
    
    [engine enqueueOperation:op];



}

//保存用户信息
-(void) saveUserInfo:(NSDictionary*)user{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:[user objectForKey:@"user_id"] forKey:@"user_id"];
    [defaults setObject:[user objectForKey:@"user_name"] forKey:@"user_name"];
    [defaults setObject:[user objectForKey:@"user_phone"] forKey:@"user_phone"];
    [defaults setObject:[user objectForKey:@"user_school"] forKey:@"user_school"];
   
    
    //是否登陆的标记
    [defaults setObject:@"yes" forKey:@"islogin"];

    
}




//回车隐藏键盘 代理
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}




@end
