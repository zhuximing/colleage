//
//  PublishHourseViewController.m
//  colleage
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishHourseViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
#import "PhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface PublishHourseViewController ()
@property (nonatomic , strong) NSMutableArray *assets;
@end

@implementation PublishHourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sh_des.layer.borderWidth=1.0;
    self.sh_des.layer.borderColor=[UIColor grayColor].CGColor;
     //设置textview边框和圆角
    [self.sh_des.layer setCornerRadius:5.0];
    

}
#pragma mark -数组 存放图片
- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}

#pragma  mark - textfiled设置

//textfiled 出现键盘后 按return（回车键）键盘收起来
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    [textField resignFirstResponder];
    return YES;
}

//对数字框进行限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _sh_limit) {
        return [self validateNumber:string];
    }
    if (textField == _sh_price) {
        return [self validateNumber:string];
    }
    return YES;
    
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


//textview 出现键盘后 按return（回车键）键盘收起来
#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])  {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -UICollectionViewDataSource 显示图片的collectionview
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.assets.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"PhotoCollectionViewCell";
    PhotoCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
     MLSelectPhotoAssets *asset = self.assets[indexPath.row];
    
    cell.photoImg.image=[MLSelectPhotoPickerViewController getImageWithImageObj:asset];
    cell.photoImg.tag=100;
    cell.deleteImg.image=[UIImage imageNamed:@"delete-circular"];
   
    cell.deleteImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delPhoto:)];
    [cell.deleteImg addGestureRecognizer:singleTap];
    
    return cell;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//删除collectionview中的图片
- (void)delPhoto:(UIGestureRecognizer *)sender{
    CGPoint initialPinchPoint = [sender locationInView:self.imgCollection];
    NSIndexPath* tappedCellPath = [self.imgCollection indexPathForItemAtPoint:initialPinchPoint];
    /*
    //得到要删除的cell
    UITableViewCell *cell=[self.imgCollection cellForItemAtIndexPath:tappedCellPath];
    
    NSLog(@"cell内容%@",cell);
    //通过cell得到要删除的img
    UIImageView *img=[cell viewWithTag:100];
   */
   
   

    //删除数组中选中的cell对应的img
    [self.assets removeObjectAtIndex:tappedCellPath.row];
    
        //删除后重新加载数据
    NSLog(@"删除后图片数量%d",self.assets.count);
    [self.imgCollection reloadData];
   
   
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

//从相册选择图片或手机拍照
- (IBAction)selectImgAction:(id)sender {
    //在这里呼出下方菜单按钮项
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.minCount = 9;
    [pickerVc showPickerVc:self];
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets){
        [weakSelf.assets addObjectsFromArray:assets];
          NSLog(@"图片数量%d",self.assets.count);
        [self.imgCollection reloadData];
        NSLog(@"%@",assets);
    };

   
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissModalViewControllerAnimated:YES];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:
                                    CGRectMake(50, 120, 40, 40)];
        
        smallimage.image = image;
        //加在视图中
        [self.view addSubview:smallimage];
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//提交表单
- (IBAction)submitAction:(id)sender {
    if (self.sh_title.text.length == 0) {
        [self showToast:@"标题不能为空"];
        return;
    }
    
    if (self.sh_address.text.length == 0) {
        [self showToast:@"地址不能为空"];
        return;
    }
    if (self.sh_limit.text.length == 0) {
        [self showToast:@"人数不能为空"];
        return;
    }
    if (self.sh_price.text.length == 0) {
        [self showToast:@"房租不能为空"];
        return;
    }
    if (self.sh_des.text.length == 0) {
        [self showToast:@"描述信息不能为空"];
        return;
    }
    NSString *title=self.sh_title.text;
    NSString *address=self.sh_address.text;
    NSString *limit=self.sh_limit.text;
    NSString *price=self.sh_price.text;
    NSString *des=self.sh_des.text;
    NSString *user_id=@"21";    //用户idNextViewController	NextViewController
   
    NSLog(@"图片＝＝＝＝＝＝＝%@",self.assets);
    
   
    //获取数据
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:title,@"sh_title",
                                     address,@"sh_address",
                                     limit,@"sh_limit",
                                     price,@"sh_price",
                                    des,@"sh_detail",
                                    user_id,@"user_id",
                                     nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"share_house/add_house" params:parames httpMethod:@"POST"];
    
    for (int i=0; i<self.assets.count; i++) {
        //获取图片路径
        MLSelectPhotoAssets *ml=self.assets[0];
        ALAsset *al=ml.asset;
        NSURL* url = [[al defaultRepresentation] url];
         NSLog(@"图片路径%@",url.absoluteString);
        NSString *k=[NSString stringWithFormat:@"image%d",i];
        [op addFile:url.absoluteString forKey:k ];
    }
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        [self showToast:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
    }];
    
    [engine enqueueOperation:op];
    
    
}


-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
  
}
@end
