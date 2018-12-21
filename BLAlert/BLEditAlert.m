//
//  BLEditAlert.m
//  BLAlertDemo
//
//  Created by BoLee on 2018/12/21.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "BLEditAlert.h"

@interface BLEditAlert ()
@property (nonatomic, strong) UIView * txtContainView;
@property (nonatomic, strong) UITextField * txtField;
@property (nonatomic, strong) UITextView * txtView;

@end

@implementation BLEditAlert

- (void)initParams {
    [super initParams];
    self.editType = BLEditTypeTextField;
    self.txtHeight = 44;
    self.containHeight = kTitleSubmitHeight + BL_ADAPTATION(kContainPaddingTop) + BL_ADAPTATION(kContainPaddingBottom) + self.txtHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomView:self.txtContainView];
    [self.txtContainView addSubview:BLEditTypeTextField == self.editType ? self.txtField : self.txtView];
}

- (void)layoutView {
    [super layoutView];
    if (BLEditTypeTextField == self.editType) {
        [self.txtField mas_makeConstraints:self.txtField.constraintBlock];
    } else {
        [self.txtView mas_makeConstraints:self.txtView.constraintBlock];
    }

    // WARN: must remake,fix containView will move up in iOS 9+ with edit modal
    [self.containView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(kLeftMargin);
        make.right.equalTo(self.view).offset(-kRightMargin);
        make.height.mas_equalTo(self.containHeight);
    }];
}

#pragma mark - getter&setter
- (void)setEditProperties:(NSDictionary *)editProperties {
    for (NSString * key in editProperties) {
        if (BLEditTypeTextField == self.editType) {
            [self.txtField setValue:editProperties[key] forKeyOrPath:key];
        } else {
            [self.txtView setValue:editProperties[key] forKeyOrPath:key];
        }
    }
}
- (UITextField *)txtField {
    if (!_txtField) {
        _txtField = [[UITextField alloc] init];
        WEAKSELF
        _txtField.constraintBlock = ^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.txtContainView);
        };
    }
    return _txtField;
}

- (UITextView *)txtView {
    if (!_txtView) {
        _txtView = [[UITextView alloc] init];
        WEAKSELF
        _txtView.constraintBlock = ^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.txtContainView);
        };
    }
    return _txtView;
}
- (UIView *)txtContainView {
    if (!_txtContainView) {
        _txtContainView = [[UIView alloc] init];
    }
    return _txtContainView;
}
@end
