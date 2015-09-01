//
//  RecentTableViewCell.h
//  colleage
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobIM/BmobDB.h>

@interface RecentTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UILabel     *nameLabel;
@property (nonatomic,strong) UILabel     *messageLabel;
@property (nonatomic,strong) UIImageView *lineImageView;
@property(nonatomic,strong)  BmobRecent  *recent;



@end
