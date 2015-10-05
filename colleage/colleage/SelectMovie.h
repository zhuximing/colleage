//
//  SelectMovie.h
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface SelectMovie : NextViewController
@property (weak, nonatomic) IBOutlet UITextField *tv_movie;
@property (weak, nonatomic) IBOutlet UITableView *table_movie;
//这里用assign而不用retain是为了防止引起循环引用。
@property(nonatomic,assign) NSObject<PassValue> *delegate;
@end
