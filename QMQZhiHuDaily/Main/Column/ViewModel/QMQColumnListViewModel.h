//
//  QMQColumnListViewModel.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQRacBaseViewModel.h"

@interface QMQColumnListViewModel : QMQRacBaseViewModel

@property (nonatomic, readonly, copy) RACCommand *loadCommand;
@property (nonatomic, readonly, copy) NSArray    *modelArray;

@end
