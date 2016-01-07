//
//  ZMTrimImageViewController.m
//  ZMZX
//
//  Created by Charles on 1/7/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "ZMTrimImageViewController.h"
#import "Masonry.h"

@interface ZMTrimImageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UIView       *overLayView;

@end

@implementation ZMTrimImageViewController

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图片编辑";
    [self scrollView];
}

#pragma mark - Lazy Load
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 1.5;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.scrollView);
            make.size.mas_equalTo(self.originImage.size);
        }];
    }
    return _imageView;
}

- (UIView *)overLayView {
    if (!_overLayView) {
        _overLayView = [[UIView alloc] init];
        _overLayView.layer.borderColor = [UIColor orangeColor].CGColor;
        _overLayView.layer.borderWidth = 2.0f;
        [self.view addSubview:_overLayView];
        [_overLayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(SCREEN_WIDTH * 9 / 16);
        }];
        
    }
    return _overLayView;
}

#pragma mark - Original Image
- (void)setOriginImage:(UIImage *)originImage {
    _originImage = originImage;
    self.imageView.image = originImage;
    [self overLayView];
}

#pragma mark - UIScrollView Delegate 
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
