//
//  PublishHourseViewController.m
//  colleage
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishHourseViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface PublishHourseViewController ()

@end

@implementation PublishHourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sh_des.layer.borderWidth=1.0;
    self.sh_des.layer.borderColor=[UIColor grayColor].CGColor;
     //设置textview边框和圆角
    [self.sh_des.layer setCornerRadius:5.0];
    

}

#pragma  mark - textfiled设置

//textfiled 出现键盘后 按return（回车键）键盘收起来
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    [textField resignFirstResponder];
    return YES;
}

//对数字框进行限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _sh_limit) {
        return [self validateNumber:string];
    }
    if (textField == _sh_price) {
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


//textview 出现键盘后 按return（回车键）键盘收起来
#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])  {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"PhotoCell";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    return cell;
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

//从相册选择图片或手机拍照
- (IBAction)selectImgAction:(id)sender {
    NSLog(@"");
    
}
//提交表单
- (IBAction)submitAction:(id)sender {
    if (self.sh_title.text.length == 0) {
        [self showToast:@"标题不能为空"];
        return;
    }
    
    if (self.sh_address.text.length == 0) {
        [self showToast:@"地址不能为空"];
        return;
    }
    if (self.sh_limit.text.length == 0) {
        [self showToast:@"人数不能为空"];
        return;
    }
    if (self.sh_price.text.length == 0) {
        [self showToast:@"房租不能为空"];
        return;
    }
    if (self.sh_des.text.length == 0) {
        [self showToast:@"描述信息不能为空"];
        return;
    }
    
    
}
@end
