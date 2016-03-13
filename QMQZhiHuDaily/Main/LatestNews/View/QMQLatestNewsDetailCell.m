//
//  QMQLatestNewsDetailCell.m
//  QMQZhiHuDaily
//
//  Created by Charles on 3/13/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsDetailCell.h"
#import "DTCoreText.h"
#import "QMQLatestNewsDetailModel.h"

@import WebKit;

@interface QMQLatestNewsDetailCell ()

@property (nonatomic, strong) DTAttributedLabel *htmlLabel;

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation QMQLatestNewsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.htmlLabel = [[DTAttributedLabel alloc] init];
    [self.contentView addSubview:self.htmlLabel];
    [self.htmlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    self.webView = [[WKWebView alloc] init];
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    return self;
}

- (void)configureCell:(QMQLatestNewsDetailModel *)model {
    if (!model.body) {
        return;
    }
    
    NSString *htmlString = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=%@ /></head><body>%@</body></html>", model.css, model.body];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
