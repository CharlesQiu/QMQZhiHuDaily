//
//  QMQLatestNewsDetailViewController.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/24/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@interface QMQLatestNewsDetailViewController : UIViewController

/// 最新新闻详情
@property(nonatomic, strong) RACSignal *newsDetailSignal;

@end
