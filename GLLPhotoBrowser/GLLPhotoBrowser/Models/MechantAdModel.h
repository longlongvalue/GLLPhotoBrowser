//
//  MechantAdModel.h
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/16.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MechantAdModel : NSObject

@property (nonatomic, copy) NSString *nickNameStr;

@property (nonatomic, copy) NSString *headerUrlStr;

@property (nonatomic, copy) NSString *contentStr;

@property (nonatomic, strong) NSArray *imageUrlArray;

@property (nonatomic, strong) NSArray *imageHightUrlStrArray;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
