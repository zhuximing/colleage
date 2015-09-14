//
//  INeedCarPublish.h
//  colleage
//
//  Created by Apple on 15/9/13.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface INeedCarPublish : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *start_city;
@property (weak, nonatomic) IBOutlet UITextField *end_city;
@property (weak, nonatomic) IBOutlet UITextField *person_count;

@property (weak, nonatomic) IBOutlet UITextField *start_time;

@end
