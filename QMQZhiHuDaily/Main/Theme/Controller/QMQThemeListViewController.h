//
//  QMQThemeListViewController.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@interface QMQThemeListViewController : UIViewController

/// 获取专题列表数据
@property (nonatomic, strong) RACSignal *getColumnDetailSignal;

@end
