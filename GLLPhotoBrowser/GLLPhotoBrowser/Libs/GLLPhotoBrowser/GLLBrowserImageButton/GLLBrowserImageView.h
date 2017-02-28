//
//  GLLBrowserImageView.h
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/17.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLLBrowserImageView : UIImageView

//是否已经加载大图
@property (nonatomic, assign) BOOL hasLoadedImage;

//加载大图是否成功
@property (nonatomic, assign) BOOL loadBigPictureSuccess;

//是否是缩放状态
@property (nonatomic, assign) BOOL isScaled;

//加载大图
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placehoder WithBlock:(void(^)(NSString *))completeBlock;

//双击缩放
- (void)doubleTapToZommWithScale:(CGFloat)scale;

//清除所有缩放
- (void)eliminateScale;

@end
