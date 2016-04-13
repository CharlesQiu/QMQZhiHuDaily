//
//  QMQUserCenterViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQUserCenterViewController.h"
#import "QMQAccountInfo.h"
#import "UIImageView+WebImageFadeInEffect.h"
#import "QMQLoginManager.h"

@interface QMQUserCenterViewController ()


@end

static CGFloat const kAvatarWidth = 100.0;

@implementation QMQUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.title = self.accountInfo.nickName;
    
    UIImageView *imageView = [UIImageView new];
    imageView.layer.cornerRadius  = kAvatarWidth / 2;
    imageView.layer.masksToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.accountInfo.avatarUrlLarge] placeholderImage:nil fadeInWithDuration:0.3];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(kAvatarWidth, kAvatarWidth));
    }];
    
    UILabel *provinceAndCityLabel = [UILabel new];
    provinceAndCityLabel.text = [NSString stringWithFormat:@"%@ | %@", self.accountInfo.province, self.accountInfo.city];
    provinceAndCityLabel.font = [UIFont fontWithName:FONT_DEFAULT_LIGHT size:20.0];
    [self.view addSubview:provinceAndCityLabel];
    [provinceAndCityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom).offset(15.0);
    }];
    
    /// 删除登陆页面
    self.navigationController.viewControllers = @[self];
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [logoutButton.titleLabel setFont:[UIFont fontWithName:FONT_DEFAULT_LIGHT size:20.0]];
    logoutButton.layer.borderColor  = [UIColor redColor].CGColor;
    logoutButton.layer.borderWidth  = 1.0;
    logoutButton.layer.cornerRadius = 3.0;
    [logoutButton setTintColor:[UIColor redColor]];
    [self.view addSubview:logoutButton];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(imageView);
        make.bottom.equalTo(self.view).offset(-50.0);
        make.width.equalTo(@(100.0));
    }];
    [[logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:QMQisLogin];
        NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"account.data"];
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:file];
        if (isExist) {
            [[NSFileManager defaultManager] removeItemAtPath:file
                                                       error:nil];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
