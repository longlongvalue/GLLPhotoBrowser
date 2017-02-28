//
//  GLLPhotoBrowserView.m
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/17.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#import "GLLPhotoBrowserView.h"

#import "GLLBrowserImageView.h"
#import "UIImageView+WebCache.h"

#import "GLLPotoBrowserConfig.h"

@interface GLLPhotoBrowserView ()<UIScrollViewDelegate,CAAnimationDelegate>
{
    //第一次进入是否加载了第一张图片
    BOOL firstImageViewIsShowing;
    
    //判断当前是否正在动画状态
    BOOL isAnimationing;
    
    //停止动画时缩略图的位置
//    CGRect animationingRect;
    
}
//底部可左右滑动视图
@property (nonatomic, strong) UIScrollView *myScrollView;


@end

@implementation GLLPhotoBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = GLLBrowserBackgrounColor;
    }
    return self;
}

/**
 //当加入视图完成后调用
 (void)didAddSubview:(UIView *)subview
 //当视图移动完成后调用
 (void)didMoveToSuperview
 //当视图移动到新的WINDOW后调用
 (void)didMoveToWindow
 //在删除视图之后调用
 (void)willRemoveSubview:(UIView *)subview
 //当移动视图之前调用
 (void)didMoveToSuperview:(UIView *)subview
 //当视图移动到WINDOW之前调用
 (void)didMoveToWindow
 */
#pragma mark - 当视图移动完成后调用
- (void)didMoveToSuperview
{
    [self setMyScrollView];
    
    
}

#pragma mark - 主界面初始化
- (void)setMyScrollView
{
    _myScrollView = [[UIScrollView alloc] init];
    _myScrollView.delegate = self;
    _myScrollView.showsVerticalScrollIndicator = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.pagingEnabled = YES;
    [self addSubview:_myScrollView];
    
    //单击图片还原
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClicked:)];
    Tap.numberOfTapsRequired = 1;
    Tap.numberOfTouchesRequired = 1;
    [_myScrollView addGestureRecognizer:Tap];
    
    for (int i = 0; i < self.imageCount; i ++) {
        
        GLLBrowserImageView *imageButton = [[GLLBrowserImageView alloc] init];
        
        imageButton.userInteractionEnabled = YES;
        
        imageButton.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        
        imageButton.tag = i;
        
        //单击图片还原
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClicked:)];
        
        //双击图片放大
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClicked:)];
        doubleTap.numberOfTapsRequired = 2;
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        [imageButton addGestureRecognizer:singleTap];
        
        [imageButton addGestureRecognizer:doubleTap];
        
        [_myScrollView addSubview:imageButton];
        
    }
    
    [self setupImageOfImageViewForIndex:_currentImageIndex];
    
}

#pragma mark - 重新设置界面Frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    rect.size.width += imageViewMargin * 2;
    
    _myScrollView.bounds = rect;
    _myScrollView.center =self.center;
    
    _myScrollView.contentSize = CGSizeMake(_myScrollView.subviews.count * _myScrollView.frame.size.width, 0);
    _myScrollView.contentOffset = CGPointMake(self.currentImageIndex * _myScrollView.frame.size.width, 0);
    
    if (!firstImageViewIsShowing) {
        
        [self showFirstImageView];
        
//        [self setupImageOfImageViewForIndex:_currentImageIndex];
        
    }

}

#pragma mark - 显示点击的第一张图片
- (void)showFirstImageView
{
    //图片数组的父视图
    UIView *containerView = (UIView *)_delegate;
    //被点击的图片
    UIButton *originalView = [containerView.subviews objectAtIndex:_currentImageIndex];
    //获取点击图片相对window的frame
    CGRect originalRect = [containerView convertRect:originalView.frame toView:self];
    
    GLLBrowserImageView *imageView = _myScrollView.subviews[_currentImageIndex];
    
    CGFloat imageViewX = imageViewMargin + (imageViewMargin * 2 + CGRectGetWidth(self.frame)) * _currentImageIndex;

    imageView.frame = CGRectMake(imageViewX  + CGRectGetMinX(originalRect), CGRectGetMinY(originalRect), CGRectGetWidth(originalRect), CGRectGetHeight(originalRect));
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:imageViewChangeFrameDuration];
    [UIView setAnimationDelegate:self];
    
    imageView.center = CGPointMake(imageViewX + self.center.x, CGRectGetHeight(self.frame) / 2.0);
    
    [UIView commitAnimations];
    
}

