//
//  QJViewController.m
//  EHenTaiViewer
//
//  Created by QinJ on 2017/5/18.
//  Copyright © 2017年 kayanouriko. All rights reserved.
//

#import "QJViewController.h"
#import "QJTipViewController.h"

@interface QJViewController () {
    BOOL _isRefreshing;
}

@property (nonatomic, strong) QJTipViewController *tipVC;

@end

@implementation QJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 刷新相关参数
    _isRefreshing = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 子类默认不用大图标
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
}

- (BOOL)isShowFreshingStatus {
    return _isRefreshing;
}

- (void)showFreshingViewWithTip:(NSString *)tip {
    _isRefreshing = YES;
    [self.tipVC startAnimateWithTip:tip];
    [self addChildViewController:self.tipVC];
    self.tipVC.view.frame = self.view.frame;
    [self.view addSubview:self.tipVC.view];
    [self.tipVC didMoveToParentViewController:self];
}

- (void)hiddenFreshingView {
    if (_isRefreshing) {
        [UIView animateWithDuration:0.25f animations:^{
            self.tipVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            self->_isRefreshing = NO;
            [self.tipVC stopAnimateWithTip:nil];
            [self.tipVC willMoveToParentViewController:nil];
            [self.tipVC.view removeFromSuperview];
            [self.tipVC removeFromParentViewController];
            self.tipVC = nil;
        }];
    }
}

- (void)showErrorViewWithTip:(NSString *)tip {
    _isRefreshing = NO;
    [self.tipVC stopAnimateWithTip:tip];
}

#pragma mark -getter
- (QJTipViewController *)tipVC {
    if (nil == _tipVC) {
        _tipVC = [QJTipViewController new];
    }
    return _tipVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
}

@end
