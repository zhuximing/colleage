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

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    [hud hide:YES afterDelay:0.7f];
}

//隐藏
-(void)hide{
    [hud hide:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
