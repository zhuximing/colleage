//
//  CarViewController.h
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextViewController.h"

@interface CarViewController : NextViewController<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *start_city;
@property (weak, nonatomic) IBOutlet UITextField *end_city;




@end
