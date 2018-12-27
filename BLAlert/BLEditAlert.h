//
//  BLEditAlert.h
//  BLAlertDemo
//
//  Created by BoLee on 2018/12/21.
//  Copyright © 2018 Lee. All rights reserved.
//

#import <YYKit/YYKit.h>
#import "BLConfirmAlert.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, BLEditType) {
    BLEditTypeTextView      =   1,
    BLEditTypeTextField     =   2,
};

@interface BLEditAlert : BLConfirmAlert
@property (nonatomic, strong) UITextField * txtField;
@property (nonatomic, strong) YYTextView * txtView;
@property (nonatomic, copy) NSString * editText;
@property (nonatomic, copy) NSDictionary * editProperties;
@property (nonatomic, assign) CGFloat txtHeight;

- (instancetype)initWithType:(BLEditType)type withConfigure:(NSDictionary *)configure;
@end

NS_ASSUME_NONNULL_END
