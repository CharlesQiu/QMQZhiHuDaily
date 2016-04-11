//
//  QMQTencentLogin.h
//  QMQZhiHuDaily
//
//  Created by Charles on 4/11/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMQTencentLogin : NSObject

+ (instancetype)shareInstance;

- (void)loginWithTencentQQ;

@end
