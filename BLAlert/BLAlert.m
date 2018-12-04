//
//  BLAlert.m
//  BLAlertDemo
//
//  Created by lee on 2018/11/30.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "BLAlert.h"

@interface BLAlert ()
@property (nonatomic, strong) UIWindow * prevWindow;
@property (nonatomic, strong) UIWindow * blWindow;
@property (nonatomic, strong) UIView * containView;
@property (nonatomic, strong) UIButton * cancelButton;
@property (nonatomic, strong) UIButton * submitButton;
@end

@implementation BLAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.cyanColor;

    [self.view addSubview:self.submitButton];
    [self.view addSubview:self.cancelButton];

    self.submitButton.frame = CGRectMake(20, 150, 70, 44);
    self.cancelButton.frame = CGRectMake(20, 210, 70, 44);

    UITextField * tf = [[UITextField alloc] initWithFrame:CGRectMake(20, 270, 80, 44)];
    tf.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:tf];
}

#pragma mark - response
- (void)show {
    self.prevWindow = [UIApplication sharedApplication].keyWindow;
    [self.blWindow setRootViewController:self];
    [self.blWindow makeKeyAndVisible];
}
- (void)submitAction {

}
- (void)cancelAction{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [self.prevWindow makeKeyAndVisible];
    self.prevWindow = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - setter&getter
- (UIWindow *)blWindow {
    if (!_blWindow) {
        _blWindow = [[UIWindow alloc] init];
    }
    return _blWindow;
}
- (UIView *)containView {
    if (!_containView) {
        _containView = [[UIView alloc] init];
        _containView.clipsToBounds = YES;
        _containView.layer.cornerRadius = 5;
    }
    return _containView;
}
- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
@end
