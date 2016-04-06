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
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [self webView];
    @weakify(self);
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
        
        // Code from http://stackoverflow.com/questions/26295277/wkwebview-equivalent-for-uiwebviews-scalespagetofit
        // Let WKWebView support the UIWebView's "scalesPageToFit" property.
//        NSString     *jScript   = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript
//                                                         injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
//                                                      forMainFrameOnly:YES];
//        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//        [wkUController addUserScript:wkUScript];
//        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//        wkWebConfig.userContentController = wkUController;
//        _webView                          = [[WKWebView alloc] initWithFrame:CGRectZero
//                                                               configuration:wkWebConfig];
        
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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:kIFTabbarHotnewsColor];
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
