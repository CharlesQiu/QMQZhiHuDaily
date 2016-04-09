//
//  UIImageView+WebImageFadeInEffect.m
//
//  Created by Charles on 2/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "UIImageView+WebImageFadeInEffect.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (WebImageFadeInEffect)

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage fadeInWithDuration:(NSTimeInterval)duration {
    
    self.userInteractionEnabled    = NO;
    self.contentMode               = UIViewContentModeScaleAspectFit;
    __weak __typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (image) {
            strongSelf.userInteractionEnabled = YES;
            strongSelf.contentMode = UIViewContentModeScaleAspectFill;
            if (cacheType == SDImageCacheTypeDisk || cacheType == SDImageCacheTypeMemory) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [strongSelf setImage:image];
                });
            } else {
                strongSelf.alpha = 0.2f;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView transitionWithView:strongSelf duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        strongSelf.alpha = 1.0f;
                        [strongSelf setImage:image];
                    } completion:nil];
                });
            }
        }
    }];
}

@end
