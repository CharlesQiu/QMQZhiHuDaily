//
//  QMQLatestNewsViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsViewModel.h"
#import "QMQLatestNewsTableViewCell.h"
#import "UIImageView+WebImageFadeInEffect.h"

@interface QMQLatestNewsViewModel ()

@property(nonatomic, assign) NSUInteger tapCellNewsId;

@end

@implementation QMQLatestNewsViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialBind];
    }
    return self;
}

- (void)initialBind {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
            [QMQHttpService getWithUrl:API_LATEST_NEWS param:nil responseBlock:^(QMQHttpBaseResponse *response) {
                LOG_VERBOSE(response);
                if (response.success) {
                    [subscriber sendNext:response.originalDict];
                    [subscriber sendCompleted];
                }
            }];
            return nil;
        }];
        
        return [requestSignal map:^id (NSDictionary *value) {
            NSArray *dictArray = value[@"stories"];
            NSArray *modelArr = [[dictArray.rac_sequence map:^id (id value) {
                QMQLatestNewsModel *model = [[QMQLatestNewsModel alloc] initWithDic:value];
                return model;
            }] array];
            return modelArr;
        }];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString                   *ID   = NSStringFromClass([QMQLatestNewsTableViewCell class]);
    QMQLatestNewsTableViewCell *cell = (QMQLatestNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QMQLatestNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    [cell configureCell:self.modelArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QMQLatestNewsModel *model = self.modelArray[indexPath.row];
    self.tapCellNewsId = model.newsId;
}

@end
