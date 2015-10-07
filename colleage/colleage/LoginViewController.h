//
//  LoginViewController.h
//  colleage
//
//  Created by Apple on 15/9/1.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextViewController.h"
#import "PassValue.h"
@interface LoginViewController : NextViewController
@property (weak, nonatomic) IBOutlet UITextField *loginTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;
- (IBAction)login:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<PassValue> *delegate;
@end
