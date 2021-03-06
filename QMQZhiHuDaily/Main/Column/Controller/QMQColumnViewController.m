//
//  QMQColumnViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQColumnViewController.h"
#import "QMQColumnViewModel.h"
#import "QMQColumnTableViewCell.h"
#import "QMQColumnModel.h"
#import "QMQColumnListViewController.h"

@interface QMQColumnViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView        *tableView;
@property(nonatomic, strong) QMQColumnViewModel *viewModel;

@end

@implementation QMQColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"专栏文章";
    
    [self initViewModel];
    [self bindViewModel];
    [self loadData];
}

- (void)initViewModel {
    _viewModel = [[QMQColumnViewModel alloc] init];
    
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
        _tableView            = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.rowHeight  = 100.0f;
        [_tableView registerClass:[QMQColumnTableViewCell class] forCellReuseIdentifier:NSStringFromClass([QMQColumnTableViewCell class])];
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
    QMQColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QMQColumnTableViewCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(QMQColumnTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    QMQColumnModel *model = _viewModel.modelArray[indexPath.row];
    [cell configureCell:model];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Tells the delegate that the specified row is now selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QMQColumnModel *model = self.viewModel.modelArray[indexPath.row];
    
    QMQColumnListViewController *vc = [[QMQColumnListViewController alloc] init];
    vc.getColumnDetailSignal = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        [subscriber sendNext:model];
        [subscriber sendCompleted];
        return nil;
    }];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
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
