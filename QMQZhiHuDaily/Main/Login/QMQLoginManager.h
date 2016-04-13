//
//  QMQLoginManager.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/12/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QMQAccountInfo;

extern NSString *const QMQisLogin;

typedef void(^LoginSuccess)(QMQAccountInfo *accountInfo);
typedef void(^LoginFailure)(NSString *failureMsg);

@interface QMQLoginManager : NSObject

@property (nonatomic, readonly, strong) QMQAccountInfo *accountInfo;

+ (instancetype)shareInstance;

- (void)loginWithTencentQQSuccess:(LoginSuccess)success failure:(LoginFailure)failure;
- (void)loginWithWeiXinSuccess:(LoginSuccess)success failure:(LoginFailure)failure;
- (void)loginWithWeiBoSuccess:(LoginSuccess)success failure:(LoginFailure)failure;

@end
