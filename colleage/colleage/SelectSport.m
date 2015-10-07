//
//  SelectSport.m
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SelectSport.h"
#import "GameCell.h"
#import "CommonUtil.h"
@interface SelectSport ()

@end

@implementation SelectSport

- (void)viewDidLoad {
    games=@[@"篮球",@"足球",@"羽毛球",@"台球",@"乒乓球",@"排球",@"健身",@"游泳",@"网球",@"瑜伽",@"舞蹈",@"散步"];
    jingdian=@[@"三亚",@"丽江",@"大理",@"马尔代夫",@"夏威夷",@"香港",@"西藏"];
    theme=@[@"逛街购物",@"操场上闲聊",@"图书馆自习",@"互诉心事",@"钓鱼",@"香港",@"西藏"];
    [super viewDidLoad];
    
    // 标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:_biaoti];
    
    
    //placeHolder
    _tf_text.placeholder=self.placeHolder;
    //提示
    _label_tishi.text=_tishi;
    
    //完成
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([_type isEqualToString:@"sport"]) {
        return games.count;
    }else if ([_type isEqualToString:@"tour"]){
    
        return jingdian.count;
    }else if ([_type isEqualToString:@"theme"]){
        
        return theme.count;
    }else{
    
        return 0;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify=@"GameCell";
    
    //YueHeaderCC *cell=[[YueHeaderCC alloc] init];
    GameCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if ([_type isEqualToString:@"sport"]) {
        cell.game_name.text=games[indexPath.row];
    }else if ([_type isEqualToString:@"tour"]){
       cell.game_name.text=jingdian[indexPath.row];
    }else if ([_type isEqualToString:@"theme"]){
        cell.game_name.text=theme[indexPath.row];
    }else{
        
        return nil;
    }
    
   
    
    
    
    return  cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    
    return CGSizeMake(80, 20);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

//选择了某个cell 跳转对应页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_type isEqualToString:@"sport"]) {
        _tv_game.text=games[indexPath.row];
    }else if ([_type isEqualToString:@"tour"]){
    
        _tv_game.text=jingdian[indexPath.row];
    }else if ([_type isEqualToString:@"theme"]){
        
        _tv_game.text=theme[indexPath.row];
    }
    
    

}

//回车隐藏键盘 代理
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

//完成
-(void)finish{
    if (_tv_game.text.length==0) {
        [self showToast:_toast];
        return;
    }
    
    [self.delegate getSport:_tv_game.text];
    [self.navigationController popViewControllerAnimated:YES];

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
