//
//  CarViewController.m
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CarViewController.h"
#import "CommonUtil.h"
#import "CarList.h"
@interface CarViewController ()

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"查询路线"];
}


//执行搜索
- (IBAction)search:(id)sender {
    
    CarList *cars=[self getViewController:@"CarList"];
    cars.start_city=_start_city.text;
    cars.end_city=_end_city.text;
   
    [self.navigationController pushViewController:cars animated:YES];
}



#pragma mark -textfiled回车代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder ];
    
    return YES;
}

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
