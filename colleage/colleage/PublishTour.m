//
//  PublishTour.m
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishTour.h"
#import "CDPDatePicker.h"
#import "CommonUtil.h"
#import "SelectSport.h"
@interface PublishTour (){
    CDPDatePicker *_datePicker;
    UIActionSheet *target_action;
    UIActionSheet *fee_action;
    UIActionSheet *way_action;

}

@end

@implementation PublishTour

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布一起出游"];
    
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
    
       
    UIImageView *imageView2=[[UIImageView alloc ] initWithImage:image];
    _end_city.rightView=imageView2;
    _end_city.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView3=[[UIImageView alloc ] initWithImage:image];
    _fee.rightView=imageView3;
    _fee.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView4=[[UIImageView alloc ] initWithImage:image];
    _target.rightView=imageView4;
    _target.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView5=[[UIImageView alloc ] initWithImage:image];
    _start_time.rightView=imageView5;
    _start_time.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView6=[[UIImageView alloc ] initWithImage:image];
    _way.rightView=imageView6;
    _way.rightViewMode=UITextFieldViewModeAlways;
    
    _detail.layer.borderColor=[UIColor grayColor].CGColor;
    _detail.layer.borderWidth=1.0;
    _detail.layer.cornerRadius=4.0;
}
//选择目的地
- (IBAction)choose_end_city:(id)sender {
    
    SelectSport *ss=[self getViewController:@"SelectSport"];
    ss.delegate=self;
    ss.type=@"tour";
    ss.toast=@"请选择目的景点/城市";
    ss.biaoti=@"选择目的景点/城市";
    ss.tishi=@"热门景点/城市";
    ss.placeHolder=@"请选择目的景点/城市";
    [self.navigationController pushViewController:ss animated:YES];
    
    
}
//目的地回调
-(void)getSport:(NSString *)value{
    _end_city.text=value;

}
//出发时间
- (IBAction)choose_start_time:(id)sender {
    [_datePicker pushDatePicker];
 
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
- (IBAction)choose_fee:(id)sender {
    fee_action = [[UIActionSheet alloc]
                  initWithTitle:nil
                  delegate:self
                  cancelButtonTitle:@"取消"
                  destructiveButtonTitle:nil
                  otherButtonTitles: @"AA制", @"我请客",nil];
    
    [fee_action showInView:self.view];
}
- (IBAction)choose_way:(id)sender {
    way_action = [[UIActionSheet alloc]
                  initWithTitle:nil
                  delegate:self
                  cancelButtonTitle:@"取消"
                  destructiveButtonTitle:nil
                  otherButtonTitles: @"自驾", @"火车",@"飞机",nil];
    
    [way_action showInView:self.view];
}

//actionsheet代理点击选择事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if (actionSheet==target_action){
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
        
     }else if (actionSheet==fee_action){
         switch (buttonIndex) {
             case 0:
                 _fee.text=@"AA制";
                 break;
             case 1:
                 _fee.text=@"我请客";
                 break;
             default:
                 break;
         }
     }else if (actionSheet==way_action){
         switch (buttonIndex) {
             case 0:
                 _way.text=@"自驾";
                 break;
             case 1:
                 _way.text=@"火车";
                 break;
             case 2:
                 _way.text=@"飞机";
                 break;
             default:
                 break;
         }
     }
    
    
    
    
}


//被本类代理的textfield无法输入内容，只能响应点击事件
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==_yue_title||textField==_start_city){
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
//日历的代理
-(void)CDPDatePickerDidConfirm:(NSString *)confirmString{
    //[self showToast:confirmString];
    _start_time.text=confirmString;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_datePicker popDatePicker];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提交
-(void)submit{
    if (_yue_title.text.length==0) {
        [self showToast:@"请输入标题"];
        return;
    }
    if (_start_city.text.length==0) {
        [self showToast:@"请填写出发地"];
        return;
    }
    if (_end_city.text.length==0) {
        [self showToast:@"请选择目的地"];
        return;
    }
    if (_start_time.text.length==0) {
        [self showToast:@"请选择出发时间"];
        return;
    }
    if (_target.text.length==0) {
        [self showToast:@"请选择邀约对象"];
        return;
    }
    if (_fee.text.length==0) {
        [self showToast:@"请选择付费方式"];
        return;
    }
    if (_way.text.length==0) {
        [self showToast:@"请选择出行方式"];
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
                           _end_city.text,@"yue_address",
                           _start_time.text,@"yue_time",
                           _target.text,@"yue_target",
                           _fee.text,@"yue_fee_type",
                           _detail.text,@"yue_shuoming",
                           publisher,@"yue_publisher",
                           @"tour",@"yue_type",
                           @"",@"yue_game",
                           @"",@"yue_sport",
                           @"",@"yue_movie",
                           _start_city.text,@"yue_start_city",
                           _way.text,@"yue_way",
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
