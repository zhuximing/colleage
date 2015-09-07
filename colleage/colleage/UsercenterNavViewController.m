//
//  UsercenterNavViewController.m
//  colleage
//
//  Created by Apple on 15/9/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "UsercenterNavViewController.h"
#import <BmobIM/BmobIM.h>

@implementation UsercenterNavViewController
-(instancetype)init{
    self=[super init];
    BmobUser *user = [BmobUser getCurrentUser];
    if (!user) {//未登陆
        //获取故事版
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        //  获取登陆后的个人中心的视图控制器
        //UIViewController *login=[story instantiateViewControllerWithIdentifier:@"loginvc"];
        //  获取没有登陆的个人中心的视图控制器
        UIViewController *notlogin=[story instantiateViewControllerWithIdentifier:@"notloginvc"];
        
        
        [self.view addSubview:notlogin.view];
        
        
    }else{//已经登陆
        //获取故事版
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
        //  获取登陆后的个人中心的视图控制器
        UIViewController *login=[story instantiateViewControllerWithIdentifier:@"loginvc"];
        //  获取没有登陆的个人中心的视图控制器
        // UIViewController *notlogin=[story instantiateViewControllerWithIdentifier:@"notloginvc"];
        
        [self.view addSubview:login.view];
        

        
    }
    
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    }


-(id)initWithRootViewController:(UIViewController *)rootViewController{
    
    
    
    
    
    return self;
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
