//
//  HomeViewController.m
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "CommonUtil.h"
#import "LostTableViewController.h"
#import "HomeCollectionViewCell.h"
#import "JobTableViewController.h"
#import "HourseViewController.h"
#import "CarViewController.h"
#import "HelpViewController.h"
#import "MarketViewController.h"
#import "SDCycleScrollView.h"
#import "HelpViewController.h"
@interface HomeViewController (){
   
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    //    self.view.backgroundColor=[UIColor redColor];
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"首页"];
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    
     CGFloat w = self.view.bounds.size.width;
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) imageURLStringsGroup:nil]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.viewOfScrollView addSubview:cycleScrollView2];
    
    //             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
}


//九宫格数组的get方法
-(NSMutableArray*)array{

    if (_array==nil) {
        NSString *plistPath=[[NSBundle mainBundle] pathForResource:@"module" ofType:@"plist"];
        _array=[[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    }


    return _array;

}






#pragma mark - UIScrollView

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    NSLog(@"---点击了第%ld张图片", index);
}




#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   // cell.backgroundColor=[UIColor redColor];
    NSString *imgPath=[[_array objectAtIndex:indexPath.row] objectForKey:@"img"];
    cell.img.image=[UIImage imageNamed:imgPath];
    cell.titlelbl.text=[_array[indexPath.row] objectForKey:@"text"];
    cell.tag=indexPath.row;
    
    return  cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    int width_int = (int) width;
    
    if(320 == width_int){
        
        return CGSizeMake(80, 86);
    }else{
        
        return CGSizeMake(90, 100);
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
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
   // [cell setBackgroundColor:[UIColor greenColor]];
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //校园兼职
    if (cell.tag ==0) {
        JobTableViewController *jobTBVC=[story instantiateViewControllerWithIdentifier:@"JobTableViewController"];
        
        [self.navigationController pushViewController:jobTBVC animated:YES];
    }
    //失物招领
    if (cell.tag ==1) {
       
        //获取登陆后的个人中心的视图控制器
        LostTableViewController *lostTBVC=[story instantiateViewControllerWithIdentifier:@"LostTableViewController"];
      
        [self.navigationController pushViewController:lostTBVC animated:YES];
    }
    //学生合租
    if (cell.tag ==2) {
        HourseViewController *hourseVC=[story instantiateViewControllerWithIdentifier:@"HourseViewController"];
        [self.navigationController pushViewController:hourseVC animated:YES];
    }
    //拼车回家
    if (cell.tag ==3) {
       
        CarViewController *car=[story instantiateViewControllerWithIdentifier:@"CarViewController"];
        
        [self.navigationController pushViewController:car animated:YES];
    }
    //同学互帮
    if (cell.tag ==4) {
        
        HelpViewController *help=[story instantiateViewControllerWithIdentifier:@"HelpViewController"];
        
        [self.navigationController pushViewController:help animated:YES];
    }
    //二手市场
    if (cell.tag ==5) {
        MarketViewController *marketVC=[[MarketViewController alloc] init];
        [self.navigationController pushViewController:marketVC animated:YES];
    }
    
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
