//
//  IHasCarPublish.m
//  colleage
//
//  Created by Apple on 15/9/13.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "IHasCarPublish.h"

@interface IHasCarPublish ()

@end

@implementation IHasCarPublish

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //边框
    _start_time.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _start_time.layer.borderWidth=1.0;
    _car_detail.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _car_detail.layer.borderWidth=1.0;
    
    _datePicker=[[CDPDatePicker alloc] initWithSelectTitle:nil viewOfDelegate:self.view delegate:self];

}

//显示时间选择器

- (IBAction)showDatePicker:(id)sender {
     [_datePicker pushDatePicker];
    
}


//发布

- (IBAction)publish:(id)sender {
    if (_start_city.text.length==0) {
        [self showToast:@"请输入出发城市"];
        return;
    }
    if (_end_city.text.length==0) {
        [self showToast:@"请输入目的城市"];
        return;
    }
    
    if (_need_persons.text.length==0) {
        [self showToast:@"请输入要车人数"];
        return;
    }
    if (_start_time.currentTitle.length==0) {
        [self showToast:@"请选择出发时间"];
        return;
    }
    if (_car_detail.text.length==0) {
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
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:
                           @"人",@"pingche_who",
                           _start_city.text,@"pingche_start_city",
                           publisher,@"pingche_publisher",
                           _end_city.text,@"pingche_end_city",
                           _start_time.currentTitle,@"pingche_start_time",
                           @"",@"pingche_che",
                           _need_persons.text,@"pingche_persons",
                           @"",@"pingche_fee",
                           _car_detail.text,@"pingche_detail",
                           @"0",@"pingche_type",
                           nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"pingche/add_pingche_home" params:parames httpMethod:@"POST"];
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

//datePicker回调
//回调，字符串可自行进行截取
-(void)CDPDatePickerDidConfirm:(NSString *)confirmString{
    //[self showToast:confirmString];
    
    [_start_time setTitle:confirmString forState:UIControlStateNormal];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_datePicker popDatePicker];
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





//对数字框进行限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _need_persons) {
        return [self validateNumber:string];
    }
        return YES;
    
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
