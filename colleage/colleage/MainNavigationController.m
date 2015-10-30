//
//  MainNavigationController.m
//  waimai
//
//  Created by sks on 15/10/20.
//  Copyright (c) 2015年 QTTD. All rights reserved.
//

#import "MainNavigationController.h"


@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationBar.barTintColor = [UIColor orangeColor];
    
    
}

// 状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent ;
}
//重写push方法，统一设置导航栏左右按钮
/**-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.navigationBar.barTintColor = [UIColor orangeColor];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    
    if(self.childViewControllers.count > 0)
     {
        viewController.hidesBottomBarWhenPushed = YES ;
         viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
         viewController.automaticallyAdjustsScrollViewInsets = NO ;
     }
    [super pushViewController:viewController animated:YES];
    
}*/
-(void)back
{
    
    [self popViewControllerAnimated:YES];
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
