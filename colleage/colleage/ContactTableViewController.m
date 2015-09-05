//
//  ContactTableViewController.m
//  colleage
//
//  Created by Apple on 15/9/2.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ContactTableViewController.h"
#import "CommonUtil.h"
#import <BmobSDK/Bmob.h>
#import <BmobIM/BmobIM.h>
#import "RecentTableViewCell.h"
#import "ContactHeaderView.h"
#import "ChatViewController.h"
#import "SearchViewController.h"
@implementation ContactTableViewController

//初始化
-(instancetype)init{
    self=[super init];
    if (self) {
        if (IS_iOS7) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        _friendsArray = [[NSMutableArray alloc] init];
    }

    return self;
}


//加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"联系人"];
   
    //返回按钮
    [[[CommonUtil alloc] init] customBack:self];
    
    //右边添加联系人的按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightBtn setImage:[UIImage imageNamed:@"contact_add"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"contact_add_"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(addContact) forControlEvents:UIControlEventTouchUpInside];
    if (IS_iOS7) {
        [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    }
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    

    //tableview的头部
     [self performSelector:@selector(initTableViewHeaderView) withObject:nil afterDelay:0.1f];
    
    //设置tableview的相关属性
    self.tableView.rowHeight=80;
    
    
   
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//初始化tableview的头部
-(void)initTableViewHeaderView{
    //消息头部
    UIView *headerView                    = [[UIView alloc] init];
    headerView.frame                      = CGRectMake(0, 0, ScreenWidth, 140);
    //好友通知
    ContactHeaderView *friendView         = [[ContactHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
    friendView.iconImageView.image        = [UIImage imageNamed:@"message_icon"];
    friendView.titleLabel.text            = @"好友通知";
    friendView.lineImageView.image        = [UIImage imageNamed:@"common_line"];
    friendView.arrowImageView.image =[UIImage imageNamed:@"common_jt"];
    [headerView addSubview:friendView];
    friendView.userInteractionEnabled     = YES;
    //UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNewFriends:)];
    //[friendView addGestureRecognizer:tapRecognizer];
    
    //附近的人
    ContactHeaderView *nearbyView         = [[ContactHeaderView alloc] initWithFrame:CGRectMake(0, 70, 320, 70)];
    nearbyView.iconImageView.image        = [UIImage imageNamed:@"message_icon"];
    nearbyView.titleLabel.text            = @"附近的人";
    nearbyView.lineImageView.image        = [UIImage imageNamed:@"common_line"];
    nearbyView.arrowImageView.image       =[UIImage imageNamed:@"common_jt"];
    [headerView addSubview:nearbyView];
    nearbyView.userInteractionEnabled     = YES;
    //UITapGestureRecognizer *tapNearbyRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNearby:)];
    //[nearbyView addGestureRecognizer:tapNearbyRecognizer];
    
    
    [self.tableView setTableHeaderView:headerView];
}

//添加联系人，跳转到SearchViewController页面去
-(void)addContact{
    SearchViewController *svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}





//视图出现了
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(search) withObject:nil afterDelay:0.5f];
}

//查找联系人
-(void)search{
    NSArray *array = [[BmobDB currentDatabase] contaclList];
    
    if (array) {
        _friendsArray=array;
        
        [self.tableView reloadData];
        
    }
   }







//返回按钮的点击事件
-(void)returnAction{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _friendsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    RecentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[RecentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.chatUser=[_friendsArray objectAtIndex:indexPath.row];
    
    return cell;
}

//条目点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击返回来的时候该条目不被选中，当然uitableviewcontroller似乎默认不选中。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self chatWithSB:indexPath];



}


//进入聊天界面
-(void)chatWithSB:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    BmobChatUser *user = (BmobChatUser *)[_friendsArray objectAtIndex:indexPath.row];
    [infoDic setObject:user.objectId forKey:@"uid"];
    [infoDic setObject:user.username forKey:@"name"];
    if (user.avatar) {
        [infoDic setObject:user.avatar forKey:@"avatar"];
    }
    if (user.nick) {
        [infoDic setObject:user.nick forKey:@"nick"];
    }
    ChatViewController *cvc = [[ChatViewController alloc] initWithUserDictionary:infoDic];
    [self.navigationController pushViewController:cvc animated:YES];
    
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
