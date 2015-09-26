//
//  YueBaHeader.m
//  colleage
//
//  Created by Apple on 15/9/21.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "YueBaHeader.h"
#import "YueHeaderCC.h"
#import "HomeCollectionViewCell.h"
#import "CommonList.h"
@implementation YueBaHeader
-(instancetype)init{
    self=[super init];
    if (self) {
        [self.module registerClass:[YueHeaderCC class] forCellWithReuseIdentifier:@"YueHeaderCC"];
        self.module.delegate=self;
        self.module.dataSource=self;
        
    }
    return self;
}





-(NSMutableArray*)array{
    if (_array==nil) {
        NSString *plistPath=[[NSBundle mainBundle] pathForResource:@"yue_module" ofType:@"plist"];
        _array=[[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    }
    
    
    return _array;
}

-(UICollectionView*)module{
    if (!_module) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
       
        _module=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)collectionViewLayout:flowLayout];
        _module.backgroundColor=[UIColor whiteColor];
        [self addSubview:_module];
    }

    return _module;

}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify=@"YueHeaderCC";
    
    //YueHeaderCC *cell=[[YueHeaderCC alloc] init];
    YueHeaderCC *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    NSString *imgPath=[[_array objectAtIndex:indexPath.row] objectForKey:@"img"];
        cell.img.image=[UIImage imageNamed:imgPath];
        cell.text.text=[_array[indexPath.row] objectForKey:@"text"];
        cell.tag=indexPath.row;
    
    
    
    return  cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    int width_int = (int) width;
    
    if(320 == width_int){
        
        return CGSizeMake(80, 90);
    }else{
        
        return CGSizeMake(80, 90);
    }
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}

//选择了某个cell 跳转对应页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YueHeaderCC *cell = [collectionView cellForItemAtIndexPath:indexPath];
    // [cell setBackgroundColor:[UIColor greenColor]];
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (cell.tag==0) {
        CommonList  *commonList=[story instantiateViewControllerWithIdentifier:@"CommonList"];
        commonList.type=@"dinner";
        [self.nav pushViewController:commonList animated:YES];

    }
    if (cell.tag==1) {
        CommonList  *commonList=[story instantiateViewControllerWithIdentifier:@"CommonList"];
        commonList.type=@"ktv";
        [self.nav pushViewController:commonList animated:YES];
        
    }
    if (cell.tag==2) {
        CommonList  *commonList=[story instantiateViewControllerWithIdentifier:@"CommonList"];
        commonList.type=@"movie";
        [self.nav pushViewController:commonList animated:YES];
        
    }
    if (cell.tag==2) {
        CommonList  *commonList=[story instantiateViewControllerWithIdentifier:@"CommonList"];
        commonList.type=@"movie";
        [self.nav pushViewController:commonList animated:YES];
        
    }
    if (cell.tag==3) {
        CommonList  *commonList=[story instantiateViewControllerWithIdentifier:@"YueGameList"];
        
        [self.nav pushViewController:commonList animated:YES];
        
    }
    if (cell.tag==5) {
        CommonList  *commonList=[story instantiateViewControllerWithIdentifier:@"CommonList"];
        commonList.type=@"tour";
        [self.nav pushViewController:commonList animated:YES];
        
    }
    if (cell.tag==6) {
        CommonList  *commonList=[story instantiateViewControllerWithIdentifier:@"CommonList"];
        commonList.type=@"theme";
        [self.nav pushViewController:commonList animated:YES];
        
    }
       //NSLog(@"!!!!!%d",cell.tag);
   
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor clearColor]];
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


-(void)layoutSubviews{

   

}


@end
