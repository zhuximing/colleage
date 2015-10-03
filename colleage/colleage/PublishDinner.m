//
//  PublishDinner.m
//  colleage
//
//  Created by Apple on 15/9/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishDinner.h"
#import "CommonUtil.h"
#import "CDPDatePicker.h"
#import "ChooseText.h"
@interface PublishDinner (){

    CDPDatePicker *_datePicker;
    UIActionSheet *address_action;
    UIActionSheet *time_action;
    UIActionSheet *target_action;
    UIActionSheet *fee_action;
}

@end

@implementation PublishDinner

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布一起吃饭"];
    
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

    
    
    //下划线
    //UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
    //lineView.backgroundColor =[UIColor grayColor];
    
    
    //点击选择地址的事件
    // UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choose_address)];
    
    // _address.userInteractionEnabled=YES;
    //[_address addGestureRecognizer:singleTap];
    // [_address addSubview:lineView];
    
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
    
    UIImageView *imageView3=[[UIImageView alloc ] initWithImage:image];
    _fee.rightView=imageView3;
    _fee.rightViewMode=UITextFieldViewModeAlways;
    
    UIImageView *imageView4=[[UIImageView alloc ] initWithImage:image];
    _target.rightView=imageView4;
    _target.rightViewMode=UITextFieldViewModeAlways;
    
    
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
                     otherButtonTitles: @"指定餐厅", @"大概地址",nil];
    
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


//选择付费方式
- (IBAction)choose_fee:(id)sender {
    fee_action = [[UIActionSheet alloc]
                      initWithTitle:nil
                      delegate:self
                      cancelButtonTitle:@"取消"
                      destructiveButtonTitle:nil
                      otherButtonTitles: @"AA制", @"我请客",nil];
    
    [fee_action showInView:self.view];
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
    }
    
    
}
//指定地址
-(void) the_address{
    ChooseText *text=[self getViewController:@"ChooseText"];
    text.delegate=self;
    text.biaoti=@"请输入地址";
    text.errorInfo=@"地址不能为空";
    [self.navigationController pushViewController:text animated:YES];

}
//地址回调
-(void)getValue:(NSString *)value{

    _address.text=value;
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
    if (_fee.text.length==0) {
        [self showToast:@"请选择付费方式"];
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
        _address.text,@"yue_address",
        _time.text,@"yue_time",
        _target.text,@"yue_target",
        _fee.text,@"yue_fee_type",
        _detail.text,@"yue_shuoming",
        publisher,@"yue_publisher",
        @"dinner",@"yue_type",
        @"",@"yue_game",
        @"",@"yue_sport",
        @"",@"yue_movie",
        @"",@"yue_start_city",
        @"",@"yue_way",
        @"",@"yue_male_count",
        @"",@"yue_female_count",
        @"",@"yue_theme",
        @"",@"yue_way",
         nil];
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
