//
//  QMQLoginManager.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLoginManager.h"
#import "QMQAccountInfo.h"
#import "OpenShareHeader.h"

@interface QMQLoginManager ()

@property (nonatomic, strong) QMQAccountInfo *accountInfo;

@property (nonatomic, copy) LoginSuccess success;
@property (nonatomic, copy) LoginFailure failure;

@end

NSString *const QMQisLogin = @"QMQisLogin";

static NSString *const tencentAppId = @"1105322490";

@implementation QMQLoginManager

static QMQLoginManager *_instance = nil;

/// 防止单例重复创建
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:QMQisLogin]) {
            NSString *file = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"account.data"];
            _instance.accountInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        }
        
    });
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [QMQLoginManager shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [QMQLoginManager shareInstance];
}

#pragma mark - QQ登陆
- (void)loginWithTencentQQSuccess:(LoginSuccess)success failure:(LoginFailure)failure {
    @weakify(self);
    [OpenShare QQAuth:@"get_user_info" Success:^(NSDictionary *message) {
        @strongify(self);
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:QMQisLogin];
        NSString *url = [NSString stringWithFormat:@"https://graph.qq.com/user/get_user_info?oauth_consumer_key=%@&access_token=%@&openid=%@&format=json", tencentAppId, message[@"access_token"], message[@"openid"]];
        NSDictionary *userDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]] options:NSJSONReadingAllowFragments error:nil];
        self.accountInfo = [[QMQAccountInfo alloc] initWithDic:[userDict copy]];
        self.success(self.accountInfo);
        
    } Fail:^(NSDictionary *message, NSError *error) {
        QMQLog(@"QQ登录失败\n%@\n%@", error, message);
    }];
    
    self.success = success;
    self.failure = failure;
}

#pragma mark - 微信登录
/// 需要认证开发者（300rmb/年）
- (void)loginWithWeiXinSuccess:(LoginSuccess)success failure:(LoginFailure)failure {
    @weakify(self);
    [OpenShare WeixinAuth:@"snsapi_userinfo"
                  Success:^(NSDictionary *message) {
                      @strongify(self);
                      [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:QMQisLogin];
                      NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=zh_CN", message[@"access_token"], message[@"openid"]];
                      NSDictionary *userDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]] options:NSJSONReadingAllowFragments error:nil];
                      self.accountInfo = [[QMQAccountInfo alloc] initWithDic:[userDict copy]];
                      self.success(self.accountInfo);
                      
                  }
                     Fail:^(NSDictionary *message, NSError *error) {
                         QMQLog(@"微信登录失败\n%@\n%@", error, message);
                     }];
    self.success = success;
    self.failure = failure;
}

- (void)loginWithWeiBoSuccess:(LoginSuccess)success failure:(LoginFailure)failure {
    [OpenShare WeiboAuth:@"all"
             redirectURI:@"https://github.com/CharlesQiu/QMQZhiHuDaily"
                 Success:^(NSDictionary *message) {
                     
                 }
                    Fail:^(NSDictionary *message, NSError *error) {
                        
                    }];
}

@end
