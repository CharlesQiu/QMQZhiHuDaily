//
//  QMQOldNewsViewController.m
//  QMQZhiHuDaily
//
//  Created by Charles on 12/27/15.
//  Copyright © 2015 Charles.Qiu. All rights reserved.
//

#import "QMQHistoryNewsViewController.h"
#import "QMQHistoryNewsTableViewCell.h"
#import "QMQHistoryNewsViewModel.h"

@interface QMQHistoryNewsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) QMQHistoryNewsViewModel *viewModel;

@end

@implementation QMQHistoryNewsViewController

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor                            = [UIColor whiteColor];
    self.title                                           = @"历史新闻";
    self.navigationController.navigationBar.barTintColor = hexString(kIFTabbarHistoryColor);
    
    UIImage *normalImage  = icomoonImage(kIFNavEditDate, [UIColor whiteColor], kIFNavEditDateSize);
    UIImage *disableImage = icomoonImage(kIFNavEditDate, [UIColor grayColor], kIFNavEditDateSize);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:createNormalImageButton(normalImage, disableImage, self, @selector(tapSelect))];
    
    [self initViewModel];
    [self bindViewModel];
    [self loadData];
}

- (void)tapSelect {
    
}

- (void)initViewModel {
    _viewModel = [[QMQHistoryNewsViewModel alloc] init];
    
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 100.0f;
        [_tableView registerClass:[QMQHistoryNewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([QMQHistoryNewsTableViewCell class])];
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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QMQHistoryNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QMQHistoryNewsTableViewCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(QMQHistoryNewsTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    QMQHistoryNewsModel *model = _viewModel.modelArray[indexPath.row];
    [cell configureCell:model];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Tells the delegate that the specified row is now selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
