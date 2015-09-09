//
//  LostTableViewCell.h
//  colleage
//
//  Created by Apple on 15/9/8.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lost_name;

@property (weak, nonatomic) IBOutlet UILabel *lost_address;

@property (weak, nonatomic) IBOutlet UILabel *school;
@property (weak, nonatomic) IBOutlet UILabel *publish_time;

@end
