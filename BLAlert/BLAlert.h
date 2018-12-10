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

NS_ASSUME_NONNULL_BEGIN
// KVC
UIKIT_EXTERN NSString * const kAlphaProperty;
UIKIT_EXTERN NSString * const kBackgroundColorProperty;
UIKIT_EXTERN NSString * const kCornerRadiusProperty;
UIKIT_EXTERN NSString * const kBorderWidthProperty;
UIKIT_EXTERN NSString * const kBorderColorProperty;
UIKIT_EXTERN NSString * const kTextProperty;
UIKIT_EXTERN NSString * const kTextColorProperty;
UIKIT_EXTERN NSString * const kTextFontProperty;
UIKIT_EXTERN NSString * const kTextAligmentProperty;
UIKIT_EXTERN NSString * const kAttributeTextProperty;
UIKIT_EXTERN NSString * const kNumberOfLinesProperty;

// notification
UIKIT_EXTERN NSString * const kDismissNotification;

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

@interface BLAlert : UIViewController
@property (nonatomic, strong, readonly) UIView * containView;
@property (nonatomic, assign) BOOL needNavigation;
@property (nonatomic, strong, readwrite) NSDictionary * containViewProperties;
@property (nonatomic, strong, readonly) UIView * customView;
@property (nonatomic, strong) UIColor * backgroundColor;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) BLAlertShowAnimation showAnimation;
@property (nonatomic, assign) BLAlertHiddenAnimation hiddenAnimation;

- (void)setCustomView:(UIView *)customView;
- (void)layoutView;
- (void)show;
- (void)dismiss;
- (UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
