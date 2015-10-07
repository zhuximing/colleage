//
//  MarketViewController.m
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "MarketViewController.h"
#import "CommonUtil.h"
#import "MarketCollectionViewCell.h"
#import "MarketListViewController.h"
#import "PublishMarketViewController.h"

@interface MarketViewController ()
@end

@implementation MarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"二手市场"];
    //右边的添加按钮
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(addMarket) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}
-(NSMutableArray*)arr{
    
    if (_arr==nil) {
        NSString *plistPath=[[NSBundle mainBundle] pathForResource:@"MarketPlist" ofType:@"plist"];
        _arr=[[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    }
    return _arr;
}

#pragma  mark -addMarket二手市场发布
-(void) addMarket{
    PublishMarketViewController *publish =[self getViewController:@"PublishMarket"];
    [self.navigationController pushViewController:publish animated:YES];

}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MarketCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MarketCollectionViewCell" forIndexPath:indexPath];
    // cell.backgroundColor=[UIColor redColor];
    NSString *imgPath=[[_arr objectAtIndex:indexPath.row] objectForKey:@"img"];
    cell.img.image=[UIImage imageNamed:imgPath];
    cell.textlbl.text=[_arr[indexPath.row] objectForKey:@"text"];
    cell.tag=indexPath.row;
    
    return  cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    int width_int = (int) width;
    
    if(320 == width_int){
        
        return CGSizeMake(76, 90);
    }else{
        
        return CGSizeMake(76, 100);
    }
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    int width_int = (int) width;
    
    if(320 == width_int){
        
        return UIEdgeInsetsMake(5, 8, 10, 8);
    }else{
        
        return UIEdgeInsetsMake(10, 15, 20, 15);
    }
 
}

//选择了某个cell 跳转对应页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    // [cell setBackgroundColor:[UIColor greenColor]];
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MarketListViewController *mlVC=[story instantiateViewControllerWithIdentifier:@"MarketListViewController"];
   
    mlVC.typetitle=[_arr[indexPath.row] objectForKey:@"text"];
    [self.navigationController pushViewController:mlVC animated:YES ];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
