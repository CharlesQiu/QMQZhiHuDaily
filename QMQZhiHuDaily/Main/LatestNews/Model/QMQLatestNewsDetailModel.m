//
//  QMQLatestNewsDetailModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/26/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsDetailModel.h"

@interface QMQLatestNewsDetailModel ()

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *imageSource;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *css;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *bodyNew;

@end

@implementation QMQLatestNewsDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title       = dic[@"title"];
    self.imageUrl    = dic[@"image"];
    self.imageSource = dic[@"image_source"];
    self.css         = dic[@"css"][0];
    self.shareUrl    = dic[@"share_url"];

    
    if ([dic[@"body"] rangeOfString:@"img-place-holder"].length != 0) {
        
        self.body = [dic[@"body"] stringByReplacingOccurrencesOfString:@"class=\"img-place-holder\"" withString:@""];
    } else {
        self.body = dic[@"body"];
    }
    self.bodyNew = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=%@ /></head><body>%@</body></html>", self.css, self.body];
    
    return self;
}

@end
