//
//  ChooseText.h
//  colleage
//
//  Created by Apple on 15/10/3.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface ChooseText : NextViewController@property (weak, nonatomic) IBOutlet UITextField *text;
//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<PassValue> *delegate;

@property(nonatomic ,assign) NSString *biaoti;//标题
@property(nonatomic,assign) NSString *errorInfo;//错误信息
@end
