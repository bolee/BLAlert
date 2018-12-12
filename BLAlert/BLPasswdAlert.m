//
//  BLPasswdAlert.m
//  BLAlertDemo
//
//  Created by lee on 2018/12/11.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "BLPasswdAlert.h"

@interface BLPasswdAlert ()
@property (nonatomic, strong) UIView * securView;
@property (nonatomic, strong) UILabel * securTitleLabel;
@property (nonatomic, strong) UITextField * securTextField;

@end

@implementation BLPasswdAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomView:self.securView];
    [self.securView addSubview:self.securTitleLabel];
    [self.securView addSubview:self.securTextField];
}

- (void)layoutView {
    [super layoutView];
    CGFloat height = kTitleSubmitHeight + 48;
    if (BLPasswdAlertTextAlignHorizontal == self.align) {
        CGRect rect = [self.securTitleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 44) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil];
        [self.securTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.securView);
            make.width.mas_equalTo(rect.size.width);
        }];
        [self.securTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.securTitleLabel.mas_right).offset(15);
            make.top.right.bottom.equalTo(self.securView);
        }];
        height += 40;
    } else {
        [self.securTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.securView);
        }];
        [self.securTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.securView);
            make.top.equalTo(self.securTitleLabel.mas_bottom).offset(15);
            make.height.mas_equalTo(40);
        }];
        height += 40 + 50;
    }
    [self.containView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(kLeftMargin);
        make.right.equalTo(self.view).offset(-kRightMargin);
        make.height.mas_equalTo(height);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- getter&setter
- (void)setSecurity:(BOOL)security {
    self.securTextField.secureTextEntry = YES;
}
- (BOOL)isSecurity {
    return self.securTextField.secureTextEntry;
}
- (NSString *)textString {
    return self.securTextField.text;
}
- (UIView *)securView {
    if (!_securView) {
        _securView = [[UIView alloc] init];
        _securView.backgroundColor = UIColor.clearColor;
    }
    return _securView;
}
- (UILabel *)securTitleLabel {
    if (!_securTitleLabel) {
        _securTitleLabel = [[UILabel alloc] init];
        _securTitleLabel.backgroundColor = UIColor.clearColor;
        _securTitleLabel.text = @"密码";
        _securTitleLabel.textColor = UIColorFromRGB(0xC8D3DE);
        _securTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _securTitleLabel;
}
- (UITextField *)securTextField {
    if (!_securTextField) {
        _securTextField = [[UITextField alloc] init];
        _securTextField.layer.borderColor = UIColorFromRGB(0x8F97A2).CGColor;
        _securTextField.layer.borderWidth = 1;
        _securTextField.layer.cornerRadius = 5;
        _securTextField.textColor = UIColorFromRGB(0xC8D3DE);
        _securTextField.font = [UIFont systemFontOfSize:15];
        _securTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: UIColorFromRGB(0x5B646D)}];
        _securTextField.leftViewMode = UITextFieldViewModeAlways;
        _securTextField.leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    }
    return _securTextField;
}

@end
