//
//  QMQHotNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsViewController.h"
#import "QMQUIImageUtils.h"

@interface QMQHotNewsViewController ()

@end

@implementation QMQHotNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"热门新闻";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont fontWithName:@"icomoon" size:100];
    label.text = @"\U0000e9a9";
    label.textColor = [UIColor orangeColor];
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:iconWithInfo(@"\U0000e9a9", [UIColor redColor], 20) forState:UIControlStateNormal];
//    [button.titleLabel setFont:[UIFont fontWithName:@"icomoon" size:100]];
//    [button setTitle:@"\U0000e9a9" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    [button sizeToFit];
//    button.center = CGPointMake(100, 150);
//    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 50, 50)];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.image = iconWithInfo(@"\U0000e9a9", [UIColor redColor], 20);
    [self.view addSubview:imageView];
}

- (void)tapButton:sender {
    
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
