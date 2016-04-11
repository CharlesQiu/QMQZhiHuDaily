//
//  QMQThemeListViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/10/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import "QMQThemeListViewController.h"
#import "QMQThemeListViewModel.h"
#import "QMQThemeModel.h"
#import "QMQCommonTableViewCell.h"
#import "QMQCommonListModel.h"
#import "QMQCommonCellModel.h"
#import "QMQCommonDetailNewsViewController.h"


@interface QMQThemeListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView           *tableView;
@property(nonatomic, strong) QMQThemeListViewModel *viewModel;

@end

@implementation QMQThemeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    @weakify(self);
    [self.getColumnDetailSignal subscribeNext:^(QMQThemeModel *model) {
        @strongify(self);
        self.title = model.name;
        [self initViewModel];
        [self bindViewModel];
        [self loadData:model.themeId];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)initViewModel {
    _viewModel = [[QMQThemeListViewModel alloc] init];
    
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

- (void)loadData:(NSUInteger)columnId {
    [_viewModel.loadCommand execute:@(columnId)];
}

#pragma mark - UITableView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView            = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.rowHeight  = 100.0f;
        [_tableView registerClass:[QMQCommonTableViewCell class] forCellReuseIdentifier:NSStringFromClass([QMQCommonTableViewCell class])];
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
    QMQCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QMQCommonTableViewCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(QMQCommonTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    QMQCommonListModel *model = _viewModel.modelArray[indexPath.row];
    [cell configureCell:model];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Tells the delegate that the specified row is now selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QMQCommonCellModel *model = self.viewModel.modelArray[indexPath.row];
    
    QMQCommonDetailNewsViewController *vc = [[QMQCommonDetailNewsViewController alloc] init];
    vc.newsDetailSignal = [RACSignal createSignal:^RACDisposable *(id < RACSubscriber > subscriber) {
        [subscriber sendNext:@(model.newsId)];
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
