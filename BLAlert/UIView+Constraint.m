//
//  UIView+Constraint.m
//  BLAlertDemo
//
//  Created by lee on 2018/12/5.
//  Copyright © 2018 Lee. All rights reserved.
//
#import <objc/runtime.h>
#import "UIView+Constraint.h"

@implementation UIView (Constraint)

static char constraintKey;
- (ConstraintBlock)constraintBlock {
    return objc_getAssociatedObject(self, &constraintKey);
}
- (void)setConstraintBlock:(ConstraintBlock)constraintBlock {
    objc_setAssociatedObject(self, &constraintKey, constraintBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
