//
//  QMQLatestNewsDetailViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/24/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsDetailViewController.h"
#import "QMQLatestNewsDetailModel.h"
#import "QMQLatestNewsDetailViewModel.h"
#import "QMQLatestNewsDetailCell.h"

#import "UIImageView+WebImageFadeInEffect.h"

@import WebKit;

@interface QMQLatestNewsDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView                  *coverImageView;
@property (nonatomic, strong) WKWebView                    *webView;
@property (nonatomic, strong) UIImage                      *headerImage;
@property (nonatomic, strong) UITableView                  *tableView;
@property (nonatomic, strong) QMQLatestNewsDetailViewModel *viewModel;
@property (nonatomic, strong) QMQLatestNewsDetailModel     *model;
@property (nonatomic, copy) NSString                       *css;
@end
@implementation QMQLatestNewsDetailViewController

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor                 = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    //    [self tableView];
    [self webView];
    @weakify(self);
    [self.newsDetailSignal subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel = [[QMQLatestNewsDetailViewModel alloc] init];
        [self.viewModel.requestCommand execute:x];
    }];
    
    [[[[RACObserve(self.viewModel, model) ignore:nil] flattenMap:^RACStream *(QMQLatestNewsDetailModel *model) {
        @strongify(self);
        if (!model) {
            return nil;
        }
        return [self loadImageWithUrl:self.viewModel.model.imageUrl];
    }] deliverOn:[RACQueueScheduler mainThreadScheduler]] subscribeNext:^(UIImage *headerImage) {
        @strongify(self);
        NSString *htmlString = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=%@ /></head><body>%@</body></html>", self.css, self.viewModel.model.body];
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
        if (headerImage) {
            
            self.coverImageView.image = headerImage;
            CGSize imageSize = headerImage.size;
            self.webView.scrollView.contentInset = UIEdgeInsetsMake(imageSize.height, 0.0, 0.0, 0.0);
            [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.bottom.equalTo(self.webView.scrollView);
                make.height.equalTo(self.webView.scrollView).multipliedBy(0.6);
            }];
        }
    }];
}

- (RACSignal *)loadImageWithUrl:(NSString *)url {
    return [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            [subscriber sendNext:image];
        }];
        
        return nil;
    }];
}

#pragma mark - Lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView            = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.rowHeight  = 1000.0f;
        [_tableView registerClass:[QMQLatestNewsDetailCell class] forCellReuseIdentifier:NSStringFromClass([QMQLatestNewsDetailCell class])];
        [self.view addSubview:_tableView];
        @weakify(self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [WKWebView new];
        [self.view addSubview:_webView];
        @weakify(self);
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.view);
        }];
    }
    return _webView;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView               = [UIImageView new];
        _coverImageView.clipsToBounds = YES;
        [self.webView.scrollView addSubview:_coverImageView];
    }
    return _coverImageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMQLatestNewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QMQLatestNewsDetailCell class]) forIndexPath:indexPath];
    
    [cell configureCell:self.model];
    
    return cell;
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

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
