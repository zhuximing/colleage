//
//  PublishLost.h
//  colleage
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"

@interface PublishLost : NextViewController<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *lost_address;


@property (weak, nonatomic) IBOutlet UIButton *submit_brn;
@property (weak, nonatomic) IBOutlet UITextField *lost_name;


@end
