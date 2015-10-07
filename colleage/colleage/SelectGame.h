//
//  SelectGame.h
//  colleage
//
//  Created by Apple on 15/10/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface SelectGame : NextViewController
@property (nonatomic, strong) NSArray *gametypes;
@property (nonatomic, strong) NSArray *wangyou;
@property (nonatomic, strong) NSArray *yeyou;
@property (nonatomic, strong) NSArray *shouyou;
@property(nonatomic,strong) NSArray *jingji;
//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<PassValue> *delegate;
@end
