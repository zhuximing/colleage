//
//  main.m
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobIM/BmobChat.h>
int main(int argc, char * argv[]) {
     [BmobChat registerAppWithAppKey:@"9e2c3af6dd2e16148ff336f9926fd991"];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
