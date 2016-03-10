//
//  QMQHotNewsTableViewCell.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/28/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMQHotNewsModel;

@interface QMQHotNewsTableViewCell : UITableViewCell

- (void)configureCell:(QMQHotNewsModel *)model;

@end
