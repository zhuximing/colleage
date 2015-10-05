//
//  SelectSport.h
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface SelectSport : NextViewController{

    NSArray *games;//体育项目
    NSArray *jingdian;//景点
    NSArray *theme;//主题
}
@property (weak, nonatomic) IBOutlet UILabel *label_tishi;
@property (weak, nonatomic) IBOutlet UITextField *tf_text;

@property (weak, nonatomic) IBOutlet UITextField *tv_game;
//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<PassValue> *delegate;
@property(nonatomic,assign) NSString*biaoti;//标题
@property(nonatomic,assign) NSString*placeHolder;//placeHolder
@property(nonatomic,assign) NSString*tishi;//tishi
@property(nonatomic,assign) NSString*type;//类型
@property(nonatomic,assign) NSString*toast;//吐司
@end
