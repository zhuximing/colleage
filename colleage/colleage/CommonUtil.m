//
//  CommonUtil.m
//  colleage
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil
//定义navigationItem的title
+(UILabel*)navigationTitleViewWithTitle:(NSString *)title{
    
    UILabel *titleLabel        = [[UILabel alloc] init];
    titleLabel.frame           = CGRectMake(100, 0, 120, 44);
    titleLabel.font            = [UIFont boldSystemFontOfSize:20];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = title;
    titleLabel.textColor       = [UIColor whiteColor];
    return titleLabel;
}


//自定义返回按钮,以及点击事件
-(void)customBack:(UIViewController*)controller{
  
    
    UIView *homeButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    
    UIButton *homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
    [homeButton setTitle:@"返回" forState:UIControlStateNormal];
    // homeButton.backgroundColor = [UIColor blackColor];
    [homeButton addTarget:controller action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [homeButtonView addSubview:homeButton];
    
    
    UIBarButtonItem *uiBarButton=[[UIBarButtonItem alloc] initWithCustomView:homeButtonView];
    controller.navigationItem.leftBarButtonItem=uiBarButton;
  
    
}




//设置字体
+(UIFont*)setFontSize:(CGFloat)size{
    return [UIFont systemFontOfSize:size];
}

//判断是否登陆，如果没有登陆直接跳到登陆界面

+(void)needLoginWithViewController:(UIViewController*)viewController animated:(BOOL)animated{
    
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] boolValue]) {
       
        /**
        //获取故事版
        UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //  获取登陆界面的视图控制器
        UINavigationController *nav=[story instantiateViewControllerWithIdentifier:@"loginNav"];
        
        [viewController presentViewController:nav animated:YES completion:^{
            
        }];*/
        
        
        [viewController performSegueWithIdentifier:@"login" sender:nil];
      
    }
    
}

@end
