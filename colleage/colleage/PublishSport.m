//
//  PublishGame.m
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishSport.h"
#import "CDPDatePicker.h"
#import "CommonUtil.h"
#import "ChooseText.h"
#import "SelectSport.h"
@interface PublishSport (){

    CDPDatePicker *_datePicker;
    UIActionSheet *address_action;
    UIActionSheet *time_action;
    UIActionSheet *target_action;
   
   
}

@end

@implementation PublishSport

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布一起运动"];
    
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
    
    
    //设置文本框的箭头图标
    [self setUpTextField];
}
-(void) setUpTextField{
    UIImage *image=[UIImage imageNamed:@"register_bottom_arrow"];
    
    UIImageView *imageView=[[UIImageView alloc ] initWithImage:image];
    _address.rightView=imageView;
    _address.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView2=[[UIImageView alloc ] initWithImage:image];
    _time.rightView=imageView2;
    _time.rightViewMode=UITextFieldViewModeAlways;
    
   
    
    UIImageView *imageView4=[[UIImageView alloc ] initWithImage:image];
    _target.rightView=imageView4;
    _target.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView5=[[UIImageView alloc ] initWithImage:image];
    _sport.rightView=imageView5;
    _sport.rightViewMode=UITextFieldViewModeAlways;
    
    _detail.layer.borderColor=[UIColor grayColor].CGColor;
    _detail.layer.borderWidth=1.0;
    _detail.layer.cornerRadius=4.0;
}
//选择地址
- (IBAction)choose_address:(id)sender {
    
    address_action = [[UIActionSheet alloc]
                      initWithTitle:nil
                      delegate:self
                      cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                      otherButtonTitles: @"指定体育馆", @"大概地址",nil];
    
    [address_action showInView:self.view];
    
    
}
//选择时间
- (IBAction)choose_time:(id)sender {
    time_action = [[UIActionSheet alloc]
                   initWithTitle:nil
                   delegate:self
                   cancelButtonTitle:@"取消"
                   destructiveButtonTitle:nil
                   otherButtonTitles: @"任意时间", @"周末",@"指定时间",nil];
    
    [time_action showInView:self.view];
    
    
}
//选择对象
- (IBAction)choose_target:(id)sender {
    target_action = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"仅限男生", @"仅限女生",@"男女不限",nil];
    
    [target_action showInView:self.view];
    
}
//选择体育项目
- (IBAction)choose_game:(id)sender {
    
    SelectSport *ss=[self getViewController:@"SelectSport"];
    ss.delegate=self;
    ss.type=@"sport";
    ss.toast=@"请选择运动项目";
    ss.biaoti=@"选择运动项目";
    ss.tishi=@"你喜欢的运动";
    ss.placeHolder=@"请选择运动项目";
    [self.navigationController pushViewController:ss animated:YES];
}



//actionsheet代理点击选择事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==address_action) {
        switch (buttonIndex) {
            case 0:
                [self showToast:@"暂时不支持,你可以指定地址"];
                break;
            case 1:
                
                [self the_address];
                
                break;
            default:
                break;
        }
    }else if (actionSheet==time_action){
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
//指定地址
-(void) the_address{
    ChooseText *text=[self getViewController:@"ChooseText"];
    text.delegate=self;
    text.biaoti=@"请输入场地";
    text.errorInfo=@"场地不能为空";
    [self.navigationController pushViewController:text animated:YES];
    
}
//地址回调
-(void)getValue:(NSString *)value{
    
    _address.text=value;
}

//运动项目的回调
-(void)getSport:(NSString *)value{

    _sport.text=value;
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
    if(textField==_yue_title){
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
    if (_address.text.length==0) {
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
    if (_sport.text.length==0) {
        [self showToast:@"请选择运动项目"];
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
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:  _yue_title.text,@"yue_title",
                           _address.text,@"yue_address",
                           _time.text,@"yue_time",
                           _target.text,@"yue_target",
                           @"",@"yue_fee_type",
                           _detail.text,@"yue_shuoming",
                           publisher,@"yue_publisher",
                           @"sport",@"yue_type",
                           @"",@"yue_game",
                           _sport.text,@"yue_sport",
                           @"",@"yue_movie",
                           @"",@"yue_start_city",
                           @"",@"yue_way",
                           @"",@"yue_male_count",
                           @"",@"yue_female_count",
                           @"",@"yue_theme",nil];
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
