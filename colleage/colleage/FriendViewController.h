//
//  FriendViewController.h
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView         *_chatTableView;
    NSMutableArray      *_chatsArray;
    BOOL                _isUpdateLocation;
}


@end
