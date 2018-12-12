//
//  BLPasswdAlert.h
//  BLAlertDemo
//
//  Created by lee on 2018/12/11.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "BLConfirmAlert.h"

typedef NS_ENUM(NSInteger, BLPasswdAlertTextAlign) {
    BLPasswdAlertTextAlignHorizontal,
    BLPasswdAlertTextAlignVertical,
};

@interface BLPasswdAlert : BLConfirmAlert
@property (nonatomic, assign, getter=isSecurity) BOOL security;
@property (nonatomic, assign) BLPasswdAlertTextAlign align;
@property (nonatomic, strong) NSDictionary * securyTitleProperties;
@property (nonatomic, strong) NSDictionary * securyTextFieldProperties;
@property (nonatomic, copy) NSString * textString;

@end
