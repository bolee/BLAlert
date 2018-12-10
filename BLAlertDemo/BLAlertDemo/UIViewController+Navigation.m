//
//  UIViewController+Navigation.m
//  BLAlertDemo
//
//  Created by lee on 2018/12/10.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)
- (BOOL)isPush {
    return ![self isPresent];
}
- (BOOL)isPresent {
    if (!self.navigationController) {
        return YES;
    }
    if (self.navigationController.viewControllers.count <= 1) {
        return YES;
    }
    return NO;
}
@end
