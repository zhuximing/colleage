//
//  RecentTableViewCell.m
//  colleage
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "RecentTableViewCell.h"
#import "CommonUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation RecentTableViewCell
@synthesize avatarImageView = _avatarImageView;
@synthesize nameLabel       = _nameLabel;
@synthesize messageLabel    = _messageLabel;
@synthesize lineImageView   = _lineImageView;

//覆盖初始化方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//消息的set方法,
-(void)setRecent:(BmobRecent *)recent{
    if (!_recent) {
        _recent=recent;
       
    }
    _flag=@"recent";
    //告诉系统调用，layoutSubviews方法
     [self setNeedsDisplay];
}
//联系人的set方法,
-(void)setChatUser:(BmobChatUser *)chatUser{
    if (!_chatUser) {
        _chatUser=chatUser;
    }
    _flag=@"chatUser";
    //告诉系统调用，layoutSubviews方法
    [self setNeedsDisplay];

}



//名字
-(UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel                 = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor       = RGB(60, 60, 60, 1.0f);
        _nameLabel.font            = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}


//消息
-(UILabel*)messageLabel{

    if (!_messageLabel) {
        _messageLabel                 = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.font            = [CommonUtil setFontSize:13];
        _messageLabel.textAlignment   = NSTextAlignmentLeft;
        _messageLabel.textColor       = RGB(136, 136, 136, 1.0f);//[CommonUtil setColorByR:136 G:136 B:136];
        [self.contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

//头像
-(UIImageView*)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:10];
        [self.contentView addSubview:_avatarImageView];
    }
    
    return _avatarImageView;
}


//
-(UIImageView*)lineImageView{
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_lineImageView];
    }
    
    return _lineImageView;
}





//渲染前调用
-(void)layoutSubviews{
    [super layoutSubviews];//attention
    
    if ([_flag isEqualToString:@"recent"]) {
        //赋值
        if (_recent.avatar) {
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_recent.avatar] placeholderImage:[UIImage imageNamed:@"setting_head"]];
        }
        
        self.nameLabel.text      = _recent.targetName;
        self.messageLabel.text   = _recent.message;

    }else{
        //赋值
        if (_chatUser.avatar) {
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_chatUser.avatar] placeholderImage:[UIImage imageNamed:@"setting_head"]];
        }
        
        self.nameLabel.text      = _chatUser.username;
    }
    
    
    
    
    
    
    self.lineImageView.image = [UIImage imageNamed:@"common_line"];
    
    
    //尺寸
    self.nameLabel.frame       = CGRectMake(90, 16, 100, 22);
    self.lineImageView.frame   = CGRectMake(0, self.frame.size.height-1, 320, 1);
    self.avatarImageView.frame = CGRectMake(20, 15, 50, 50);
    self.messageLabel.frame    = CGRectMake(90, 50, 200, 15);
}
@end
