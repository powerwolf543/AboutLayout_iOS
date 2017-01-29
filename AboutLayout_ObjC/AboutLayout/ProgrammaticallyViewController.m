//
//  ProgrammaticallyViewController.m
//  AboutLayout
//
//  Created by NixonShih on 2017/1/28.
//  Copyright © 2017年 Nixon. All rights reserved.
//

#import "ProgrammaticallyViewController.h"

@interface ProgrammaticallyViewController () <UITableViewDataSource>
@property (strong, nonatomic) UIView *headerBackgroundView;
@property (strong, nonatomic) UIImageView *musicLogoImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<NSDictionary*> *dataSource;
@property (strong, nonatomic) NSTimer *timer;
@end

static NSString *kTableViewCellIdentifier = @"Cell";

@implementation ProgrammaticallyViewController

#pragma mark - setter getter

- (UIView *)headerBackgroundView {
    
    if (!_headerBackgroundView) {
        _headerBackgroundView = [UIView new];
        [self.view addSubview:_headerBackgroundView];
    }
    
    return _headerBackgroundView;
}

- (UIImageView *)musicLogoImageView {
    
    if (!_musicLogoImageView) {
        _musicLogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MusicLogo"]];
        [self.headerBackgroundView addSubview:_musicLogoImageView];
    }
    
    return _musicLogoImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [self.headerBackgroundView addSubview:_titleLabel];
        _titleLabel.text = @"Music Life";
    }
    
    return _titleLabel;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [UITableView new];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
    }
    
    return _tableView;
}

#pragma mark - UIViewController Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self prepareUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self logoFlipFromRight];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.5f target:self selector:@selector(logoFlipFromRight) userInfo:nil repeats:true];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - UI

- (void)prepareUI {
    
    self.title = @"Show";
    
    // translatesAutoresizingMaskIntoConstraints 不讓系統自動加 Constraints
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    self.musicLogoImageView.translatesAutoresizingMaskIntoConstraints = false;
    self.headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false;
    
    NSDictionary *views = @{@"tableView":self.tableView,
                            @"titleLabel":self.titleLabel,
                            @"musicLogoImageView":self.musicLogoImageView,
                            @"headerBackgroundView":self.headerBackgroundView};
    
    // 詳細用法請查 Constraint Visual Format Language
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[headerBackgroundView(181)]-(0)-[tableView]-(0)-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[headerBackgroundView]-(0)-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[tableView]-(0)-|" options:0 metrics:nil views:views]];
    
    BOOL useAnchor = false;
    // 示範不同種Constraint的用法，NSLayoutAnchor是iOS9開放的API。
    if (useAnchor) {
        // iOS 9 NSLayoutAnchor
        [self.headerBackgroundView addConstraint:[self.musicLogoImageView.centerXAnchor constraintEqualToAnchor:self.musicLogoImageView.superview.centerXAnchor]];
        [self.headerBackgroundView addConstraint:[self.musicLogoImageView.centerYAnchor constraintEqualToAnchor:self.musicLogoImageView.superview.centerYAnchor constant:-15.f]];
        
        [self.headerBackgroundView addConstraint:[self.titleLabel.centerXAnchor constraintEqualToAnchor:self.titleLabel.superview.centerXAnchor]];
        [self.headerBackgroundView addConstraint:[self.titleLabel.topAnchor constraintEqualToAnchor:self.musicLogoImageView.bottomAnchor constant:10.f]];
    }else{
        [self.headerBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.musicLogoImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.musicLogoImageView.superview attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]];
        [self.headerBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.musicLogoImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.musicLogoImageView.superview attribute:NSLayoutAttributeCenterY multiplier:1.f constant:-15.f]];
        
        [self.headerBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.titleLabel.superview attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0]];
        [self.headerBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.musicLogoImageView attribute:NSLayoutAttributeBottom multiplier:1.f constant:10.f]];
    }
}

#pragma mark - Animate

- (void)logoFlipFromRight {
    [UIView transitionWithView:self.musicLogoImageView duration:1.f options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

#pragma mark - Data

- (void)prepareData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MusicData" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    NSError *error = nil;
    _dataSource = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return self.dataSource.count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier];
    
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTableViewCellIdentifier];
    }
    
    NSDictionary *infos = self.dataSource[indexPath.row];
    
    cell.textLabel.text = infos[@"title"];
    cell.detailTextLabel.text = infos[@"showUnit"];
    
    return cell;
}

@end
