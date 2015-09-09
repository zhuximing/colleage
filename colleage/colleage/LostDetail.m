//
//  LostDetail.m
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LostDetail.h"
#import "CommonUtil.h"
#import <BmobIM/BmobIM.h>
#import <BmobSDK/Bmob.h>
#import "ChatViewController.h"
@interface LostDetail ()

@end

@implementation LostDetail

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"详情"];
    
    
    NSString *url=[NSString stringWithFormat:@"%@/lost/lost_detail/%@",BASEURL,self.lost_id];
      NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    _wb.delegate=self;
    
    [_wb loadRequest:request];
    
   // self.hidesBottomBarWhenPushed
}



#pragma mark -webview delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{

    [self showProgressing:@"正在加载中...."];

}


-(void) webViewDidFinishLoad:(UIWebView *)webView{

    
    [self hide];

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    NSLog(@"%@",error);
    [self showToast:@"加载失败%@"];
}
#pragma mark click event
//打电话
- (IBAction)dial:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"确定拨打?" message:self.user_phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
   }
//发短信
- (IBAction)send:(id)sender {
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:@"10010"];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        
        [self presentModalViewController:controller animated:YES];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}
//聊天
- (IBAction)chat:(id)sender {
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
  
    [[BmobUserManager alloc] queryUserByName:self.user_phone block:^(NSArray *array, NSError *error) {
        if (array) {
            BmobChatUser *user=(BmobUser*)[array objectAtIndex:0];
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
    }];
    
    
}



#pragma  mark alert delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"10010"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        NSLog(@"???????????????????");
    }
   

}


#pragma mark message delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        default:
            break;
    }
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
