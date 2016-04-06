//
//  QMQLatestNewsTableViewCell.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsTableViewCell.h"
#import "UIImageView+WebImageFadeInEffect.h"

@interface QMQLatestNewsTableViewCell ()

/// 图片
@property(nonatomic, strong) UIImageView *customImageView;
/// 标题
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation QMQLatestNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.customImageView               = [UIImageView new];
        self.customImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.customImageView];
        
        self.titleLabel               = [UILabel new];
        self.titleLabel.font          = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        [self.customImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(10);
            make.left.equalTo(self.contentView).with.offset(15);
            make.width.mas_equalTo(100.0f);
            make.bottom.equalTo(self.contentView).with.offset(-10);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.customImageView.mas_right).with.offset(10);
            make.right.equalTo(self.contentView).with.offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configureCell:(QMQLatestNewsModel *)model {
    [self.customImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]
                            placeholderImage:nil
                          fadeInWithDuration:0.33f];
    self.titleLabel.text = model.title;
}

@end
