//
//  QMQHistoryNewsTableViewCell.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQHistoryNewsTableViewCell.h"
#import "QMQHistoryNewsModel.h"
#import "UIImageView+WebImageFadeInEffect.h"

@interface QMQHistoryNewsTableViewCell ()

/// 图片
@property(nonatomic, strong) UIImageView *customImageView;
/// 标题
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation QMQHistoryNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.customImageView               = [[UIImageView alloc] init];
        self.customImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.customImageView];
        
        self.titleLabel               = [[UILabel alloc] init];
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

- (void)configureCell:(QMQHistoryNewsModel *)model {
    [self.customImageView sd_setImageWithURL:[NSURL URLWithString:model.imageArr[0] ? : nil]
                            placeholderImage:nil
                          fadeInWithDuration:0.33f];
    self.titleLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
