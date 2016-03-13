//
//  QMQLatestNewsDetailCell.h
//  QMQZhiHuDaily
//
//  Created by Charles on 3/13/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMQLatestNewsDetailModel;

@interface QMQLatestNewsDetailCell : UITableViewCell

- (void)configureCell:(QMQLatestNewsDetailModel *)model;

@end
