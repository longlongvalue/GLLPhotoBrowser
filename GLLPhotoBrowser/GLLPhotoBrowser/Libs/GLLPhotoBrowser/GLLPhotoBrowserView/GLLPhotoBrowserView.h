//
//  GLLPhotoBrowserView.h
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/17.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLLPhotoBrowserViewDelegate <NSObject>

@required

- (UIImage *)getThumbNailPicture:(NSInteger)imageIndex;

@optional

- (NSURL *)getBigImageWithIndex:(NSInteger)imageIndex;

@end

@interface GLLPhotoBrowserView : UIView

//当前展示图片下标
@property (nonatomic, assign) NSInteger currentImageIndex;

//当前所有图片数量
@property (nonatomic, assign) NSInteger imageCount;

@property (nonatomic, weak) id<GLLPhotoBrowserViewDelegate> delegate;

/**
 展示图片View
 */
- (void)show;

@end
