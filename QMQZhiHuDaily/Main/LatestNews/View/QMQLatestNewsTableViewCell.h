//
//  QMQLatestNewsTableViewCell.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMQLatestNewsModel.h"

@interface QMQLatestNewsTableViewCell : UITableViewCell

- (void)configureCell:(QMQLatestNewsModel *)model;

@end
