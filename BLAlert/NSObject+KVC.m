//
//  NSObject+KVC.m
//  BLAlertDemo
//
//  Created by lee on 2018/12/18.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "NSObject+KVC.h"

@implementation NSObject (KVC)
- (void)setValue:(id)value forKeyOrPath:(NSString *)key {
    if ([key containsString:@"."]) {
        [self setValue:value forKeyPath:key];
    } else {
        [self setValue:value forKey:key];
    }
}
@end
