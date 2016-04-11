//
//  QMQLoginViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/11/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLoginViewController.h"
#import "QMQTencentLogin.h"

@interface QMQLoginViewController ()

@end

/// 按钮大小
static CGFloat const kButtonSize = 100.0;
/// 按钮间距
static CGFloat const kButtonSpacing = 40.0;

@implementation QMQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登陆";
    
    UIImage *normalImage = [UIImageUtil imageWithIconFontCode:QMQIconCross
                                                        color:[UIColor whiteColor]
                                                     fontSize:QMQNavigationBarIconSize];
    UIImage *disableImage = [UIImageUtil imageWithIconFontCode:QMQIconCross
                                                         color:[UIColor grayColor]
                                                      fontSize:QMQNavigationBarIconSize];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:normalImage
            forState:UIControlStateNormal];
    [button setImage:disableImage
            forState:UIControlStateDisabled];
    [button sizeToFit];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *button) {
         @strongify(self);
         [self dismissViewControllerAnimated:YES completion:nil];
     }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // QQ按钮
    UIImage *qqImage = [UIImageUtil imageWithIconFontCode:QMQIconQQ
                                                    color:[UIColor colorWithHexString:QMQStyleColor]
                                                 fontSize:kButtonSize];
    UIButton *qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqButton setImage:qqImage forState:UIControlStateNormal];
    [[qqButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[QMQTencentLogin shareInstance] loginWithTencentQQ];
    }];
    [self.view addSubview:qqButton];
    
    // 微信按钮
    UIImage *weixinImage = [UIImageUtil imageWithIconFontCode:QMQIconWeixin
                                                    color:[UIColor colorWithHexString:QMQStyleColor]
                                                 fontSize:kButtonSize];
    UIButton *weixinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weixinButton setImage:weixinImage forState:UIControlStateNormal];
    [[weixinButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [self.view addSubview:weixinButton];

    // 微博按钮
    UIImage *weiboImage = [UIImageUtil imageWithIconFontCode:QMQIconWeibo
                                                        color:[UIColor colorWithHexString:QMQStyleColor]
                                                     fontSize:kButtonSize];
    UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboButton setImage:weiboImage forState:UIControlStateNormal];
    [[weiboButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [self.view addSubview:weiboButton];

    [weixinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weixinButton);
        make.bottom.equalTo(weixinButton.mas_top).offset(-kButtonSpacing);
    }];
    [weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weixinButton);
        make.top.equalTo(weixinButton.mas_bottom).offset(kButtonSpacing);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
