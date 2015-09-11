//
//  HomeViewController.h
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
//承载scrollview的空视图
@property (weak, nonatomic) IBOutlet UIView *viewOfScrollView;




@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(strong,nonatomic) NSTimer *timer;
@end
