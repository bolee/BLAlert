//
//  BLAlert.m
//  BLAlertDemo
//
//  Created by lee on 2018/11/30.
//  Copyright © 2018 Lee. All rights reserved.
//
#import "BLAlert.h"
NSString * const kAlphaProperty = @"alpha";
NSString * const kBackgroundColorProperty = @"backgroundColor";
NSString * const kCornerRadiusProperty = @"layer.cornerRadius";
NSString * const kBorderWidthProperty = @"layer.borderWidth";
NSString * const kBorderColorProperty = @"layer.borderColor";
NSString * const kTextProperty = @"text";
NSString * const kTextColorProperty = @"textColor";
NSString * const kTextFontProperty = @"font";
NSString * const kTextAligmentProperty = @"textAlignment";
NSString * const kAttributeTextProperty = @"attributedText";
NSString * const kNumberOfLinesProperty = @"numberOfLines";

@interface BLAlert ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWindow * prevWindow;
@property (nonatomic, strong) UIWindow * blWindow;
@property (nonatomic, strong, readwrite) UIView * containView;
@property (nonatomic, strong, readwrite) UIView * customView;
@end

@implementation BLAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:self.containView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}
- (void)layoutView {
    if (self.containView.constraintBlock) {
        [self.containView mas_makeConstraints:self.containView.constraintBlock];
    } else {
        [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset( FitWidth(15) );
            make.right.equalTo(self.view).offset(-FitWidth(15));
            make.centerY.equalTo(self.view).offset(-kBLScreenHeight);
            make.height.mas_equalTo(kBLScreenHeight * 1 / 3.0);
        }];
    }
    if (self.customView) {
        if (self.customView.constraintBlock) {
            [self.customView mas_makeConstraints:self.customView.constraintBlock];
        } else {
            [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.containView);
            }];
        }
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.containView.center = self.view.center;
    }];
}
#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.containView]) {
        return NO;
    }
    return YES;
}
#pragma mark - response
- (void)show {
    [self layoutView];
    self.prevWindow = [UIApplication sharedApplication].keyWindow;
    [self.blWindow.rootViewController addChildViewController:self];
    [self.blWindow.rootViewController.view addSubview:self.view];
    [self.blWindow makeKeyAndVisible];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.containView.center = CGPointMake(kBLScreenWidth / 2.0, kBLScreenHeight + self.containView.frame.size.height);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        [self.prevWindow makeKeyAndVisible];
        self.prevWindow = nil;
    }];
}
- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    [self.containView addSubview:customView];
}

#pragma mark - setter&getter
- (UIWindow *)blWindow {
    if (!_blWindow) {
        _blWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _blWindow.windowLevel = UIWindowLevelAlert;
        _blWindow.accessibilityViewIsModal = YES;
        _blWindow.rootViewController = [[UIViewController alloc] init];
        _blWindow.backgroundColor = UIColor.clearColor;
    }
    return _blWindow;
}
- (UIView *)containView {
    if (!_containView) {
        _containView = [[UIView alloc] init];
        _containView.clipsToBounds = YES;
        _containView.layer.cornerRadius = 5;
        _containView.backgroundColor = UIColorFromRGB(0x3A4048);
    }
    return _containView;
}
- (void)setContainViewProperties:(NSDictionary *)containViewProperties {
    for (NSString * key in containViewProperties) {
        [self.containView setValue:containViewProperties[key] forKey:key];
    }
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.view.backgroundColor = backgroundColor;
}
- (void)setAlpha:(CGFloat)alpha {
    self.view.alpha = alpha;
}
@end
