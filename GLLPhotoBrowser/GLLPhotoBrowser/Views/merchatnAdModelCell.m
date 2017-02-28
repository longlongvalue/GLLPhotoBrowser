//
//  merchatnAdModelCellTableViewCell.m
//  GLLPhotoBrowser
//
//  Created by 淘卡淘 on 2017/1/16.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#define margin 10.0
#define  contentLableFontSize 16

#import "merchatnAdModelCell.h"
#import "UIImageView+WebCache.h"

#import "GLLPhotoGroupView.h"

@interface merchatnAdModelCell ()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) GLLPhotoGroupView *imagesContainerView;

@end

@implementation merchatnAdModelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUI];
        
    }
    return self;
}

- (void)setUI
{
    
    //头像
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, 60, 60)];
    [self.contentView addSubview:_headerImageView];
    
    //昵称
    _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + margin, margin, CGRectGetWidth(self.contentView.frame) - (CGRectGetMaxX(_headerImageView.frame) + margin * 2), 30.0)];
    [self.contentView addSubview:_nickNameLabel];
    
    //内容
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nickNameLabel.frame), CGRectGetMaxY(_nickNameLabel.frame), CGRectGetWidth(_nickNameLabel.frame), 30.0)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:contentLableFontSize];
    [self.contentView addSubview:_contentLabel];
    
    //底部图片数组的容器View
    _imagesContainerView = [[GLLPhotoGroupView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nickNameLabel.frame), CGRectGetMaxY(_contentLabel.frame), CGRectGetWidth(_contentLabel.frame), 0.0)];
    _imagesContainerView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imagesContainerView];
    
    
}

- (void)setAdModel:(MechantAdModel *)adModel
{
    _adModel = adModel;
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:adModel.headerUrlStr]];
    
    _nickNameLabel.text = adModel.nickNameStr;
    
    _contentLabel.text = adModel.contentStr;
    
    CGSize contentLabelSize = [self getSizeWithContentStr:adModel.contentStr MaxSize:CGSizeMake(CGRectGetWidth(_contentLabel.frame), CGFLOAT_MAX) AndTextFont:contentLableFontSize];
    
    CGRect contentRect = _contentLabel.frame;
    contentRect.size.height = contentLabelSize.height;
    _contentLabel.frame = contentRect;
    
    _imagesContainerView.adModel = adModel;
    
    CGRect imageContainerViewRect = _imagesContainerView.frame;
    imageContainerViewRect.origin.y = CGRectGetMaxY(_contentLabel.frame) + margin;
    _imagesContainerView.frame = imageContainerViewRect;
    
    CGRect frame = [self frame];
    frame.size.height = CGRectGetMaxY(imageContainerViewRect);
    self.frame = frame;
 
}

- (CGSize)getSizeWithContentStr:(NSString *)text MaxSize:(CGSize)size AndTextFont:(CGFloat)fontSize
{
    return  [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
