//
//  QMQCommonModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQCommonModel.h"

@interface QMQCommonModel ()

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *imageSource;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *css;

@end

@implementation QMQCommonModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title       = dic[@"title"];
    self.imageUrl    = dic[@"image"];
    self.imageSource = dic[@"image_source"];
    self.body        = dic[@"body"];
    self.css         = dic[@"css"][0] ? : nil;
    
    return self;
}

@end
