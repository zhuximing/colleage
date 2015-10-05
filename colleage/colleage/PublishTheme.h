//
//  PublishTheme.h
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface PublishTheme : NextViewController<PassValue>
@property (weak, nonatomic) IBOutlet UITextField *yue_title;
@property (weak, nonatomic) IBOutlet UITextField *yue_address;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (weak, nonatomic) IBOutlet UITextField *target;
@property (weak, nonatomic) IBOutlet UITextField *theme;

@end
