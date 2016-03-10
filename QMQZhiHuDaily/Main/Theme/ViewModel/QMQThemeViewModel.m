//
//  QMQThemeViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/29/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQThemeViewModel.h"
#import "QMQThemeListModel.h"

@interface QMQThemeViewModel ()

@property (nonatomic, copy) NSArray *modelArray;

@end

@implementation QMQThemeViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initCommand];
        [self initSubscribe];
    }
    return self;
}

- (void)initCommand {
    _loadCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [QMQRacHttpService racGet:API_THEMES param:nil];
    }];
}

- (void)initSubscribe {
    @weakify(self);
    [[_loadCommand.executionSignals switchToLatest] subscribeNext:^(QMQHttpBaseResponse *response) {
        @strongify(self);
        if (!response) {
            [self.errors sendNext:response.originalDict];
        } else {
            QMQThemeListModel *model = [[QMQThemeListModel alloc] initWithDic:response.originalDict];
            self.modelArray = [model.modelArray copy];
        }
    }];
}

@end
