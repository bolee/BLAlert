//
//  NSObject+KVC.h
//  BLAlertDemo
//
//  Created by lee on 2018/12/18.
//  Copyright © 2018 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVC)
- (void)setValue:(id)value forKeyOrPath:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
