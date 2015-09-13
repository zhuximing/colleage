//
//  CarCell.h
//  colleage
//
//  Created by Apple on 15/9/13.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *path;
@property (weak, nonatomic) IBOutlet UILabel *start_time;
@property (weak, nonatomic) IBOutlet UILabel *publish_time;

@end
