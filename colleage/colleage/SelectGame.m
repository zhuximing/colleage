//
//  SelectGame.m
//  colleage
//
//  Created by Apple on 15/10/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SelectGame.h"
#import "CommonUtil.h"
#import "DOPDropDownMenu.h"
@interface SelectGame ()

@end

@implementation SelectGame

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"请选择游戏"];
    
    // 数据
    self.gametypes = @[@"网游",@"页游",@"手游",@"竞技"];
    self.wangyou = @[@"魔兽世界",@"天涯明月刀",@"地下城与勇士",@"剑灵",@"天龙八部",@"梦幻西游",@"笑傲江湖",@"问道",@"诛仙",@"传奇",@"完美世界",@"龙之谷",@"轩辕传奇"];
    self.yeyou = @[@"大天使之剑",@"传奇霸业",@"天书世界",@"火影忍者",@"苍穹变",@"雷霆之怒",@"烈焰",@"斩仙"];
    self.shouyou = @[@"刀塔传奇",@"梦幻西游",@"天天酷跑",@"魔灵召唤",@"天天来战",@"放开那三国"];
    self.jingji = @[@"英雄联盟",@"dota2",@"真三",@"群雄逐鹿",@"三国争霸"];
  

    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];

    
    
}
//按钮点击代理
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 1;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    
        return self.gametypes.count;
   
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
   
        if (row == 0) {
            return self.wangyou.count;
        } else if (row == 1){
            return self.yeyou.count;
        } else if (row == 2){
            return self.shouyou.count;
        }else if (row == 3){
            return self.jingji.count;
        }else{
            return 0;
        }
    

}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    return self.gametypes[indexPath.row];
    
}



- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
        if (indexPath.row == 0) {
            return self.wangyou[indexPath.item];
        } else if (indexPath.row == 1){
            return self.yeyou[indexPath.item];
        } else if (indexPath.row == 2){
            return self.shouyou[indexPath.item];
        }else if(indexPath.row == 3){
            
            return self.jingji[indexPath.item];
        }else{
            return nil;
        }
    
    
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
  
        
         if (indexPath.row==0&&indexPath.item>=0){
             [self.delegate getGame:_wangyou[indexPath.item]];
             [self.navigationController popViewControllerAnimated:YES];
           
        }else if (indexPath.row==1&&indexPath.item>=0){
             [self.delegate getGame:_yeyou[indexPath.item]];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (indexPath.row==2&&indexPath.item>=0){
             [self.delegate getGame:_shouyou[indexPath.item]];
            [self.navigationController popViewControllerAnimated:YES];
        }else if (indexPath.row==3&&indexPath.item>=0){
             [self.delegate getGame:_jingji[indexPath.item]];
            [self.navigationController popViewControllerAnimated:YES];
           
        }
    
    

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
