//
//  YueHeaderCC.m
//  colleage
//
//  Created by Apple on 15/9/23.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "YueHeaderCC.h"

@implementation YueHeaderCC
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"YueHeaderCC" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}






@end
