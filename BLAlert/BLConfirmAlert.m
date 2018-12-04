//
//  BLConfirmAlert.m
//  BLAlertDemo
//
//  Created by lee on 2018/12/4.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "BLConfirmAlert.h"

@interface BLConfirmAlert ()
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * titleLineLabel;
@property (nonatomic, strong) UILabel * infoLabel;
@property (nonatomic, strong) UILabel * infoLineLabel;
@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) UIButton * submitButton;
@property (nonatomic, strong) UILabel * buttonLineLabel;
@end

@implementation BLConfirmAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.containView addSubview:self.titleLabel];
    [self.containView addSubview:self.titleLineLabel];
    [self.containView addSubview:self.infoLabel];
    [self.containView addSubview:self.infoLineLabel];
    [self.containView addSubview:self.submitButton];
    [self.containView addSubview:self.cancelButton];
    [self.containView addSubview:self.buttonLineLabel];
    self.titleLabel.text = @"信息确认";
    self.infoLabel.text = @"需要确认信息才可以进行操作";
    [self.submitButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.containView);
        make.height.mas_equalTo(50);
    }];
    [self.titleLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containView);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(1);
    }];

    [self.buttonLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.containView.mas_bottom);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(self.containView);
        make.width.mas_equalTo(1);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.containView);
        make.right.equalTo(self.buttonLineLabel.mas_left);
        make.height.mas_equalTo(44);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.containView);
        make.left.equalTo(self.buttonLineLabel.mas_right);
        make.height.equalTo(self.cancelButton);
    }];

    [self.infoLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containView);
        make.bottom.equalTo(self.submitButton.mas_top);
        make.height.mas_equalTo(1);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containView).offset(FitWidth(15));
        make.right.equalTo(self.containView).offset(-FitWidth(15));
        make.top.equalTo(self.titleLineLabel.mas_bottom);
        make.bottom.equalTo(self.infoLineLabel.mas_top);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- response

- (void)submitAction {

}
- (void)cancelAction{
    [self dismiss];
}

#pragma mark -- setter&getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = UIColorFromRGB(0xC8D3DE);
        _titleLabel.font = [UIFont boldSystemFontOfSize:19];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)titleLineLabel {
    if (!_titleLineLabel) {
        _titleLineLabel = [[UILabel alloc] init];
        _titleLineLabel.backgroundColor = UIColorFromRGB(0x1F252D);
    }
    return _titleLineLabel;
}
- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.numberOfLines = 0;
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.font = [UIFont systemFontOfSize:14];
        _infoLabel.textColor = UIColorFromRGB(0xC8D3DE);
    }
    return _infoLabel;
}
- (UILabel *)infoLineLabel {
    if (!_infoLineLabel) {
        _infoLineLabel = [[UILabel alloc] init];
        _infoLineLabel.backgroundColor = UIColorFromRGB(0x1F252D);
    }
    return _infoLineLabel;
}
- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UILabel *)buttonLineLabel {
    if (!_buttonLineLabel) {
        _buttonLineLabel = [[UILabel alloc] init];
        _buttonLineLabel.backgroundColor = UIColorFromRGB(0x1F252D);
    }
    return _buttonLineLabel;
}
@end
