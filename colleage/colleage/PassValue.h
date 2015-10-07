//
//  PassValue.h
//  colleage
//
//  Created by Apple on 15/10/3.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#ifndef colleage_PassValue_h
#define colleage_PassValue_h

#import <Foundation/Foundation.h>

@protocol PassValue <NSObject>

-(void) getValue:(NSString *)value;
-(void) getMovie:(NSString *)value;
-(void) getSport:(NSString *)value;
-(void) getGame:(NSString *)value;
-(void) setImgAndNameAndPhone; //登陆完成后刷新 个人中心的数据
@end

#endif
