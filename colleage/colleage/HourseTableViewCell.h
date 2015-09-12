//
//  HourseTableViewCell.h
//  colleage
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hourseImg;
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;
@property (weak, nonatomic) IBOutlet UILabel *addresslbl;
@property (weak, nonatomic) IBOutlet UILabel *pricelbl;
@property (weak, nonatomic) IBOutlet UILabel *schoollbl;
@property (weak, nonatomic) IBOutlet UILabel *timelbl;

@end
