//
//  YueBaHeader.h
//  colleage
//
//  Created by Apple on 15/9/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YueBaHeader : UIView
//九宫格数据数组
@property (nonatomic,strong) NSMutableArray *array;

@property(nonatomic,strong)UICollectionView *module;

@property(nonatomic,strong) UINavigationController *nav;

@end
