//
//  ZMTrimImageViewController.h
//  ZMZX
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMTrimImageViewController : UIViewController

@property(nonatomic, strong) UIImage *originImage;

@property (nonatomic, copy) void (^didTapSaveButton)(UIImage *image);

@end
