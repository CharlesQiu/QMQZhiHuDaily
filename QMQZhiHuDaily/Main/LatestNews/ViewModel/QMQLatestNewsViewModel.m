//
//  QMQLatestNewsViewModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsViewModel.h"
#import "QMQHttpService.h"
#import "QMQLatestNewsModel.h"
#import "QMQLatestNewsTableViewCell.h"
#import "UIImageView+WebImageFadeInEffect.h"

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
                VerboseLog(response);
                if (response.success) {
                    [subscriber sendNext:response.originalDict];
                    [subscriber sendCompleted];
                }
            }];
            return nil;
        }];
        
        return [requestSignal map:^id (NSDictionary *value) {
            NSMutableArray *dictArray = value[@"stories"];
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
    static NSString            *ID   = @"cell";
    QMQLatestNewsTableViewCell *cell = (QMQLatestNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[QMQLatestNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    QMQLatestNewsModel *model = self.modelArray[indexPath.row];
    
    [cell.customImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:icomoonImage(kIFTabbarLatestnews, hexString(kIFTabbarLatestnewsColor), 25.0f) fadeInWithDuration:0.33f];
    cell.titleLabel.text = model.title;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
