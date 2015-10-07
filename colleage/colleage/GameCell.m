//
//  GameCell.m
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "GameCell.h"

@implementation GameCell

//渲染前调用
-(void)layoutSubviews{

    //self.game_name.layer.borderColor=[UIColor grayColor].CGColor;
    self.game_name.layer.cornerRadius=6.0;
    self.game_name.layer.borderWidth=1.0;
}

@end
