//
//  BLEditAlert.m
//  BLAlertDemo
//
//  Created by BoLee on 2018/12/21.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "BLEditAlert.h"

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
    [self setCustomView:BLEditTypeTextField == self.editType ? self.txtField : self.txtView];
}

- (void)layoutView {
    [super layoutView];
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
    }
    return _txtField;
}

- (YYTextView *)txtView {
    if (!_txtView) {
        _txtView = [[YYTextView alloc] init];
    }
    return _txtView;
}
@end
