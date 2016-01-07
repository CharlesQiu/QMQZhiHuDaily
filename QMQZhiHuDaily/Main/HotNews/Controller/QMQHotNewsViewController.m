//
//  QMQHotNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsViewController.h"
#import "QMQUIImageUtils.h"
#import "UIImageView+AFNetworking.h"
#import "QMQHotNewsListModel.h"
#import "Masonry.h"
#import "ZMTrimImageViewController.h"

#define START_X 0
#define START_Y 100
#define HEIGHT  100

@interface QMQHotNewsViewController ()<UIScrollViewDelegate>

@end

@implementation QMQHotNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"热门新闻";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"裁剪图片" forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    button.centerX = self.view.centerX;
    button.top = STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:button];
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.scrollView.backgroundColor = [UIColor grayColor];
//    self.scrollView.scrollEnabled = YES;
//    self.scrollView.userInteractionEnabled = YES;
//    self.scrollView.delegate = self;
//    [self.scrollView setMinimumZoomScale:0.25f];
//    [self.scrollView setMaximumZoomScale:3.0f];
//    [self.scrollView setZoomScale:0.5f animated:NO];
//    [self.view addSubview:self.scrollView];
//    
//    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                       action:@selector(handleDoubleTap:)];
//    [doubleTapGesture setNumberOfTapsRequired:2];
//    [self.scrollView addGestureRecognizer:doubleTapGesture];
//    
//    self.imageView = [[UIImageView alloc] init];
//    [self.scrollView addSubview:self.imageView];
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.scrollView);
//    }];
//
//    // 1
//    NSString *filePath =
//    [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
//    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
//
//    CIImage *beginImage =
//    [CIImage imageWithContentsOfURL:fileNameAndPath];
//    
//    // 1
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
//                                  keysAndValues: kCIInputImageKey, beginImage,
//                        @"inputIntensity", @0.8, nil];
//    CIImage *outputImage = [filter outputImage];
//    
//    // 2
//    CGRect oldRect = [outputImage extent];
//    CGRect newRect = CGRectMake(oldRect.origin.x, oldRect.origin.y, oldRect.size.width, oldRect.size.height / 2);
//    CGImageRef cgimg =
//    [context createCGImage:outputImage fromRect:oldRect];
//    
//    // 3
//    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
//    self.imageView.image = newImage;
//    
//    // 4
//    CGImageRelease(cgimg);
//    
//    self.imageView.frameSize = CGSizeMake(SCREEN_WIDTH * 1.5, SCREEN_HEIGHT * 1.5);
//
//
//    [self loadDatas];
}

#pragma mark - Zoom methods
//
//- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
//{
//    NSLog(@"handleDoubleTap");
//    float newScale = self.scrollView.zoomScale * 1.5;//zoomScale这个值决定了contents当前扩展的比例
//    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
//    [self.scrollView zoomToRect:zoomRect animated:YES];
//}
//
//- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
//{
//    CGRect zoomRect;
//    zoomRect.size.height = self.scrollView.frame.size.height / scale;
//    NSLog(@"zoomRect.size.height is %f",zoomRect.size.height);
//    NSLog(@"self.frame.size.height is %f",self.scrollView.frame.size.height);
//    zoomRect.size.width  = self.scrollView.frame.size.width  / scale;
//    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
//    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
//    return zoomRect;
//}


//#pragma mark - UIScrollViewDelegate
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return _imageView;
//}
////当滑动结束时
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
//{
//    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
//    NSLog(@"scale is %f",scale);
//    [self.scrollView setZoomScale:scale animated:NO];
//}

//传入原始图片对象
-(UIImage *)getImageFromImage:(UIImage*) superImage
{
    CGSize subImageSize = CGSizeMake(SCREEN_WIDTH, HEIGHT);
    //定义裁剪的区域相对于原图片的位置
    CGRect subImageRect = CGRectMake(START_X, START_Y, SCREEN_WIDTH, HEIGHT);
    CGImageRef imageRef = superImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIGraphicsBeginImageContext(subImageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    //返回裁剪的部分图像
    return subImage;
    
}


- (void)loadDatas {
    [QMQHttpService getWithUrl:API_HOT_NEWS param:nil responseBlock:^(QMQHttpBaseResponse *response) {
        if (!response.success) {
            return;
        }
        QMQHotNewsListModel *listModel = [[QMQHotNewsListModel alloc] initWithDic:response.originalDict];
        
        [listModel.recentArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            QMQHotNewsModel *newsModel = obj;
            DDLogError(@"%li", newsModel.newsId);
        }];
    }];
}

- (void)tapButton:sender {
    ZMTrimImageViewController *vc = [[ZMTrimImageViewController alloc] init];
    vc.originImage = [UIImage imageNamed:@"image"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc setDidTapSaveButton:^(UIImage *image){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.center = self.view.center;
        [self.view addSubview:imageView];
    }];
}

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
