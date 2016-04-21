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
#import "OpenShareHeader.h"
#import "UIImageView+WebImageFadeInEffect.h"
#import <UIImageView+WebCache.h>

@import WebKit;

@interface QMQCommonDetailNewsViewController ()

@property (nonatomic, strong) UIWebView                    *webView;
@property (nonatomic, strong) UIImageView                  *topImageView;
@property (nonatomic, strong) UIImage                      *headerImage;
@property (nonatomic, strong) QMQLatestNewsDetailViewModel *viewModel;
@property (nonatomic, copy) NSString                       *css;

@end

static CGFloat const kTopImageHeight = 200.0;

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
    
    UIImage *shareImage = [UIImageUtil imageWithIconFontCode:QMQIconShare
                                                       color:[UIColor whiteColor]
                                                    fontSize:QMQNavigationBarIconSize];
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:shareImage forState:UIControlStateNormal];
    [shareButton sizeToFit];
    [[shareButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self);
         OSMessage *msg = [[OSMessage alloc] init];
         msg.title = self.viewModel.model.shareUrl;
         //分享到QQ
         [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
             QMQLog(@"分享到QQ好友成功:%@", msg);
         } Fail:^(OSMessage *message, NSError *error) {
             QMQLog(@"分享到QQ好友失败:%@\n%@", msg, error);
         }];
     }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
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
        [self.webView loadHTMLString:self.viewModel.model.bodyNew baseURL:[NSURL URLWithString:self.viewModel.model.css]];
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.model.imageUrl] placeholderImage:nil fadeInWithDuration:0.3];
    }];
}

#pragma mark - Lazy load

- (UIWebView *)webView {
    if (!_webView) {
        _webView                         = [UIWebView new];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(kTopImageHeight, 0.0, 0.0, 0.0);
        
        _topImageView                 = [UIImageView new];
        _topImageView.clipsToBounds   = YES;
        [_webView.scrollView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(_webView).insets(UIEdgeInsetsZero);
            make.top.equalTo(_webView.scrollView).offset(-kTopImageHeight);
            make.height.equalTo(@(kTopImageHeight));
        }];
        
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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
