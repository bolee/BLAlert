//
//  ChildViewController.m
//  BLAlertDemo
//
//  Created by lee on 2018/12/10.
//  Copyright © 2018 Lee. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "ChildViewController.h"
#import "UIViewController+Navigation.h"

@interface ChildViewController ()<UIWebViewDelegate, UINavigationBarDelegate>
@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Child";
    self.view.backgroundColor = UIColor.whiteColor;

    if ([self isPresent]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)backAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:self.CompleteBlock];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"error:%@", error.debugDescription);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
