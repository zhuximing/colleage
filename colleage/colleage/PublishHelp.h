//
//  PublishHelp.h
//  colleage
//
//  Created by Apple on 15/9/12.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"

@interface PublishHelp : NextViewController<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *help_title;
@property (weak, nonatomic) IBOutlet UITextField *help_reward;
@property (weak, nonatomic) IBOutlet UITextView *help_detail;

@end
