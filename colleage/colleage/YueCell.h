//
//  YueCell.h
//  colleage
//
//  Created by Apple on 15/9/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YueCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *head_img;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *yue_title;
@property (weak, nonatomic) IBOutlet UILabel *yue_time;
@property (weak, nonatomic) IBOutlet UILabel *yue_address;
@property (weak, nonatomic) IBOutlet UILabel *publish_time;

@end
