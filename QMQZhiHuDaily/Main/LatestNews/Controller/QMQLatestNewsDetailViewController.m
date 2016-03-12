//
//  QMQLatestNewsDetailViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/24/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsDetailViewController.h"
#import "QMQLatestNewsDetailModel.h"

#import "UIImageView+WebImageFadeInEffect.h"

@interface QMQLatestNewsDetailViewController ()

@property(nonatomic, strong) UIImageView *coverImageView;

@end
@implementation QMQLatestNewsDetailViewController

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];

    @weakify(self);
    [self.newsDetailSignal subscribeNext:^(id x) {
        @strongify(self);
        [self loadData:[x unsignedIntegerValue]];
    }];

    self.coverImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - Request Data

- (void)loadData:(NSUInteger)newsId {
    @weakify(self);
    [QMQHttpService getWithUrl:API_GET_NEWS_DETAIL(newsId)
                         param:nil
                 responseBlock:^(QMQHttpBaseResponse *response) {
                     @strongify(self);
                     if (!response.success) {
                         return;
                     }
                     LOGVERBOSE(response.originalDict);
                     QMQLatestNewsDetailModel *model = [[QMQLatestNewsDetailModel alloc] initWithDic:response.originalDict];
                     [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil fadeInWithDuration:0.3f];
                 }];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
