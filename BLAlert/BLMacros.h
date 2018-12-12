//
//  BLMacros.h
//  BLAlertDemo
//
//  Created by lee on 2018/12/4.
//  Copyright © 2018 Lee. All rights reserved.
//

#ifndef BLMacros_h
#define BLMacros_h

#define kBLScreenWidth [UIScreen mainScreen].applicationFrame.size.width
#define kBLScreenHeight [UIScreen mainScreen].applicationFrame.size.height

#define UIColorFromRGB(rgbValue) [UIColor                       \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:1.0]

#define WEAKSELF __weak typeof(self) weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define BL_ADAPTATION(wh) ceilf(kBLScreenWidth / 375.0 * wh)

#endif /* BLMacros_h */
