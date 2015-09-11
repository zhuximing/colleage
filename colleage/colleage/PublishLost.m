//
//  PublishLost.m
//  colleage
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishLost.h"
#import "CommonUtil.h"
@interface PublishLost ()

@end

@implementation PublishLost

- (void)viewDidLoad {
    [super viewDidLoad];
    // 标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布失物招领"];
    
    //登陆按钮的状态enable和disable的背景图片不一样
    [_submit_brn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_submit_brn setBackgroundImage:[UIImage imageNamed:@"login_btn_"] forState:UIControlStateHighlighted];
    //设置按钮开始为不可以点击
    _submit_brn.enabled=NO;
    
    //注册用户名和密码是否输入的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldIsNull:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    
}

//通知回调
-(void)textFieldIsNull:(NSNotification*)noti{
    
    
    if ([_lost_address.text length ] == 0 ||[_lost_name.text length ]==0 ) {
        _submit_brn.enabled = NO;
        //[self showToast:@"请输入名称和详情"];
    }else{
        _submit_brn.enabled = YES;
    }
}

//提交发布
- (IBAction)publish_lost:(id)sender {
    
    [self showProgressing:@"正在提交数据"];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
    //发布者
    NSString *publisher=@"25";
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:_lost_address.text,@"lost_address",_lost_name.text,@"lost_name",publisher,@"lost_picker", nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"lost/do_publish" params:parames httpMethod:@"POST"];
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
