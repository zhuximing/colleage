//
//  HomeCollectionViewCell.m
//  colleage
//
//  Created by Apple on 15/9/8.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "CustomCellBackground.h"

@implementation HomeCollectionViewCell

@synthesize img=_img;
@synthesize titlelbl=_titlelbl;
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // change to our custom selected background view
        CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}
-(UILabel*)titlelbl{
    if (!_titlelbl) {
       // _titlelbl                 = [[UILabel alloc] init];
        _titlelbl.backgroundColor = [UIColor clearColor];
        _titlelbl.textColor       = RGB(60, 60, 60, 1.0f);
        _titlelbl.font            = [UIFont boldSystemFontOfSize:8];
    }
    
    return _titlelbl;
}



//渲染前调用
-(void)layoutSubviews{
    [super layoutSubviews];//attention
    self.img.frame=CGRectMake(8,0,64,64);
    self.titlelbl.frame=CGRectMake(0, 65, 80, 15);
}
@end
