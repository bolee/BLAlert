//
//  BLConfirmAlert.m
//  BLAlertDemo
//
//  Created by lee on 2018/12/4.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "BLConfirmAlert.h"

CGFloat const kTitleHeight = 50;
CGFloat const kSubmitHeight = 44;
CGFloat const kTitleSubmitHeight = kTitleHeight + kSubmitHeight;
CGFloat const kLineHeight = 1;

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
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initParams];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initParams];
    }
    return self;
}
- (void)initParams {
    [super initParams];
    self.titleHeight = kTitleHeight;
    self.submitHeight = kSubmitHeight;
    self.lineHeight = kLineHeight;
}
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
            make.height.mas_equalTo(self.titleHeight);
        }];
        [self.titleLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containView);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.mas_equalTo(self.lineHeight);
        }];
    }

    if (!self.hiddenCancel) {
        [self.buttonLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.containView.mas_bottom);
            make.height.mas_equalTo(self.submitHeight);
            make.centerX.equalTo(self.containView);
            make.width.mas_equalTo(self.lineHeight);
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.containView);
            make.right.equalTo(self.buttonLineLabel.mas_left);
            make.height.mas_equalTo(self.submitHeight);
        }];
    }
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.containView);
        make.left.equalTo(self.hiddenCancel ? self.containView.mas_left : self.buttonLineLabel.mas_right);
        make.height.equalTo(self.hiddenCancel ? @(self.submitHeight) : self.cancelButton);
    }];

    [self.infoLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containView);
        make.bottom.equalTo(self.submitButton.mas_top);
        make.height.mas_equalTo(self.lineHeight);
    }];
    if (self.customView) {
        if (self.customView.constraintBlock) {
            [self.customView mas_remakeConstraints:self.customView.constraintBlock];
        } else {
            [self.customView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.containView).offset(BL_ADAPTATION(self.containPaddingLeft));
                make.right.equalTo(self.containView).offset(-BL_ADAPTATION(self.containPaddingRight));
                make.top.equalTo(self.hiddenTitle ? self.containView.mas_top : self.titleLineLabel.mas_bottom).offset(BL_ADAPTATION(self.containPaddingTop));
                make.bottom.equalTo(self.infoLineLabel.mas_top).offset(-BL_ADAPTATION(self.containPaddingBottom));
            }];
        }
    } else {
        CGFloat height = ( self.hiddenTitle ? 0 : self.titleHeight ) + self.submitHeight;
        if (self.infoLabel.text.length <= 0 && self.infoLabel.attributedText.length <= 0) {
            //没有内容
            self.titleLineLabel.alpha = 0;
            [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.containView).offset(BL_ADAPTATION(self.leftMargin));
                make.right.equalTo(self.containView).offset(-BL_ADAPTATION(self.rightMargin));
                make.top.equalTo(self.hiddenTitle ? self.containView.mas_top : self.titleLineLabel.mas_bottom);
                make.bottom.equalTo(self.infoLineLabel.mas_top);
            }];
        } else {
            // must add separate
            CGFloat margin = BL_ADAPTATION(self.leftMargin) + BL_ADAPTATION(self.rightMargin) + BL_ADAPTATION(self.containPaddingLeft) + BL_ADAPTATION(self.containPaddingRight);
            CGRect rect = [self.infoLabel.text boundingRectWithSize:CGSizeMake(kBLScreenWidth - margin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.infoLabel.font} context:nil];
            height += BL_ADAPTATION(self.containPaddingTop) + BL_ADAPTATION(self.containPaddingBottom) + ceilf(rect.size.height) + 2 * self.lineHeight;
            [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.containView).offset(BL_ADAPTATION(self.containPaddingLeft));
                make.right.equalTo(self.containView).offset(-BL_ADAPTATION(self.containPaddingRight));
                make.top.equalTo(self.hiddenTitle ? self.containView.mas_top : self.titleLineLabel.mas_bottom).offset(BL_ADAPTATION(self.containPaddingTop));
                make.bottom.equalTo(self.infoLineLabel.mas_top).offset(-BL_ADAPTATION(self.containPaddingBottom));
            }];
        }
        [self.containView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(BL_ADAPTATION(self.leftMargin) );
            make.right.equalTo(self.view).offset(-BL_ADAPTATION(self.rightMargin));
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
    if (self.buttonResponse) {
        if (self.buttonResponse(self.submitButton, ButtonTypeSubmit)) {
            [self dismiss];
        } else {

        }
    } else {
        [self dismiss];
    }
}
- (void)cancelAction{
//    [self dismiss];
    if (self.buttonResponse) {
        if (self.buttonResponse(self.cancelButton, ButtonTypeCancel)) {
            [self dismiss];
        } else {

        }
    } else {
        [self dismiss];
    }
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
        [self.titleLabel setValue:titleProperties[key] forKeyOrPath:key];
    }
}
- (void)setTitleLineProperties:(NSDictionary *)titleLineProperties {
    for (NSString * key in titleLineProperties) {
        [self.titleLineLabel setValue:titleLineProperties[key] forKeyOrPath:key];
    }
}
- (void)setInfoProperties:(NSDictionary *)infoProperties {
    for (NSString * key in infoProperties) {
        [self.infoLabel setValue:infoProperties[key] forKeyOrPath:key];
    }
}
- (void)setInfoLineProperties:(NSDictionary *)infoLineProperties {
    for (NSString * key in infoLineProperties) {
        [self.infoLineLabel setValue:infoLineProperties[key] forKeyOrPath:key];
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
            [self.cancelButton setValue:cancelButtonProperties[key] forKeyOrPath:key];
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
            [self.submitButton setValue:submitButtonProperties[key] forKeyOrPath:key];
        }
    }
}
- (void)setButtonLineProperties:(NSDictionary *)buttonLineProperties {
    for (NSString * key in buttonLineProperties) {
        [self.buttonLineLabel setValue:buttonLineProperties[key] forKeyOrPath:key];
    }
}
@end
