//
//  QMQCommonDetailNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/1/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQCommonDetailNewsViewController.h"
#import "QMQLatestNewsDetailModel.h"
#import "QMQLatestNewsDetailViewModel.h"

#import "UIImageView+WebImageFadeInEffect.h"
#import <UIImageView+WebCache.h>

@import WebKit;

@interface QMQCommonDetailNewsViewController ()

@property (nonatomic, strong) UIWebView                    *webView;
@property (nonatomic, strong) UIImage                      *headerImage;
@property (nonatomic, strong) QMQLatestNewsDetailViewModel *viewModel;
@property (nonatomic, strong) QMQLatestNewsDetailModel     *model;
@property (nonatomic, copy) NSString                       *css;

@end

@implementation QMQCommonDetailNewsViewController

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIImage *normalImage = [UIImageUtil imageWithIconFontCode:QMQIconBack
                                                        color:[UIColor colorWithHexString:QMQStyleColor]
                                                     fontSize:QMQNavigationBarIconSize];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:normalImage
            forState:UIControlStateNormal];
    [button sizeToFit];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *button) {
         @strongify(self);
         [self.navigationController popViewControllerAnimated:YES];
     }];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    [self webView];
    [self.newsDetailSignal subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel = [[QMQLatestNewsDetailViewModel alloc] init];
        [self.viewModel.requestCommand execute:x];
    }];
    
    [RACObserve(self.viewModel, model) subscribeNext:^(QMQLatestNewsDetailViewModel *model) {
        @strongify(self);
        if (!model) {
            return;
        }
        NSString *htmlString = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=%@ /></head><body>%@</body></html>", self.viewModel.model.css, self.viewModel.model.body];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:self.viewModel.model.css]];
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

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [UIWebView new];
        [self.view addSubview:_webView];
        @weakify(self);
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.view);
        }];
    }
    return _webView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:QMQStyleColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
