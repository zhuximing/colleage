//
//  PublishCar.m
//  colleage
//
//  Created by Apple on 15/9/13.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishCar.h"
#import "CommonUtil.h"
@interface PublishCar ()

@end

@implementation PublishCar
//重载init方法
- (instancetype)init
{
    NSArray *titleArray = @[
                            @"我要车子",
                            @"我有车源",
                           
                            
                            ];
    
    NSArray *classNames = @[
                            @"IHasCarPublish",
                            @"INeedCarPublish",
                            
                            
                            ];
    
    
    if (self = [super initWithTitles:titleArray andSubViewdisplayClassNames:classNames andTagViewHeight:49]) {
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"线路发布"];
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
