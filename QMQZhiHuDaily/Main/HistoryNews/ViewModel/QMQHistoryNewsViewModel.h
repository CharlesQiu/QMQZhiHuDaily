//
//  QMQHistoryNewsViewModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQRacBaseViewModel.h"

@interface QMQHistoryNewsViewModel : QMQRacBaseViewModel

@property (nonatomic, readonly, copy) RACCommand *loadCommand;
@property (nonatomic, readonly, copy) NSArray *modelArray;

@end
