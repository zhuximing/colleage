//
//  INeedCarPublish.h
//  colleage
//
//  Created by Apple on 15/9/13.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextViewController.h"
#import "CDPDatePicker.h"
@interface INeedCarPublish : NextViewController<UITextFieldDelegate,UITextViewDelegate>{
    CDPDatePicker *_datePicker;

}
@property (weak, nonatomic) IBOutlet UITextField *start_city;
@property (weak, nonatomic) IBOutlet UITextField *end_city;
@property (weak, nonatomic) IBOutlet UITextField *car_type;
@property (weak, nonatomic) IBOutlet UITextField *car_kong;


@property (weak, nonatomic) IBOutlet UIButton *start_time;

@property (weak, nonatomic) IBOutlet UITextField *car_fee;

@property (weak, nonatomic) IBOutlet UITextView *car_detail;

@end
