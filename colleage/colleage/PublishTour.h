//
//  PublishTour.h
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface PublishTour : NextViewController<PassValue>
@property (weak, nonatomic) IBOutlet UITextField *yue_title;
@property (weak, nonatomic) IBOutlet UITextField *start_city;
@property (weak, nonatomic) IBOutlet UITextField *end_city;
@property (weak, nonatomic) IBOutlet UITextField *start_time;
@property (weak, nonatomic) IBOutlet UITextField *target;
@property (weak, nonatomic) IBOutlet UITextField *fee;
@property (weak, nonatomic) IBOutlet UITextField *way;
@property (weak, nonatomic) IBOutlet UITextView *detail;

@end
