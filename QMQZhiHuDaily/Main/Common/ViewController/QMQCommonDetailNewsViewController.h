//
//  QMQCommonDetailNewsViewController.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/1/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@interface QMQCommonDetailNewsViewController : UIViewController

/// 最新新闻详情
@property(nonatomic, strong) RACSignal *newsDetailSignal;

@end
