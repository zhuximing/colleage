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
#import "RecentTableViewCell.h"
#import "ContactTableViewController.h"
#import "ChatViewController.h"
@interface FriendViewController ()

@end

@implementation FriendViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        if (IS_iOS7) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _chatsArray = [[NSMutableArray alloc] init];//初始化s
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //头部标题
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"朋友"];
    //tab标题
    self.title=@"朋友";
    
    
    
    //右边的按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setTitle:@"联系人" forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(myContact) forControlEvents:UIControlEventTouchUpInside];
   
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
        [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
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

/**
 *判断是否登陆
 */
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
        
        _chatsArray=array;
        [_chatTableView reloadData];
        
        NSLog(@"count%d",_chatsArray.count);
    }
    NSLog(@"!!!count%d",array.count);
}


//跳转到联系人视图控制器
-(void)myContact{
    
    [self performSegueWithIdentifier:@"contact" sender:nil];
    
    
    
}





#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _chatsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    RecentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[RecentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.recent=[_chatsArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate methods

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteChat:indexPath];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self chatWithSB:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)chatWithSB:(NSIndexPath *)indexPath{
    BmobRecent *recent = (BmobRecent *)[_chatsArray objectAtIndex:indexPath.row];
    
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    
    [infoDic setObject:recent.targetId forKey:@"uid"];
    [infoDic setObject:recent.targetName forKey:@"name"];
    
    if (recent.nick) {
        [infoDic setObject:recent.nick forKey:@"nick"];
    }
    
    if (recent.avatar) {
        [infoDic setObject:recent.avatar forKey:@"avatar"];
    }
    
    
    ChatViewController *cvc = [[ChatViewController alloc] initWithUserDictionary:infoDic];
    [self.navigationController pushViewController:cvc animated:YES];
    
}


-(void)deleteChat:(NSIndexPath *)indexPath{
    
    BmobRecent *recent = (BmobRecent *)[_chatsArray objectAtIndex:indexPath.row];
    
    [[BmobDB currentDatabase] deleteRecentWithUid:recent.targetId];
    
    [_chatsArray removeObject:recent];
    [_chatTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
    
}

@end
