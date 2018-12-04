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

NS_ASSUME_NONNULL_BEGIN

@interface BLAlert : UIViewController
@property (nonatomic, strong) UIView * containView;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
