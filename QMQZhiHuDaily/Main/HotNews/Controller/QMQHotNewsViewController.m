//
//  QMQHotNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHotNewsViewController.h"
#import "QMQHotNewsListViewModel.h"
#import "QMQHotNewsTableViewCell.h"
#import "QMQCommonDetailNewsViewController.h"
#import "QMQHotNewsModel.h"

@interface QMQHotNewsViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView             *tableView;
@property(nonatomic, strong) QMQHotNewsListViewModel *viewModel;

@end

@implementation QMQHotNewsViewController

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"热门新闻";
    
    [self initViewModel];
    [self bindViewModel];
    [self loadData];
}

- (void)initViewModel {
    _viewModel = [[QMQHotNewsListViewModel alloc] init];
    
    @weakify(self);
    [_viewModel.loadCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)bindViewModel {
    
    @weakify(self);
    [RACObserve(self.viewModel, modelArray) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
}

- (void)loadData {
    [_viewModel.loadCommand execute:nil];
}

#pragma mark - UITableView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView            = [UITableView new];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.rowHeight  = 100.0f;
        [_tableView registerClass:[QMQHotNewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([QMQHotNewsTableViewCell class])];
        [self.view addSubview:_tableView];
        @weakify(self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMQHotNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QMQHotNewsTableViewCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(QMQHotNewsTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    QMQHotNewsModel *model = _viewModel.modelArray[indexPath.row];
    [cell configureCell:model];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Tells the delegate that the specified row is now selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QMQHotNewsModel *model = self.viewModel.modelArray[indexPath.row];
    
    QMQCommonDetailNewsViewController *vc = [[QMQCommonDetailNewsViewController alloc] init];
    vc.newsDetailSignal = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        [subscriber sendNext:@(model.newsId)];
        [subscriber sendCompleted];
        return nil;
    }];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
