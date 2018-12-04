//
//  BLAlert.m
//  BLAlertDemo
//
//  Created by lee on 2018/11/30.
//  Copyright © 2018 Lee. All rights reserved.
//
#import "BLAlert.h"

@interface BLAlert ()
@property (nonatomic, strong) UIWindow * prevWindow;
@property (nonatomic, strong) UIWindow * blWindow;
@end

@implementation BLAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:self.containView];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset( FitWidth(15) );
        make.right.equalTo(self.view).offset(-FitWidth(15));
        make.centerY.equalTo(self.view).offset(-kBLScreenHeight);
        make.height.mas_equalTo(kBLScreenHeight * 1 / 3.0);
    }];
}

#pragma mark - response
- (void)show {
    self.prevWindow = [UIApplication sharedApplication].keyWindow;
    [self.blWindow setRootViewController:self];
    [self.blWindow makeKeyAndVisible];
    [UIView animateWithDuration:1 animations:^{
        [self.containView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view);
        }];
        [self.containView layoutIfNeeded];
    }];
}
- (void)dismiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [self.prevWindow makeKeyAndVisible];
    self.prevWindow = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - setter&getter
- (UIWindow *)blWindow {
    if (!_blWindow) {
        _blWindow = [[UIWindow alloc] init];
        _blWindow.backgroundColor = UIColor.clearColor;
    }
    return _blWindow;
}
- (UIView *)containView {
    if (!_containView) {
        _containView = [[UIView alloc] init];
        _containView.clipsToBounds = YES;
        _containView.layer.cornerRadius = 5;
        _containView.backgroundColor = UIColorFromRGB(0x3A4048);
    }
    return _containView;
}
@end
