//
//  PublishHelp.m
//  colleage
//
//  Created by Apple on 15/9/12.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishHelp.h"
#import "CommonUtil.h"
@interface PublishHelp ()

@end

@implementation PublishHelp

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布需求"];
    
    
    //textview的外边框
    _help_detail.layer.borderColor=[UIColor grayColor].CGColor;
    _help_detail.layer.borderWidth=1.0;
    _help_detail.layer.cornerRadius=5.0;
    
}

//添加需求
- (IBAction)addHelp:(id)sender {
    if (_help_title.text.length==0) {
        [self showToast:@"请输入标题"];
        return;
    }
    if (_help_reward.text.length==0) {
        [self showToast:@"请输入报酬"];
        return;
    }
    if (_help_detail.text.length==0) {
        [self showToast:@"请输入详情"];
        return;
    }
    [self showProgressing:@"正在提交数据"];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
    //发布者
    NSString *publisher=@"25";
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:_help_title.text,@"help_title",_help_detail.text,@"help_detail",publisher,@"user_id",_help_reward.text,@"help_reward", nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"help/do_publish" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        [self hide];
        [self showToast:@"恭喜你，发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
        [self hide];
    }];
    
    [engine enqueueOperation:op];
    
    
    
    
    
    
    
    
    
}

//uitextfield代理方法
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}
//uitextview代理方法
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;


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
