//
//  NextTableViewController.m
//  colleage
//
//  Created by Apple on 15/9/8.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextTableViewController.h"

@interface NextTableViewController ()

@end

@implementation NextTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化加载器
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
    //自定义返回按钮
    self.navigationItem.hidesBackButton   = YES;
    UIButton *leftBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame                         = CGRectMake(0, 0, 50, 44);
    leftBtn.showsTouchWhenHighlighted     = YES;
    [leftBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    if (IS_iOS7) {
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        
        // self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
}
//显示加载器
-(void) showProgressing:(NSString*)info{
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = info;
    [hud show:YES];
    //[hud hide:YES afterDelay:10.0f];
}

//显示吐司
-(void) showToast:(NSString*)info{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    [hud show:YES];
    [hud hide:YES afterDelay:0.7f];
}

//隐藏
-(void)hide{
    [hud hide:YES];
}

//返回
-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}

//通过故事版获取视图控制器
-(id)getViewController:(NSString *) identify{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取登陆后的个人中心的视图控制器
    return [story instantiateViewControllerWithIdentifier:identify];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
