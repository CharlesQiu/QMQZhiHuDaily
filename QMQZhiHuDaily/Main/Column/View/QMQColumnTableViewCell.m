//
//  QMQColumnTableViewCell.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQColumnTableViewCell.h"
#import "QMQColumnModel.h"
#import "UIImageView+WebImageFadeInEffect.h"
#import "NSString+Extend.h"

@interface QMQColumnTableViewCell ()

/// 图片
@property (nonatomic, strong) UIImageView *customImageView;
/// 标题和描述的容器view，方便自适应
@property (nonatomic, strong) UIView *containerView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 描述
@property (nonatomic, strong) UILabel *descriptionLabel;

/// 标题bottom约束
@property (nonatomic, strong) MASConstraint *cTitleLabelBottom;
/// 描述文字顶部约束
@property (nonatomic, strong) MASConstraint *cDescriptionTop;

@end

/// 标题和描述之间的间隙
static CGFloat const kTitleAndDescriptionSpacing = 5.0;

@implementation QMQColumnTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.customImageView               = [[UIImageView alloc] init];
        self.customImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.customImageView];
        
        self.containerView = [UIView new];
        [self.contentView addSubview:self.containerView];
        
        self.titleLabel               = [[UILabel alloc] init];
        self.titleLabel.font          = [UIFont systemFontOfSize:16.0];
        self.titleLabel.numberOfLines = 0;
        [self.containerView addSubview:self.titleLabel];
        
        self.descriptionLabel               = [UILabel new];
        self.descriptionLabel.font          = [UIFont systemFontOfSize:12.0];
        self.descriptionLabel.textColor     = [UIColor grayColor];
        self.descriptionLabel.numberOfLines = 0;
        [self.containerView addSubview:self.descriptionLabel];
        
        @weakify(self);
        [self.customImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.left.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(10.0, 15.0, 10.0, 0.0));
            make.width.equalTo(@100.0);
        }];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.customImageView.mas_right).offset(10.0);
            make.right.equalTo(self.contentView).offset(-10.0);
            make.centerY.equalTo(self.contentView);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.top.left.right.equalTo(self.containerView).insets(UIEdgeInsetsZero);
            make.bottom.equalTo(self.descriptionLabel.mas_top).offset(-kTitleAndDescriptionSpacing).priorityLow();
            
            self.cTitleLabelBottom = make.bottom.equalTo(self.containerView).priorityHigh();
            [self.cTitleLabelBottom deactivate];
        }];
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.bottom.left.right.equalTo(self.containerView).insets(UIEdgeInsetsZero);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(kTitleAndDescriptionSpacing).priorityLow();
            
            self.cDescriptionTop = make.top.equalTo(self.titleLabel.mas_bottom).priorityHigh();
            [self.cDescriptionTop deactivate];
        }];
    }
    return self;
}

- (void)configureCell:(QMQColumnModel *)model {
    [self.customImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]
                            placeholderImage:nil
                          fadeInWithDuration:0.3f];
    self.titleLabel.text = model.name;
    if ([NSString isEmptyString:model.columnDescription]) {
        [self.cTitleLabelBottom activate];
        [self.cDescriptionTop activate];
    } else {
        self.descriptionLabel.text = model.columnDescription;
        [self.cTitleLabelBottom deactivate];
        [self.cDescriptionTop deactivate];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
