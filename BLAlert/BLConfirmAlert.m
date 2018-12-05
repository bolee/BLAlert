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
    if (!self.hiddenTitle) {
        [self.containView addSubview:self.titleLabel];
        [self.containView addSubview:self.titleLineLabel];
    }
    [self.containView addSubview:self.infoLabel];
    [self.containView addSubview:self.infoLineLabel];
    [self.containView addSubview:self.submitButton];
    if (!self.hiddenCancel) {
        [self.containView addSubview:self.cancelButton];
        [self.containView addSubview:self.buttonLineLabel];
    }
}
- (void)layoutView {
    [super layoutView];
    if (!self.hiddenTitle) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.containView);
            make.height.mas_equalTo(50);
        }];
        [self.titleLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containView);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    }

    if (!self.hiddenCancel) {
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
    }
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.containView);
        make.left.equalTo(self.hiddenCancel ? self.containView.mas_left : self.buttonLineLabel.mas_right);
        make.height.equalTo(self.hiddenCancel ? @(44) : self.cancelButton);
    }];

    [self.infoLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containView);
        make.bottom.equalTo(self.submitButton.mas_top);
        make.height.mas_equalTo(1);
    }];
    if (self.customView) {
        [self.customView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containView).offset(FitWidth(15));
            make.right.equalTo(self.containView).offset(-FitWidth(15));
            make.top.equalTo(self.hiddenTitle ? self.containView.mas_top : self.titleLineLabel.mas_bottom).offset(FitHeight(20));
            make.bottom.equalTo(self.infoLineLabel.mas_top).offset(-FitHeight(20));
        }];
    } else {
        CGRect rect = [self.infoLabel.text boundingRectWithSize:CGSizeMake(kBLScreenWidth - 4 * FitWidth(15), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName: self.infoLabel.font} context:nil];
        CGFloat height = 50 + 44 + rect.size.height + FitHeight(20) * 2;
        if (self.infoLabel.text.length <= 0) {
            height = 50 + 44;
            [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.containView).offset(FitWidth(15));
                make.right.equalTo(self.containView).offset(-FitWidth(15));
                make.top.equalTo(self.hiddenTitle ? self.containView.mas_top : self.titleLineLabel.mas_bottom);
                make.bottom.equalTo(self.infoLineLabel.mas_top);
            }];
        } else {
            [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.containView).offset(FitWidth(15));
                make.right.equalTo(self.containView).offset(-FitWidth(15));
                make.top.equalTo(self.hiddenTitle ? self.containView.mas_top : self.titleLineLabel.mas_bottom).offset(FitHeight(20));
                make.bottom.equalTo(self.infoLineLabel.mas_top).offset(-FitHeight(20));
            }];
        }
        [self.containView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset( FitWidth(15) );
            make.right.equalTo(self.view).offset(-FitWidth(15));
            make.centerY.equalTo(self.view).offset(-kBLScreenHeight);
            make.height.mas_equalTo(height);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- response
- (void)setCustomView:(UIView *)customView {
    [super setCustomView:customView];
}
- (void)submitAction {
//    [self dismiss];
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
        _titleLabel.text = @"信息确认";
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
        _infoLabel.text = @"需要确认信息才可以进行操作";
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
        [_submitButton setTitle:@"确认" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
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
- (void)setTitleProperties:(NSDictionary *)titleProperties {
    for (NSString * key in titleProperties) {
        [self.titleLabel setValue:titleProperties[key] forKey:key];
    }
}
- (void)setTitleLineProperties:(NSDictionary *)titleLineProperties {
    for (NSString * key in titleLineProperties) {
        [self.titleLineLabel setValue:titleLineProperties[key] forKey:key];
    }
}
- (void)setInfoProperties:(NSDictionary *)infoProperties {
    for (NSString * key in infoProperties) {
        [self.infoLabel setValue:infoProperties[key] forKey:key];
    }
}
- (void)setInfoLineProperties:(NSDictionary *)infoLineProperties {
    for (NSString * key in infoLineProperties) {
        [self.infoLineLabel setValue:infoLineProperties[key] forKey:key];
    }
}
- (void)setCancelButtonProperties:(NSDictionary *)cancelButtonProperties {
    for (NSString * key in cancelButtonProperties) {
        if ([key isEqualToString:kTextProperty]) {
            [self.cancelButton setTitle:cancelButtonProperties[key] forState:UIControlStateNormal];
        } else if ([key isEqualToString:kTextColorProperty]) {
            [self.cancelButton setTitleColor:cancelButtonProperties[key] forState:UIControlStateNormal];
        } else if ([key isEqualToString:kTextFontProperty]) {
            self.cancelButton.titleLabel.font = cancelButtonProperties[key];
        } else {
            [self.cancelButton setValue:cancelButtonProperties[key] forKey:key];
        }
    }
}
- (void)setSubmitButtonProperties:(NSDictionary *)submitButtonProperties {
    for (NSString * key in submitButtonProperties) {
        if ([key isEqualToString:kTextProperty]) {
            [self.submitButton setTitle:submitButtonProperties[key] forState:UIControlStateNormal];
        } else if ([key isEqualToString:kTextColorProperty]) {
            [self.submitButton setTitleColor:submitButtonProperties[key] forState:UIControlStateNormal];
        } else if ([key isEqualToString:kTextFontProperty]) {
            self.submitButton.titleLabel.font = submitButtonProperties[key];
        } else {
            [self.submitButton setValue:submitButtonProperties[key] forKey:key];
        }
    }
}
- (void)setButtonLineProperties:(NSDictionary *)buttonLineProperties {
    for (NSString * key in buttonLineProperties) {
        [self.buttonLineLabel setValue:buttonLineProperties[key] forKey:key];
    }
}
@end
