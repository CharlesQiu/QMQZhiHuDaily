//
//  UIImageView+WebImageFadeInEffect.h
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImageFadeInEffect)

/**
 *  网络图片渐变展现
 *  @param url              图片地址
 *  @param placeholderImage 占位图
 *  @param duration         渐变时间
 */
- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage fadeInWithDuration:(NSTimeInterval)duration;

@end
