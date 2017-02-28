//
//  GLLPhotoGroupView.m
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/16.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#define imageButtonTag 0

#import "GLLPhotoGroupView.h"

#import "UIButton+WebCache.h"

#import "GLLPhotoBrowserView.h"

@interface GLLPhotoGroupView ()<GLLPhotoBrowserViewDelegate>

@end

@implementation GLLPhotoGroupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setAdModel:(MechantAdModel *)adModel
{
    _adModel = adModel;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    

    
    CGRect frame = [self frame];
    
    if (adModel.imageUrlArray.count > 0) {
        
        NSInteger column = 3;
        
        NSInteger row = (adModel.imageUrlArray.count - 1) / column + 1;
        
        CGFloat margin = 5.0;
        
        CGFloat buttonW = (CGRectGetWidth(self.frame) - (column - 1) * margin) / column;
        
        CGFloat buttonH = buttonW;
        
        [adModel.imageUrlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSInteger currentRow = idx / column;
            
            NSInteger currentColumn = idx % column;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((buttonW + margin) * currentColumn, (buttonH + margin) * currentRow, buttonW, buttonH)];
            
            button.tag = imageButtonTag + idx;
            
            button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            
            [button sd_setImageWithURL:[NSURL URLWithString:obj] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            
        }];
        
        frame.size.height = (buttonH + margin) * row;
        
    }else{
        
        frame.size.height = 0;
        
    }
    
    self.frame = frame;
    
    
}

- (void)buttonClick:(UIButton *)button
{
    NSLog(@"=========%ld==========",(long)button.tag);
    GLLPhotoBrowserView *browser = [[GLLPhotoBrowserView alloc] init];
    browser.imageCount = self.adModel.imageUrlArray.count; // 图片总数
    browser.currentImageIndex = button.tag;
    browser.delegate = self;
    [browser show];
}

- (NSURL *)getBigImageWithIndex:(NSInteger)imageIndex
{
    NSString *urlStr = self.adModel.imageHightUrlStrArray[imageIndex];
    return [NSURL URLWithString:urlStr];
}

- (UIImage *)getThumbNailPicture:(NSInteger)imageIndex
{
    return [self.subviews[imageIndex] currentImage];
}

@end
