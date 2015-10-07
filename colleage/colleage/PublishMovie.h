//
//  PublishMovie.h
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface PublishMovie : NextViewController<UITextFieldDelegate,UITextViewDelegate,PassValue>
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *target;
@property (weak, nonatomic) IBOutlet UITextField *fee;
@property (weak, nonatomic) IBOutlet UITextField *movie;

@property (weak, nonatomic) IBOutlet UITextView *detail;

@property (weak, nonatomic) IBOutlet UITextField *yue_title;


@end
