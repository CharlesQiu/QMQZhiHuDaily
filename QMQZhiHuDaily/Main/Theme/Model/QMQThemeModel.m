//
//  QMQThemeModel.m
//  QMQZhiHuDaily
//
//  Created by Charles on 2/28/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQThemeModel.h"

@interface QMQThemeModel ()

@property(nonatomic, assign) NSUInteger themeId;
@property(nonatomic, copy) NSString     *name;
@property(nonatomic, copy) NSString     *thumbnail;
@property(nonatomic, copy) NSString     *themeDescription;
@property(nonatomic, copy) NSString     *color;

@end
@implementation QMQThemeModel

- (QMQThemeModel *)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.themeId          = [dic[@"id"] unsignedIntegerValue];
    self.name             = dic[@"name"];
    self.thumbnail        = dic[@"thumbnail"];
    self.themeDescription = dic[@"description"];
    self.color            = dic[@"color"];
    
    return self;
}

@end
