//
//  BLConfirmAlert.h
//  BLAlertDemo
//
//  Created by lee on 2018/12/4.
//  Copyright © 2018 Lee. All rights reserved.
//
// 带有标题，信息，确认和取消按钮

#import "BLAlert.h"

//
extern CGFloat const kTitleSubmitHeight;
extern CGFloat const kTitleHeight;
extern CGFloat const kSubmitHeight;
extern CGFloat const kLineHeight;

typedef NS_ENUM(NSInteger, ButtonType) {
    ButtonTypeSubmit    =   1,
    ButtonTypeCancel    =   2,
    ButtonTypeCustom    =   0,
};

typedef BOOL(^BLButtonClickBlock)(UIButton * button, ButtonType type);

@interface BLConfirmAlert : BLAlert
@property (nonatomic, assign) BOOL hiddenTitle;
@property (nonatomic, assign) BOOL hiddenCancel;
@property (nonatomic, copy) BLButtonClickBlock buttonResponse;

@property (nonatomic, strong) NSDictionary * titleProperties;
@property (nonatomic, strong) NSDictionary * titleLineProperties;
@property (nonatomic, strong) NSDictionary * infoProperties;
@property (nonatomic, strong) NSDictionary * infoLineProperties;
@property (nonatomic, strong) NSDictionary * cancelButtonProperties;
@property (nonatomic, strong) NSDictionary * submitButtonProperties;
@property (nonatomic, strong) NSDictionary * buttonLineProperties;
@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat submitHeight;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) CGFloat titleMarginTop;
@property (nonatomic, assign) CGFloat titleMarginBottom;
@property (nonatomic, assign) CGFloat titleMarginLeft;
@property (nonatomic, assign) CGFloat titleMarginRight;
@end
