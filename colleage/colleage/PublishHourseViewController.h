//
//  PublishHourseViewController.h
//  colleage
//
//  Created by Apple on 15/9/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"

@interface PublishHourseViewController: NextViewController<UITextFieldDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    
    UIActionSheet *myActionSheet;
    //图片2进制路径
    NSString* filePath;
}
@property (weak, nonatomic) IBOutlet UITextField *sh_title;
@property (weak, nonatomic) IBOutlet UITextField *sh_address;
@property (weak, nonatomic) IBOutlet UITextField *sh_limit;
@property (weak, nonatomic) IBOutlet UITextField *sh_price;
@property (weak, nonatomic) IBOutlet UITextView *sh_des;
- (IBAction)selectImgAction:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *imgCollection;
- (IBAction)submitAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *submitbtn;


@end
