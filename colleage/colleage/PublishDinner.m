//
//  PublishDinner.m
//  colleage
//
//  Created by Apple on 15/9/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishDinner.h"
#import "CommonUtil.h"
@interface PublishDinner ()

@end

@implementation PublishDinner

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布一起吃饭"];
    
    
    
    //图片点击选择地址的事件
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choose_address)];
    
    _address.userInteractionEnabled=YES;
   [_address addGestureRecognizer:singleTap];
    
}

//选择地址
-(void)choose_address{
    NSLog(@"!!!!!");


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
