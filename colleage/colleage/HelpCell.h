//
//  HelpCell.h
//  colleage
//
//  Created by Apple on 15/9/12.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *help_title;
@property (weak, nonatomic) IBOutlet UILabel *help_reward;
@property (weak, nonatomic) IBOutlet UILabel *user_school;

@property (weak, nonatomic) IBOutlet UILabel *publish_time;

@end
