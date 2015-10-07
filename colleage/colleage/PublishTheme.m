//
//  PublishTheme.m
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishTheme.h"
#import "CDPDatePicker.h"
#import "SelectSport.h"
#import "CommonUtil.h"
@interface PublishTheme (){
    CDPDatePicker *_datePicker;
    UIActionSheet *time_action;
    UIActionSheet *target_action;
}

@end

@implementation PublishTheme

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布主题约会"];
    
    //指定时间选择器的代理 和对象
    _datePicker=[[CDPDatePicker alloc] initWithSelectTitle:nil viewOfDelegate:self.view delegate:self];
    
    
    
    //提交按钮
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self setUpTextField];
}
-(void) setUpTextField{
    UIImage *image=[UIImage imageNamed:@"register_bottom_arrow"];
    
    
    
    UIImageView *imageView2=[[UIImageView alloc ] initWithImage:image];
    _time.rightView=imageView2;
    _time.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView3=[[UIImageView alloc ] initWithImage:image];
    _theme.rightView=imageView3;
    _theme.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView4=[[UIImageView alloc ] initWithImage:image];
    _target.rightView=imageView4;
    _target.rightViewMode=UITextFieldViewModeAlways;
    
    
    _detail.layer.borderColor=[UIColor grayColor].CGColor;
    _detail.layer.borderWidth=1.0;
    _detail.layer.cornerRadius=4.0;
}
- (IBAction)choose_time:(id)sender {
    time_action = [[UIActionSheet alloc]
                   initWithTitle:nil
                   delegate:self
                   cancelButtonTitle:@"取消"
                   destructiveButtonTitle:nil
                   otherButtonTitles: @"任意时间", @"周末",@"指定时间",nil];
    
    [time_action showInView:self.view];
    
    
}
- (IBAction)choose_target:(id)sender {
    target_action = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"仅限男生", @"仅限女生",@"男女不限",nil];
    
    [target_action showInView:self.view];
}
- (IBAction)choose_theme:(id)sender {
    SelectSport *ss=[self getViewController:@"SelectSport"];
    ss.delegate=self;
    ss.type=@"theme";
    ss.toast=@"请选择主题";
    ss.biaoti=@"选择主题";
    ss.tishi=@"热门主题";
    ss.placeHolder=@"请输入主题";
    [self.navigationController pushViewController:ss animated:YES];
    
    
}

//actionsheet代理点击选择事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==time_action){
        switch (buttonIndex) {
            case 0:
                _time.text=@"任意时间";
                break;
            case 1:
                _time.text=@"周末";
                break;
            case 2:
                [self the_time];
                break;
            default:
                break;
        }
        
    }else if (actionSheet==target_action){
        switch (buttonIndex) {
            case 0:
                _target.text=@"仅限男生";
                break;
            case 1:
                _target.text=@"仅限女生";
                break;
            case 2:
                _target.text=@"男女不限";
                break;
            default:
                break;
        }
        
    }    
    
}
//主题回调
-(void)getSport:(NSString *)value{

    _theme.text=value;
}
//指定时间
-(void) the_time{
    
    [_datePicker pushDatePicker];
    
}
//日历的代理
-(void)CDPDatePickerDidConfirm:(NSString *)confirmString{
    //[self showToast:confirmString];
    _time.text=confirmString;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_datePicker popDatePicker];
}

//被本类代理的textfield无法输入内容，只能响应点击事件
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==_yue_title||textField==_yue_address){
        return YES;
    }else{
        return NO;
    }
    
}
//回车隐藏键盘 代理
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}
//回车隐藏键盘 代理--文本域
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
    
    
}
//提交
-(void)submit{
    if (_yue_title.text.length==0) {
        [self showToast:@"请输入标题"];
        return;
    }
    if (_yue_address.text.length==0) {
        [self showToast:@"请选择地址"];
        return;
    }
    if (_time.text.length==0) {
        [self showToast:@"请选择时间"];
        return;
    }
    if (_target.text.length==0) {
        [self showToast:@"请选择对象"];
        return;
    }
    if (_theme.text.length==0) {
        [self showToast:@"请选择约会主题"];
        return;
    }
    if (_detail.text.length==0) {
        [self showToast:@"请写点详情"];
        return;
    }
    
    [self showProgressing:@"正在提交数据"];
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
    //发布者
    NSString *publisher=@"21";
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:_yue_title.text,@"yue_title",
                           _yue_address.text,@"yue_address",
                           _time.text,@"yue_time",
                           _target.text,@"yue_target",
                           @"",@"yue_fee_type",
                           _detail.text,@"yue_shuoming",
                           publisher,@"yue_publisher",
                           @"theme",@"yue_type",
                           @"",@"yue_game",
                           @"",@"yue_sport",
                           @"",@"yue_movie",
                           @"",@"yue_start_city",
                           @"",@"yue_way",
                           @"",@"yue_male_count",
                           @"",@"yue_female_count",
                           _theme.text,@"yue_theme",nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"yueba/publish_yue" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        [self hide];
        [self showToast:@"恭喜你，发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
        [self hide];
        [self.navigationController popViewControllerAnimated:YES];
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
