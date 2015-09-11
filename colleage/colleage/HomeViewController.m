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
@interface HomeViewController (){
    NSArray *imgArr;
    NSArray *textArr;
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



#pragma mark - UIScrollView

-(void)createLunBo{
    //    图片的宽
    CGFloat imageW = self.scrollview.frame.size.width;
    
    
    //    CGFloat imageW = 300;
    //    图片高
    CGFloat imageH = self.scrollview.frame.size.height;
    //    图片的Y
    CGFloat imageY = 0;
    //    图片中数
    NSInteger totalCount = 4;
    //   1.添加5张图片
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //        图片X
        CGFloat imageX = i * imageW;
        //        设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        //        设置图片
        NSString *name = [NSString stringWithFormat:@"chat_icon%d_@2x.png", i + 1];
        imageView.image = [UIImage imageNamed:name];
        //        隐藏指示条
        self.scrollview.showsHorizontalScrollIndicator = NO;
        self.scrollview.pagingEnabled=YES;
        self.scrollview.bounces=NO;
        self.scrollview.showsVerticalScrollIndicator=NO;
        [self.scrollview addSubview:imageView];
    }
    
    //    2.设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
    //不允许在垂直方向上进行滚动
    self.scrollview.contentSize = CGSizeMake(contentW, 0);
    
    //    3.设置分页
    self.scrollview.pagingEnabled = YES;
    
    //    4.监听scrollview的滚动
    self.scrollview.delegate = self;
    
    self.pageControl.numberOfPages=totalCount;
    [self addTimer];
}

- (void)nextImage
{
    int page = (int)self.pageControl.currentPage;
   // NSLog(@"当前第%d页",page);
    if (page == 3) {
        page = 0;
    }else
    {
        page++;
    }
    
    //  滚动scrollview
    CGFloat x = page * self.scrollview.frame.size.width;
    self.scrollview.contentOffset = CGPointMake(x, 0);
}

// scrollview滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"滚动中");
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
}

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    //    [self.timer invalidate];
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    开启定时器
    [self addTimer];
}

/**
 *  开启定时器
 */
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
/**
 *  关闭定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    NSString *imgPath=[imgArr objectAtIndex:indexPath.row];
    cell.img.image=[UIImage imageNamed:imgPath];
    cell.titlelbl.text=textArr[indexPath.row];
    cell.tag=indexPath.row;
    
    return  cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

//选择了某个cell 跳转对应页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
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
        HourseViewController *hourseVC=[[HourseViewController alloc] init];
        [self.navigationController pushViewController:hourseVC animated:YES];
    }
    //拼车回家
    if (cell.tag ==3) {
        CarViewController *carVC=[[CarViewController alloc] init];
        [self.navigationController pushViewController:carVC animated:YES];
    }
    //同学互帮
    if (cell.tag ==4) {
        HelpViewController *helpVC=[[HelpViewController alloc] init];
        [self.navigationController pushViewController:helpVC animated:YES];
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
    [cell setBackgroundColor:[UIColor redColor]];
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
