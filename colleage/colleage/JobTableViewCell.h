//
//  JobTableViewCell.h
//  colleage
//
//  Created by Apple on 15/9/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titlelbl;
@property (weak, nonatomic) IBOutlet UILabel *companlbl;
@property (weak, nonatomic) IBOutlet UILabel *personscountlbl;
@property (weak, nonatomic) IBOutlet UILabel *moneylbl;
@property (weak, nonatomic) IBOutlet UILabel *timelbl;

@end
