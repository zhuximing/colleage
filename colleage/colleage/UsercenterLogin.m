//
//  UsercenterLogin.m
//  colleage
//
//  Created by Apple on 15/9/5.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "UsercenterLogin.h"
#import <BmobIM/BmobIM.h>
#import "CommonUtil.h"
@interface UsercenterLogin ()

@end

@implementation UsercenterLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    
    
    
    //隐藏返回按钮
    self.navigationItem.hidesBackButton=YES;
}
- (IBAction)logout:(id)sender {
    [BmobUser logout];
    
    [[BmobDB currentDatabase] clearAllDBCache];
    
    [CommonUtil needLoginWithViewController:self animated:NO];
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
