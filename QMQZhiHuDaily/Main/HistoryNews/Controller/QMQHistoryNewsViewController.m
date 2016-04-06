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
#import "QMQCommonDetailNewsViewController.h"
#import "QMQHistoryNewsModel.h"

@interface QMQHistoryNewsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView             *tableView;
@property (nonatomic, strong) QMQHistoryNewsViewModel *viewModel;
@property (nonatomic, strong) UIDatePicker            *datePicker;
@property (nonatomic, strong) UIView                  *buttonContainerView;

@end

@implementation QMQHistoryNewsViewController

#pragma mark - UIViewController Life Cycle

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker                 = [UIDatePicker new];
        _datePicker.datePickerMode  = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
        
        // 知乎日报开始于 20013年5月20日
        NSCalendar       *cal            = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [NSDateComponents new];
        dateComponents.year  = 2013;
        dateComponents.month = 5;
        dateComponents.day   = 20;
        NSDate *oldestDate = [cal dateFromComponents:dateComponents];
        _datePicker.minimumDate = oldestDate;
        _datePicker.maximumDate = [NSDate date];
        
        [self.view addSubview:_datePicker];
        @weakify(self);
        [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.leading.trailing.equalTo(self.view);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        }];
        
        _buttonContainerView                 = [UIView new];
        _buttonContainerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_buttonContainerView];
        [_buttonContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(_datePicker);
            make.bottom.equalTo(_datePicker.mas_top);
            make.height.mas_equalTo(35.0);
        }];
        
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [[confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _datePicker.hidden = YES;
            _buttonContainerView.hidden = YES;
            
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyyMMdd"];
            [_viewModel.loadCommand execute:[formatter stringFromDate:_datePicker.date]];
        }];
        [_buttonContainerView addSubview:confirmButton];
        [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_buttonContainerView).offset(15.0);
            make.centerY.equalTo(_buttonContainerView);
            make.height.mas_equalTo(18.0);
        }];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:confirmButton.titleLabel.font];
        [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            _datePicker.hidden = YES;
            _buttonContainerView.hidden = YES;
        }];
        [_buttonContainerView addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(_buttonContainerView).offset(-15.0);
            make.centerY.equalTo(confirmButton);
            make.height.equalTo(confirmButton.mas_height);
        }];
    } else {
        _datePicker.hidden          = NO;
        _buttonContainerView.hidden = NO;
    }
    
    return _datePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"历史新闻";
    
    UIImage *normalImage = [UIImageUtil imageWithIconFontCode:kIFNavEditDate
                                                        color:[UIColor whiteColor]
                                                     fontSize:kIFNavEditDateSize];
    UIImage *disableImage = [UIImageUtil imageWithIconFontCode:kIFNavEditDate
                                                         color:[UIColor grayColor]
                                                      fontSize:kIFNavEditDateSize];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:normalImage
            forState:UIControlStateNormal];
    [button setImage:disableImage
            forState:UIControlStateDisabled];
    [button sizeToFit];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(UIButton *button) {
         @strongify(self);
         [self datePicker];
     }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self initViewModel];
    [self bindViewModel];
    [self loadData];
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    [_viewModel.loadCommand execute:[formatter stringFromDate:[NSDate date]]];
}

#pragma mark - UITableView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView            = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.rowHeight  = 100.0f;
        [_tableView registerClass:[QMQHistoryNewsTableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([QMQHistoryNewsTableViewCell class])];
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
    QMQHistoryNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QMQHistoryNewsTableViewCell class])
                                                                        forIndexPath:indexPath];
    
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
    
    QMQHistoryNewsModel *model = self.viewModel.modelArray[indexPath.row];
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