- (void)scrollViewShowImageView
{
    //图片数组的父视图
    UIView *containerView = (UIView *)_delegate;
    //被点击的图片
    UIButton *originalView = [containerView.subviews objectAtIndex:_currentImageIndex];
    //获取点击图片相对window的frame
    CGRect originalRect = [containerView convertRect:originalView.frame toView:self];
    
    GLLBrowserImageView *imageView = _myScrollView.subviews[_currentImageIndex];
    
    CGFloat imageViewX = imageViewMargin + (imageViewMargin * 2 + CGRectGetWidth(self.frame)) * _currentImageIndex;
    
    imageView.frame = CGRectMake(imageViewX  + CGRectGetMinX(originalRect), CGRectGetMinY(originalRect), CGRectGetWidth(originalRect), CGRectGetHeight(originalRect));
    
    imageView.center = CGPointMake(imageViewX + self.center.x, CGRectGetHeight(self.frame) / 2.0);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{

    if (isAnimationing) {
        
        //停止动画时缩略图的位置
//        CGRect animationingRect = _temImageView.frame;
        
        [self refreshBigImageView];
        
    }

    firstImageViewIsShowing = YES;
    
    
}

- (void)refreshBigImageView
{
    
    GLLBrowserImageView *imageView = _myScrollView.subviews[_currentImageIndex];
    
    //加载大图成功则变化frame否则不变
    if (imageView.loadBigPictureSuccess) {
        
        CGFloat imageViewY = 0;
        CGFloat imageViewW = CGRectGetWidth(self.bounds);
        CGFloat imageViewH = CGRectGetHeight(self.bounds);
        CGFloat buttonX = imageViewMargin + (imageViewMargin * 2 + imageViewW) * _currentImageIndex;

        [UIView animateWithDuration:imageViewChangeFrameDuration animations:^{
            
            imageView.frame = CGRectMake(buttonX, imageViewY, imageViewW, imageViewH);
//            imageView.center = self.center;
            
        } completion:^(BOOL finished) {
            
            
        }];
    }

    

}

// 加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index
{
    GLLBrowserImageView *imageView = _myScrollView.subviews[index];
    self.currentImageIndex = index;
    if (imageView.hasLoadedImage) return;

    [self scrollViewShowImageView];
    
    if ([self getBigImageWithIndex:index]) {
        
        [imageView setImageWithURL:[self getBigImageWithIndex:index] placeholderImage:[self getThumbNailPicture:index] WithBlock:^(NSString *result) {
            
                isAnimationing = YES;
                //如果是加载的是第一张图片则先不显示等待动画完成
                if (firstImageViewIsShowing) {
                    [self refreshBigImageView];
                }
        }];
    } else {
        imageView.image = [self getThumbNailPicture:index];
    }
    imageView.hasLoadedImage = YES;
}

#pragma mark - 获取大图
- (NSURL *)getBigImageWithIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(getBigImageWithIndex:)]) {
        return [self.delegate getBigImageWithIndex:index];
    }
    return nil;
}

#pragma mark - 获取缩略图
- (UIImage *)getThumbNailPicture:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(getThumbNailPicture:)]) {
        return [self.delegate getThumbNailPicture:index];
    }
    return nil;
}


#pragma mark - 单击图片还原
- (void)singleTapClicked:(UITapGestureRecognizer *)tap
{
    NSLog(@"单击图片还原");
    
    //图片数组的父视图
    UIView *containerView = (UIView *)_delegate;
    //被点击的图片
    UIButton *originalView = [containerView.subviews objectAtIndex:_currentImageIndex];
    //获取点击图片相对window的frame
    CGRect originalRect = [containerView convertRect:originalView.frame toView:self];
    
    GLLBrowserImageView *currentImageView = [_myScrollView.subviews objectAtIndex:_currentImageIndex];
    
    if (currentImageView.isScaled){
        
        currentImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(_myScrollView.frame));
        
    }
    
    CGFloat imageViewX = imageViewMargin + (imageViewMargin * 2 + CGRectGetWidth(self.frame)) * _currentImageIndex;
    
    CGRect targetFrame = CGRectMake(imageViewX  + CGRectGetMinX(originalRect), CGRectGetMinY(originalRect), CGRectGetWidth(originalRect), CGRectGetHeight(originalRect));
    
    [UIView animateWithDuration:imageViewChangeFrameDuration animations:^{
        currentImageView.frame = targetFrame;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}

#pragma mark - 双击图片放大
- (void)doubleTapClicked:(UITapGestureRecognizer *)tap
{
    NSLog(@"双击图片放大");
    GLLBrowserImageView *imageView = (GLLBrowserImageView *)tap.view;
    CGFloat scale;
    if (imageView.isScaled) {
        scale = 1.0;
    } else {
        scale = 2.0;
    }
    
    [imageView doubleTapToZommWithScale:scale];
}

#pragma mark - 显示本界面
- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
}

#pragma mark - scrollview代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + _myScrollView.bounds.size.width * 0.5) / _myScrollView.bounds.size.width;
    
    [self setupImageOfImageViewForIndex:index];
}

- (void)dealloc
{
    NSLog(@"GLLPhotoBrowserView dealloc");
}

@end
