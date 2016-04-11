//
//  QMQColumnListViewController.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@interface QMQColumnListViewController : UIViewController

/// 获取专栏列表数据
@property (nonatomic, strong) RACSignal *getColumnDetailSignal;

@end
