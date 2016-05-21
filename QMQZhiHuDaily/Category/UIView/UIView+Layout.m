//
//  UIView+Layout.m
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (CGFloat)frameX {
    return CGRectGetMinX(self.frame);
}

- (void)setFrameX:(CGFloat)x {
    CGRect localFrame = self.frame;
    localFrame.origin.x = x;
    
    self.frame = localFrame;
}

- (CGFloat)frameY {
    return CGRectGetMinY(self.frame);
}

- (void)setFrameY:(CGFloat)y {
    CGRect localFrame = self.frame;
    localFrame.origin.y = y;
    
    self.frame = localFrame;
}

- (CGFloat)frameWidth {
    return CGRectGetWidth(self.frame);
}

- (void)setFrameWidth:(CGFloat)width {
    CGRect localFrame = self.frame;
    localFrame.size.width = width;
    
    self.frame = localFrame;
}

- (CGFloat)frameHeight {
    return CGRectGetHeight(self.frame);
}

- (void)setFrameHeight:(CGFloat)height {
    CGRect localFrame = self.frame;
    localFrame.size.height = height;
    
    self.frame = localFrame;
}

- (CGFloat)centerX {
    return CGRectGetMidX(self.frame);
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint localPoint = self.center;
    localPoint.x = centerX;
    
    self.center = localPoint;
}

- (CGFloat)centerY {
    return CGRectGetMidY(self.frame);
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint localPoint = self.center;
    localPoint.y = centerY;
    
    self.center = localPoint;
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)frameSize {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame),
                            frameSize.width, frameSize.height);
}

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)top {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), top,
                            CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (CGFloat)bottom {
    return CGRectGetMinY(self.frame) + CGRectGetHeight(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), bottom - CGRectGetHeight(self.frame),
                            CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)left {
    self.frame = CGRectMake(left, CGRectGetMinY(self.frame),
                            CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (CGFloat)right {
    return CGRectGetMinX(self.frame) + CGRectGetWidth(self.frame);
}

- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - CGRectGetWidth(self.frame), CGRectGetMinY(self.frame),
                            CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

@end
