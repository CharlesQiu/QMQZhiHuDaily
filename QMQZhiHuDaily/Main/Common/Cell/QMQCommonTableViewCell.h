//
//  QMQCommonTableViewCell.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMQCommonTableViewCell<ObjectType> : UITableViewCell

- (void)configureCell:(ObjectType)model;

@end
