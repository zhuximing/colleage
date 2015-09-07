//
//  RootViewController.m
//  BmobIMDemo
//
//  Created by Bmob on 14-6-25.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "RootViewController.h"
#import <BmobIM/BmobIM.h>
#import "UsercenterLogin.h"



@implementation RootViewController


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
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
//    [self.tabBar setHidden:YES];
//
    self.delegate = self;
    
    
    
    UIImageView *barImageView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, ScreenWidth, 49)];
    barImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    barImageView.userInteractionEnabled = true;
    barImageView.backgroundColor = [UIColor blueColor];
    barImageView.image = [UIImage imageNamed:@"foot_bar"];
    [self.tabBar addSubview:barImageView];
    
    [self performSelector:@selector(setUpViews) withObject:nil afterDelay:0.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpViews{
    
    [self.tabBar setHidden:NO];
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ScreenWidth/5*i, 0, ScreenWidth/5, 49);
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_icon1"]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_icon_1"]] forState:UIControlStateSelected];
        btn.tag = i+100;
        
        btn.exclusiveTouch = true;
        btn.userInteractionEnabled = YES;
        [[btn titleLabel] setTextAlignment:1];
        [btn setTitleColor:RGB(142.0f, 146.0f, 148.0f, 1.0f) forState:UIControlStateNormal];
        [btn setTitleColor:RGB(86.0f, 162.0f, 246.0f, 1.0f) forState:UIControlStateSelected];
        [[btn titleLabel] setFont:[UIFont systemFontOfSize:12]];
        [btn addTarget:self action:@selector(didTapTabbar:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (i == 0) {
            btn.selected = YES;
            
        }
        
        [self.tabBar addSubview:btn];
    }
}

#pragma mark - button

-(void)didTapTabbar:(UIButton * )sender{

    for (int i= 0; i<5; i++) {
        UIButton  *btn = (UIButton*)[self.tabBar viewWithTag:100+i];
        btn.selected = NO;
        btn.userInteractionEnabled = YES;
    }
    
    //如果点击的事个人中心
//    if (sender.tag==104) {
//        BmobUser *user = [BmobUser getCurrentUser];
//        
//        //获取故事版
//        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        //获取用户中心的导航控制器
//        UINavigationController *nav=[story instantiateViewControllerWithIdentifier:@"usercenternav"];
//        
//        
//        //  获取登陆后的个人中心的视图控制器
//        UIViewController *login=[story instantiateViewControllerWithIdentifier:@"loginvc"];
//        //  获取没有登陆的个人中心的视图控制器
//        UIViewController *notlogin=[story instantiateViewControllerWithIdentifier:@"notloginvc"];
//       
//        if (!user) {//没有登录
//           // [(UINavigationController*)self.selectedViewController pushViewController:notlogin animated:NO];
//            [nav setViewControllers:@[notlogin]];
//            NSLog(@"NO%@",nav);
//            
//           
//            
//        }else{
//            [nav setViewControllers:@[login]];
//             //[(UINavigationController*)self.selectedViewController pushViewController:login animated:NO];
//            NSLog(@"YES");
//            NSLog(@"NO%@",nav);
//        }
//    }
//
//    
//    
//    
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    
   [self setSelectedIndex:sender.tag -100];
   
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{





}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"!!!!!");
    //if(viewController==self.viewControllers[4])
    
    if ([viewController.tabBarItem.title isEqualToString:@"个人中心"]) {
        
        BmobUser *user = [BmobUser getCurrentUser];
        
        NSLog(@">>>>%@",user);
        if (!user) {//未登陆
//            //获取故事版
//            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            
//            
//            
//            //  获取登陆后的个人中心的视图控制器
//            //UIViewController *login=[story instantiateViewControllerWithIdentifier:@"loginvc"];
//            //  获取没有登陆的个人中心的视图控制器
//            UIViewController *notlogin=[story instantiateViewControllerWithIdentifier:@"notloginvc"];
//            
//            
//            [(UINavigationController *)tabBarController.selectedViewController pushViewController:notlogin animated:NO];
            return YES;

          
        }else{//已经登陆
            //获取故事版
            UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            
            
            //  获取登陆后的个人中心的视图控制器
            UIViewController *login=[story instantiateViewControllerWithIdentifier:@"loginvc"];
            //  获取没有登陆的个人中心的视图控制器
            // UIViewController *notlogin=[story instantiateViewControllerWithIdentifier:@"notloginvc"];

            
            [(UINavigationController *)tabBarController.selectedViewController pushViewController:login animated:NO];
            return NO;
        }
        
    }else{
    
        return YES;
    }
    
    
    

    
}



-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

   
   
    NSLog(@"####");
    
    
   
    
//    
//    for (int i= 0; i<3; i++) {
//        UIButton  *btn = (UIButton*)[self.tabBar viewWithTag:100+i];
//        btn.selected = NO;
//        btn.userInteractionEnabled = YES;
//    }
//    
//    if ([[navigationViewController topViewController] isKindOfClass:[RecentViewController class]]) {
//        
//        UIButton  *btn = (UIButton*)[self.tabBar viewWithTag:100+0];
//        btn.selected = YES;
//        btn.userInteractionEnabled = NO;
//    }else if([[navigationViewController topViewController] isKindOfClass:[ContactsViewController class]]){
//        UIButton  *btn = (UIButton*)[self.tabBar viewWithTag:100+1];
//        btn.selected = YES;
//        btn.userInteractionEnabled = NO;
//    }else if([[navigationViewController topViewController] isKindOfClass:[SettingViewController class]]){
//        UIButton  *btn = (UIButton*)[self.tabBar viewWithTag:100+2];
//        btn.selected = YES;
//        btn.userInteractionEnabled = NO;
//    }
//    
//    
}
@end
