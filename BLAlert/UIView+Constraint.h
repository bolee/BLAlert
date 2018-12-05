//
//  UIView+Constraint.h
//  BLAlertDemo
//
//  Created by lee on 2018/12/5.
//  Copyright © 2018 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

typedef  void(^ConstraintBlock)(MASConstraintMaker *make);

@interface UIView (Constraint)

@property (nonatomic, copy) ConstraintBlock constraintBlock;

@end
