//
//  ViewController.m
//  BLAlertDemo
//
//  Created by lee on 2018/11/30.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "ViewController.h"
#import "BLConfirmAlert.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * showButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 150, 44)];
    showButton.layer.borderColor = UIColor.grayColor.CGColor;
    showButton.layer.borderWidth = 1;
    showButton.layer.cornerRadius = 3;
    [self.view addSubview:showButton];
    [showButton setTitle:@"Show Alert" forState:UIControlStateNormal];
    [showButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
}
- (void)showAlert{
    BLConfirmAlert * alert = [[BLConfirmAlert alloc] init];
//    [self presentViewController:alert animated:YES completion:nil];
    [alert show];
}


@end
