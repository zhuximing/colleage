//
//  NextViewController.m
//  BmobIMDemo
//
//  Created by zhuximing on 14-6-25.
//  Copyright (c) 2014年 bmob. All rights reserved.
/**
 本类是很多视图控制器共有的东西抽出来放在这里
 比如：自定义返回按钮以及点击事件
 
 
 */
#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化加载器
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
    //自定义返回按钮
    self.navigationItem.hidesBackButton   = YES;
    UIButton *leftBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame                         = CGRectMake(0, 0, 50, 44);
    leftBtn.showsTouchWhenHighlighted     = YES;
    [leftBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    if (IS_iOS7) {
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
}

//返回
-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}


//显示加载器
-(void) showProgressing:(NSString*)info{
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = info;
    [hud show:YES];
    //[hud hide:YES afterDelay:10.0f];
}

//显示吐司
-(void) showToast:(NSString*)info{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
}

//隐藏
-(void)hide{
    [hud hide:YES];
}
//一般性的弹出框，不带事件的
- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];  
    
}

//通过故事版获取视图控制器
-(id)getViewController:(NSString *) identify{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取登陆后的个人中心的视图控制器
    return [story instantiateViewControllerWithIdentifier:identify];


}



@end
