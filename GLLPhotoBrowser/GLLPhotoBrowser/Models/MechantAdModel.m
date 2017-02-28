//
//  MechantAdModel.m
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/16.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#import "MechantAdModel.h"

@implementation MechantAdModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"MechantAdModel未定义Key");
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


@end
