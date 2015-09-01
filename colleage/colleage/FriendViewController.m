//
//  FriendViewController.m
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "FriendViewController.h"
#import "CommonUtil.h"
#import <BmobIM/BmobDB.h>
#import "LoginViewController.h"
@interface FriendViewController ()

@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"朋友"];
   
    
    
    
    
    
    
    //self.navigationController.navigationBar.translucent = NO;
    
    
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    
    //初始化tableview组件
    _chatTableView                = [[UITableView alloc] init];
    _chatTableView.frame          = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49);
    _chatTableView.dataSource     = self;
    _chatTableView.delegate       = self;
    _chatTableView.rowHeight      = 80;
    _chatTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_chatTableView];
    
    //在登陆的情况下异步加载消息
    [self ifLoginloadRecent];
}


-(void)ifLoginloadRecent{
    
    
    BmobUser *user = [BmobUser getCurrentUser];
    if (!user) {//没有登录
        [CommonUtil needLoginWithViewController:self animated:YES];
   
    
    }else{     //已经登陆
        [self performSelector:@selector(search) withObject:nil afterDelay:0.7f];
        //if (!_isUpdateLocation) {
        //    [self performSelector:@selector(updateLocation) withObject:nil afterDelay:0.7f];
       // }
    }
    
}

//搜索本人的消息
-(void)search{
    NSArray *array = [[BmobDB currentDatabase] queryRecent];
    
    if (array) {
        
        [_chatsArray setArray:array];
        [_chatTableView reloadData];
        
        
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

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return nil;
}



@end
