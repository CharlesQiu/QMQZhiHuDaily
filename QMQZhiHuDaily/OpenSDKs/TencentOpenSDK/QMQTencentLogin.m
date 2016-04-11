//
//  QMQTencentLogin.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/11/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQTencentLogin.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

typedef void (^TencentLoginSuccess)(NSDictionary *userInfo);
typedef void (^TencentLoginFailure)(NSString *message);

@interface QMQTencentLogin ()<TencentSessionDelegate, TencentLoginDelegate>

@property (nonatomic, strong) TencentOAuth *tencentOAuth;
@property (nonatomic, copy) NSArray        *permissions;

@property (nonatomic, assign) TencentLoginSuccess success;
@property (nonatomic, assign) TencentLoginFailure failure;
@end

static NSString *const tencentAppId  = @"1105322490";
static NSString *const tencentAppKey = @"KEYYmbteyk3w3SQBDtz";

@implementation QMQTencentLogin


static QMQTencentLogin *_instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [QMQTencentLogin shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [QMQTencentLogin shareInstance];
}

- (void)loginWithTencentQQ {
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:tencentAppId andDelegate:self];
    self.permissions  = @[@"get_user_info", @"get_simple_userinfo", @"add_t"];
    [self sendTencentAuthRequest:^(NSDictionary *userInfo) {
        LOGDEBUG(userInfo);
    } failure:^(NSString *message) {
        LOGERROR(message);
    }];
}

- (void)sendTencentAuthRequest:(TencentLoginSuccess)success failure:(TencentLoginFailure)failure {
    [self.tencentOAuth authorize:self.permissions inSafari:NO];
    self.success = success;
    self.failure = failure;
}

- (void)tencentDidLogin {
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

- (void)tencentDidNotNetWork {
    
}

- (void)getUserInfoResponse:(APIResponse *)response {
    NSLog(@"----%@", response.jsonResponse);
    if (self.success) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:response.jsonResponse];
        [dic setObject:[self.tencentOAuth openId] forKey:@"openid"];
        [dic setObject:self.tencentOAuth.accessToken forKey:@"accessToken"];
        self.success(dic);
    }
}

@end
