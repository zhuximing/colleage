//
//  UsercenterNoLogin.m
//  colleage
//
//  Created by Apple on 15/9/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "UsercenterNoLogin.h"
#import "CommonUtil.h"
#import <BmobIM/BmobIM.h>
#import "UsercenterLogin.h"
@interface UsercenterNoLogin ()

@end
@implementation UsercenterNoLogin


//-(void) loadView {
//    [super loadView];
//    
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"个人中心"];
    self.title=@"个人中心";
   BmobUser *user = [BmobUser getCurrentUser];
    if (!user) {//未登陆
        
        NSLog(@"notlogin");
    }else{//已经登陆
        NSLog(@"login");
        
        
                //获取故事版
                UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        
                //  获取登陆后的个人中心的视图控制器
                UIViewController *login=[story instantiateViewControllerWithIdentifier:@"loginvc"];
                //  获取没有登陆的个人中心的视图控制器
               // UIViewController *notlogin=[story instantiateViewControllerWithIdentifier:@"notloginvc"];

        
         [self.navigationController initWithRootViewController:login];
        
        
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRoot) name:@"changeRoot" object:nil];
    }
    
    
   
    
}

-(void)changeRoot{
    
    NSLog(@"ok");
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    
    //  获取登陆后的个人中心的视图控制器
    UIViewController *login=[story instantiateViewControllerWithIdentifier:@"loginvc"];
    //  获取没有登陆的个人中心的视图控制器
    // UIViewController *notlogin=[story instantiateViewControllerWithIdentifier:@"notloginvc"];
    
    
    [self.navigationController initWithRootViewController:login];

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
