//
//  BLAlert.h
//  BLAlertDemo
//
//  Created by lee on 2018/11/30.
//  Copyright © 2018 Lee. All rights reserved.
//
// 弹出框界面
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "BLMacros.h"
#import "UIView+Constraint.h"
#import "NSObject+KVC.h"

NS_ASSUME_NONNULL_BEGIN
// KVC
extern NSString * const kAlphaProperty;
extern NSString * const kBackgroundColorProperty;
extern NSString * const kCornerRadiusProperty;
extern NSString * const kBorderWidthProperty;
extern NSString * const kBorderColorProperty;
extern NSString * const kTextProperty;
extern NSString * const kTextColorProperty;
extern NSString * const kTextFontProperty;
extern NSString * const kTextAligmentProperty;
extern NSString * const kAttributeTextProperty;
extern NSString * const kNumberOfLinesProperty;

// notification
extern NSString * const kDismissNotification;

//
extern CGFloat const kLeftMargin;   //contain左边距
extern CGFloat const kRightMargin;  //contain右边距
// 内容区域padding，如果是包含title和submit则指的是title和submit中间的内容区域
extern CGFloat const kContainPaddingTop; //
extern CGFloat const kContainPaddingBottom;//
extern CGFloat const kContainPaddingLeft;//
extern CGFloat const kContainPaddingRight;//

//
typedef NS_ENUM(NSInteger, BLAlertShowAnimation) {
    BLAlertShowAnimationNone,
    BLAlertShowAnimationFadeIn,
    BLAlertShowAnimationSlideInFromTop,
    BLAlertShowAnimationSlideInFromBottom,
    BLAlertShowAnimationSlideInFromLeft,
    BLAlertShowAnimationSlideInFromRight,
    BLAlertShowAnimationSlideInFromCenter,
};
typedef NS_ENUM(NSInteger, BLAlertHiddenAnimation) {
    BLAlertHiddenAnimationNone,
    BLAlertHiddenAnimationFadeOut,
    BLAlertHiddenAnimationSlideToTop,
    BLAlertHiddenAnimationSlideToBottom,
    BLAlertHiddenAnimationSlideToLeft,
    BLAlertHiddenAnimationSlideToRight,
    BLAlertHiddenAnimationSlideToCenter,
};

//
typedef void(^Completention)(void);

@interface BLAlert : UIViewController
@property (nonatomic, strong, readonly) UIView * containView;
@property (nonatomic, assign) CGFloat containHeight;
@property (nonatomic, assign) BOOL needNavigation;
@property (nonatomic, strong, readwrite) NSDictionary * containViewProperties;
@property (nonatomic, strong, readonly) UIView * customView;
@property (nonatomic, strong) UIColor * backgroundColor;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) BLAlertShowAnimation showAnimation;
@property (nonatomic, assign) BLAlertHiddenAnimation hiddenAnimation;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, assign) CGFloat containPaddingTop;
@property (nonatomic, assign) CGFloat containPaddingBottom;
@property (nonatomic, assign) CGFloat containPaddingLeft;
@property (nonatomic, assign) CGFloat containPaddingRight;
@property (nonatomic, copy) Completention dismissComplete;

- (instancetype)initWithConfiguration:(NSDictionary *)confiure;
- (void)initParams;
- (void)setCustomView:(UIView *)customView;
- (void)layoutView;
- (void)show;
- (void)showWithController:(UIViewController *)controller;
- (void)dismiss;
- (UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
