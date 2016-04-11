//
//  QMQThemeListViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQThemeListViewModel.h"
#import "QMQCommonListModel.h"

@interface QMQThemeListViewModel ()

@property (nonatomic, copy) NSArray *modelArray;

@end

@implementation QMQThemeListViewModel

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
        return [QMQRacHttpService racGet:API_THEME_DETAIL(input) param:nil];
    }];
}

- (void)initSubscribe {
    @weakify(self);
    [[_loadCommand.executionSignals switchToLatest] subscribeNext:^(QMQHttpBaseResponse *response) {
        @strongify(self);
        if (!response) {
            [self.errors sendNext:response.originalDict];
        } else {
            QMQCommonListModel *model = [[QMQCommonListModel alloc] initWithDic:response.originalDict];
            self.modelArray = [model.modelArray copy];
        }
    }];
}

@end
