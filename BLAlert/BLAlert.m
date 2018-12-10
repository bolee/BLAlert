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

NSString * const kDismissNotification = @"blalert.dismiss.notification";

CGFloat const kAnimationShowDuration = 0.2;
CGFloat const kAnimationHiddenDuration = 0.3;

@interface BLAlert ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWindow * prevWindow;
@property (nonatomic, strong) UIWindow * blWindow;
@property (nonatomic, strong) UINavigationController * navController;
@property (nonatomic, strong) UIViewController * viewController;
@property (nonatomic, strong, readwrite) UIView * containView;
@property (nonatomic, strong, readwrite) UIView * customView;
@end

@implementation BLAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:kDismissNotification object:nil];
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
    switch (self.showAnimation) {
        case BLAlertShowAnimationFadeIn:
            [self showAnimationFadeIn];
            break;
        case BLAlertShowAnimationSlideInFromTop:
            [self showAnimationSlideInFromTop];
            break;
        case BLAlertShowAnimationSlideInFromBottom:
            [self showAnimationSlideInFromBottom];
            break;
        case BLAlertShowAnimationSlideInFromLeft:
            [self showAnimationSlideInFromLeft];
            break;
        case BLAlertShowAnimationSlideInFromRight:
            [self showAnimationSlideInFromRight];
            break;
        case BLAlertShowAnimationSlideInFromCenter:
            [self showAnimationSlideInFromCenter];
            break;
        default:
            [self showAnimationNone];
            break;
    }
}

#pragma mark -- ShowAnimation
- (void)showAnimationNone{
    self.containView.center = self.view.center;
}
- (void)showAnimationFadeIn {
    self.containView.alpha = 0;
    self.containView.center = self.view.center;
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.alpha = 1;
    }];
}
- (void)showAnimationSlideInFromTop {
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = self.view.center;
    }];
}

- (void)showAnimationSlideInFromBottom {
    self.containView.center = CGPointMake(self.view.center.x, self.view.center.y * 3);
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = self.view.center;
    }];
}

- (void)showAnimationSlideInFromLeft {
    self.containView.center = CGPointMake(-self.view.center.x, self.view.center.y);
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = self.view.center;
    }];
}

- (void)showAnimationSlideInFromRight {
    self.containView.center = CGPointMake(self.view.center.x * 3, self.view.center.y);
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = self.view.center;
    }];
}

- (void)showAnimationSlideInFromCenter {
    self.containView.center = self.view.center;
    CGRect rect = self.containView.frame;
    self.containView.frame = CGRectMake(self.view.center.x, self.view.center.y, 1, 1);
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.frame = rect;
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
    [self.viewController addChildViewController:self];
    [self.viewController.view addSubview:self.view];
    [self.blWindow makeKeyAndVisible];
}

- (void)dismiss {
    switch (self.hiddenAnimation) {
        case BLAlertHiddenAnimationFadeOut:
            [self dismissAnimationFadOut];
            break;
        case BLAlertHiddenAnimationSlideToTop:
            [self dismissAnimationToTop];
            break;
        case BLAlertHiddenAnimationSlideToBottom:
            [self dismissAnimationToBottom];
            break;
        case BLAlertHiddenAnimationSlideToLeft:
            [self dismissAnimationToLeft];
            break;
        case BLAlertHiddenAnimationSlideToRight:
            [self dismissAnimationToRight];
            break;
        case BLAlertHiddenAnimationSlideToCenter:
            [self dismissAnimationToCenter];
            break;
        default:
            [self dismissAnimationNone];
            break;
    }
}

#pragma mark -- dismiss animation
- (void)dismissAnimationNone {
    [UIView animateWithDuration:kAnimationHiddenDuration animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        [self.prevWindow makeKeyAndVisible];
        self.prevWindow = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDismissNotification object:nil];
    }];
}
- (void)dismissAnimationFadOut {
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.alpha = 0;
    }];
    [self dismissAnimationNone];
}
- (void)dismissAnimationToTop {
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = CGPointMake(self.view.center.x, -self.view.center.y);
    }];
    [self dismissAnimationNone];
}
- (void)dismissAnimationToBottom {
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = CGPointMake(kBLScreenWidth / 2.0, kBLScreenHeight + self.containView.frame.size.height);
    }];
    [self dismissAnimationNone];
}
- (void)dismissAnimationToLeft {
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = CGPointMake(-self.view.center.x, self.view.center.y);
    }];
    [self dismissAnimationNone];
}
- (void)dismissAnimationToRight {
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.center = CGPointMake(2 * self.view.center.x, self.view.center.y);
    }];
    [self dismissAnimationNone];
}
- (void)dismissAnimationToCenter {
    [UIView animateWithDuration:kAnimationShowDuration animations:^{
        self.containView.frame = CGRectMake(self.view.center.x, self.view.center.y, 1, 1);
    }];
    [self dismissAnimationNone];
}

- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    [self.containView addSubview:customView];
}
- (UIViewController *)rootViewController {
    return self.viewController;
}

#pragma mark - setter&getter
- (UIWindow *)blWindow {
    if (!_blWindow) {
        _blWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _blWindow.windowLevel = UIWindowLevelAlert;
        _blWindow.accessibilityViewIsModal = YES;
        _blWindow.rootViewController = self.needNavigation ? self.navController : self.viewController;
        _blWindow.backgroundColor = UIColor.clearColor;
    }
    return _blWindow;
}
- (UIViewController *)viewController {
    if (!_viewController) {
        _viewController = [[UIViewController alloc] init];
    }
    return _viewController;
}

- (UINavigationController *)navController {
    if (!_navController) {
        _navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
        [_navController setNavigationBarHidden:YES animated:NO];
    }
    return _navController;
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
