//
//  ViewController.m
//  BLAlertDemo
//
//  Created by lee on 2018/11/30.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "ViewController.h"
#import "BLConfirmAlert.h"
#import "ChildViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * showButton = [self makeButton:CGRectMake(10, 100, 150, 44) withTitle:@"ConfirmAlert"];
    [self.view addSubview:showButton];
    showButton.tag = 1;
    [showButton addTarget:self action:@selector(showConfirm:) forControlEvents:UIControlEventTouchUpInside];

    UIButton * alerBtn = [self makeButton:CGRectMake(165, 100, 150, 44) withTitle:@"Alert"];
    [self.view addSubview:alerBtn];
    alerBtn.tag = 2;
    [alerBtn addTarget:self action:@selector(showConfirm:) forControlEvents:UIControlEventTouchUpInside];
    alerBtn.center = self.view.center;
}
- (UIButton *)makeButton:(CGRect)frame withTitle:(NSString *)title {
    UIButton * showButton = [[UIButton alloc] initWithFrame:frame];//CGRectMake(10, 100, 150, 44)];
    showButton.layer.borderColor = UIColor.grayColor.CGColor;
    showButton.layer.borderWidth = 1;
    showButton.layer.cornerRadius = 3;
    [showButton setTitle:title forState:UIControlStateNormal];
    [showButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    [showButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    return showButton;
}
- (void)showAlert {
    BLAlert * alert = [[BLAlert alloc] init];
    UILabel * infoLabel = [[UILabel alloc] init];
    [alert setCustomView:infoLabel];
    infoLabel.numberOfLines = 0;
    infoLabel.attributedText = [[NSAttributedString alloc] initWithString:@"这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: UIColor.redColor}];

    UIView * superView = infoLabel.superview;
    infoLabel.constraintBlock = ^(MASConstraintMaker *make) {
        make.edges.equalTo(superView).insets(UIEdgeInsetsMake(15, 15, 15, 15));
    };
    [alert show];
}
- (void)showConfirm:(UIButton *)button{
    BLConfirmAlert * alert = [[BLConfirmAlert alloc] init];
    alert.backgroundColor = UIColor.clearColor;
    alert.hiddenTitle = NO;
    alert.hiddenCancel = NO;
    alert.containViewProperties = @{kBackgroundColorProperty: UIColorFromRGB(0x262C54), kAlphaProperty: @(0.9)};
    alert.titleProperties = @{kTextProperty: @"提示", kTextColorProperty: UIColor.whiteColor, kTextFontProperty: [UIFont systemFontOfSize:16]};
    alert.titleLineProperties = @{kBackgroundColorProperty: UIColorFromRGB(0x333A67)};
    alert.infoProperties = @{kTextProperty: @"这是信息内容.\n这是信息内容.\n这是信息内容.", kTextColorProperty: UIColor.purpleColor, kTextFontProperty: [UIFont systemFontOfSize:19]};
    alert.infoLineProperties = @{kBackgroundColorProperty: UIColorFromRGB(0x333A67)};
    alert.buttonLineProperties = @{kBackgroundColorProperty: UIColorFromRGB(0x333A67)};
    alert.cancelButtonProperties = @{kBackgroundColorProperty: UIColor.clearColor, kTextProperty: @"以后再说", kTextFontProperty: [UIFont systemFontOfSize:16], kTextColorProperty: UIColorFromRGB(0xBCC2EA)};
    alert.submitButtonProperties = @{kBackgroundColorProperty: UIColor.clearColor, kTextProperty: @"立即清除", kTextFontProperty: [UIFont systemFontOfSize:16], kTextColorProperty: UIColorFromRGB(0xBCC2EA)};
//    UILabel * infoLabel = [[UILabel alloc] init];
//    [alert setCustomView:infoLabel];
//    infoLabel.numberOfLines = 0;
//    infoLabel.attributedText = [[NSAttributedString alloc] initWithString:@"这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: UIColor.redColor}];
    __weak BLConfirmAlert * weakAlert = alert;
    alert.buttonResponse = ^BOOL(UIButton *button, ButtonType type) {
        if (ButtonTypeSubmit == type) {
            [self navChild:[weakAlert rootViewController] withAlert:weakAlert];
            return NO;
        }
        return YES;
    };
    alert.needNavigation = 1 == button.tag ? YES : NO;
    static NSInteger index = 0;
    alert.showAnimation = index;
    alert.hiddenAnimation = index;
    index++;
    [alert show];
}

- (void)navChild:(UIViewController *)vc withAlert:(BLConfirmAlert *)alert{
    ChildViewController * childVC = [[ChildViewController alloc] init];
    if (vc.navigationController) {
        [vc.navigationController pushViewController:childVC animated:YES];
    } else {
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:childVC];
        [vc presentViewController:nav animated:YES completion:nil];
    }
    childVC.CompleteBlock = ^{
//        [alert dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDismissNotification object:nil];
    };
    
}

@end
