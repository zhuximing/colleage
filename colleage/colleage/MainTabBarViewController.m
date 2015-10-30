//
//  MainTabBarViewController.m
//  waimai
//
//  Created by sks on 15/10/20.
//  Copyright (c) 2015年 QTTD. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addItems];
    [self changeItemTextColourAndFont];
    
}

#pragma mark -- 添加试图
-(void)addItems
{
   
    NSArray*titleArr = @[@"首页",@"约起来",@"消息",@"个人中心"];
    NSArray*picArr = @[@"home",@"yue",@"xiaoxi",@"mine"];
    NSArray*picSelectArr = @[@"home_s",@"yue_s",@"xiaoxi_s",@"mine_s"];
    
    for(int i = 0 ;i < 4 ;i++)
    {
         [self addChildVc:titleArr[i] image:picArr[i] selectedImage:picSelectArr[i]];
    }
    
    
}

#pragma mark -- 添加子控制器
-(void)addChildVc:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    if ([title isEqualToString:@"首页"]) {
        
        //获取登陆后的个人中心的导航控制器
        UINavigationController *aa=[story instantiateViewControllerWithIdentifier:@"homeNav"];
        
        //设置根视图控制器
        aa.title = title ;
        aa.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        aa.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        
        
        [self addChildViewController:aa];
    }if ([title isEqualToString:@"约起来"]) {
        
        //获取登陆后的个人中心的导航控制器
        UINavigationController *aa=[story instantiateViewControllerWithIdentifier:@"yueNav"];
        
        //设置根视图控制器
        aa.title = title ;
        aa.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        aa.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        
        
        [self addChildViewController:aa];
    }if ([title isEqualToString:@"消息"]) {
        
        //获取登陆后的个人中心的导航控制器
        UINavigationController *aa=[story instantiateViewControllerWithIdentifier:@"xiaoxiNav"];
        
        //设置根视图控制器
        aa.title = title ;
        aa.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        aa.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        
        
        [self addChildViewController:aa];
    }
    if ([title isEqualToString:@"个人中心"]) {
        
        //获取登陆后的个人中心的导航控制器
        UINavigationController *aa=[story instantiateViewControllerWithIdentifier:@"centerNav"];
       
        //设置根视图控制器
        aa.title = title ;
        aa.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        aa.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode :UIImageRenderingModeAlwaysOriginal];
        
       
        [self addChildViewController:aa];
    }
    
}

#pragma mark -调整item的文字颜色和字体大小
-(void)changeItemTextColourAndFont
{
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} forState:UIControlStateNormal];
    
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]} forState:UIControlStateSelected];
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
