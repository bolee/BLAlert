//
//  ChildViewController.h
//  BLAlertDemo
//
//  Created by lee on 2018/12/10.
//  Copyright © 2018 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^CompleteBlock)(void);

@interface ChildViewController : UIViewController
@property (nonatomic, copy) void(^CompleteBlock)(void);

@end
