//
//  FriendViewController.m
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "FriendViewController.h"
#import "CommonUtil.h"
@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"朋友"];
    self.title=@"朋友";
    self.view.backgroundColor=[UIColor blackColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        if (IS_iOS7) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _chatsArray = [[NSMutableArray alloc] init];
    }
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
