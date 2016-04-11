//
//  QMQCommonTableViewCell.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQCommonTableViewCell.h"
#import "UIImageView+WebImageFadeInEffect.h"
#import "QMQCommonCellModel.h"

@interface QMQCommonTableViewCell ()

/// 图片
@property (nonatomic, strong) UIImageView *customImageView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 时间戳
@property (nonatomic, strong) UILabel *dateStamp;

@end

@implementation QMQCommonTableViewCell

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
        
        self.dateStamp           = [UILabel new];
        self.dateStamp.font      = [UIFont systemFontOfSize:11.0];
        self.dateStamp.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.dateStamp];
        
        @weakify(self);
        [self.customImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.left.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(10.0, 15.0, 10.0, 0.0));
            make.width.mas_equalTo(100.0f);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.customImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.dateStamp mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(0.0, 0.0, 5.0, 5.0));
        }];
    }
    return self;
}

- (void)configureCell:(QMQCommonCellModel *)model {
    [self.customImageView sd_setImageWithURL:[NSURL URLWithString:model.imageArr[0] ? : nil]
                            placeholderImage:nil
                          fadeInWithDuration:0.33f];
    self.titleLabel.text = model.title;

    if (model.date) {
        self.dateStamp.text = model.date;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
