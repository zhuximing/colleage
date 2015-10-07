//
//  UserCenterVC.m
//  colleage
//
//  Created by Apple on 15/10/6.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "UserCenterVC.h"
#import "CommonUtil.h"
#import <BmobIM/BmobIM.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LoginViewController.h"
@interface UserCenterVC ()
{
    BOOL islogin;
    UIButton *rightBtn;
}
@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"用户中心"];
    
    //判断登陆与否
    

    NSString *flag=[[NSUserDefaults standardUserDefaults] objectForKey:@"islogin"];
    if ([flag isEqualToString:@"yes"]) {
        islogin=YES;
    }else{
    
        islogin=NO;
    }
    
    
    //uiview边框
    _user_center.layer.borderColor=[UIColor grayColor].CGColor;
    _user_center.layer.borderWidth=1.0f;
    
    
    //uiview的点击事件
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(to_edit_user_info)];
    _user_center.userInteractionEnabled=YES;
    [_user_center addGestureRecognizer:singleTap];
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    
    rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
     [rightBtn addTarget:self action:@selector(xx) forControlEvents:UIControlEventTouchUpInside];
     UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    [self setImgAndNameAndPhone];
    
    
   
    
    
}





//点击跳到编辑用户信息界面
-(void)to_edit_user_info{
    
    if (!islogin) {//跳到登陆界面
        LoginViewController *loginVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{//跳到用户信息界面
        
    
    }

}


//判断是否登陆  登陆填充用户信息 没登陆不填写
-(void)setImgAndNameAndPhone{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *url=[NSString stringWithFormat:@"%@%@",HEADIMGURL,[userDefault objectForKey:@"user_img"]];
    [_head_img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"setting_head"]] ;
        
    _user_name.text=[userDefault objectForKey:@"user_name"];
    _user_phone.text=[userDefault objectForKey:@"user_phone"];
        
    //刷新islogin
    NSString *flag=[[NSUserDefaults standardUserDefaults] objectForKey:@"islogin"];
    if ([flag isEqualToString:@"yes"]) {
        islogin=YES;
    }else{
        
        islogin=NO;
    }
    
    if (islogin) {
        
      
        [rightBtn setTitle:@"退出" forState:UIControlStateNormal];
       
    }else{
    
         [rightBtn setTitle:@"登陆" forState:UIControlStateNormal];
    }

   

}

//点击导航栏右边 退出或者登陆
-(void)xx{
    
    if (!islogin) {//未登陆
        LoginViewController *loginVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        loginVC.delegate=self;
        [self.navigationController pushViewController:loginVC animated:YES];
        
        
    }else{//已经登陆
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"确定退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        
        [alert show];
        
    }
    

}

//退出登录
-(void)logout{
    
    [BmobUser logout];
    
    [[BmobDB currentDatabase] clearAllDBCache];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user_id"];
    [defaults removeObjectForKey:@"user_name"];
    [defaults removeObjectForKey:@"user_phone"];
    [defaults removeObjectForKey:@"user_school"];
    [defaults setObject:@"no" forKey:@"islogin"];
    //刷新
    [self setImgAndNameAndPhone];
}

//uialertview的代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self logout];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
