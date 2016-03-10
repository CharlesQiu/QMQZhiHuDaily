//
//  QMQHistoryNewsTableViewCell.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMQHistoryNewsModel;

@interface QMQHistoryNewsTableViewCell : UITableViewCell

- (void)configureCell:(QMQHistoryNewsModel *)model;

@end
