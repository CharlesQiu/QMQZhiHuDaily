//
//  QMQLatestNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQLatestNewsViewController.h"
#import "QMQLatestNewsViewModel.h"

@interface QMQLatestNewsViewController ()

@property(nonatomic, strong) UITableView *tabelView;

@property(nonatomic, strong) QMQLatestNewsViewModel *viewModel;

@end

@implementation QMQLatestNewsViewController

- (QMQLatestNewsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QMQLatestNewsViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = @"最新文章";
    
    self.tabelView            = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tabelView.rowHeight  = 100.0f;
    self.tabelView.dataSource = self.viewModel;
    self.tabelView.delegate   = self.viewModel;
    
    [self.view addSubview:self.tabelView];
    
    // 执行请求
    RACSignal *requestSignal = [self.viewModel.requestCommand execute:nil];
    
    // 获取请求数据
    @weakify(self);
    [requestSignal subscribeNext:^(NSArray *x) {
        @strongify(self);
        self.viewModel.modelArray = x;
        [self.tabelView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
