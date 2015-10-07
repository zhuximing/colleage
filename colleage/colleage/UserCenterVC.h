//
//  UserCenterVC.h
//  colleage
//
//  Created by Apple on 15/10/6.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "PassValue.h"
@interface UserCenterVC : UIViewController<PassValue>

@property (weak, nonatomic) IBOutlet UIImageView *head_img;

@property (weak, nonatomic) IBOutlet UILabel *user_name;

@property (weak, nonatomic) IBOutlet UILabel *user_phone;

@property (weak, nonatomic) IBOutlet UIView *user_center;


@end
