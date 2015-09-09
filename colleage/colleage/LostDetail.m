//
//  LostDetail.m
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LostDetail.h"

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
