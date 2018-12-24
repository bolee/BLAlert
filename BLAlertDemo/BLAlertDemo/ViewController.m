//
//  ViewController.m
//  BLAlertDemo
//
//  Created by lee on 2018/11/30.
//  Copyright © 2018 Lee. All rights reserved.
//
#import <objc/runtime.h>
#import "ViewController.h"
#import "BLPasswdAlert.h"
#import "BLEditAlert.h"
#import "ChildViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField * txtFd;
@end

@implementation ViewController

- (void)setbg {
    self.view.backgroundColor = UIColor.blueColor;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.txtFd = [[UITextField alloc] init];
    [self.view addSubview:self.txtFd];
    self.txtFd.backgroundColor = UIColor.blueColor;
    self.txtFd.frame = CGRectMake(170, 100, 150, 44);

//    unsigned int outCount = 0;
//    Method * meths = class_copyMethodList([UITextField class], &outCount);
//    for (int i = 0; i < outCount; i++) {
//        Method mh = meths[i];
//        SEL sl = method_getName(mh);
//        NSLog(@"mname:%@", NSStringFromSelector(sl));
//    }

//    [self.txtFd setValue:UIColor.greenColor forKey:@"backgroundColor"];
//    [self.txtFd setValue:@(UIReturnKeyNext) forKey:@"returnKeyType"];
//    NSLog(@"==============%@", [self.txtFd valueForKey:@"UIFieldEditor"]);

//    [tfd setValue:@(UIReturnKeyNext) forKeyPath:@""];

//    tfd.returnKeyType = UIReturnKeyNext;
//    [tfd setReturnKeyType:UIReturnKeyNext];
//    [tfd performSelector:NSSelectorFromString(@"setReturnKeyType:") withObject:[NSNumber numberWithInt:UIReturnKeyNext]];
//    [self performSelector:NSSelectorFromString(@"setDstr:") withObject:@(UIReturnKeyNext)];

    UIButton *showButton = [self makeButton:CGRectMake(10, 100, 150, 44) withTitle:@"ConfirmAlert"];
    [self.view addSubview:showButton];
    showButton.tag = 1;
    [showButton addTarget:self action:@selector(showConfirm:) forControlEvents:UIControlEventTouchUpInside];
    showButton.backgroundColor = UIColor.purpleColor;

    UIButton *alerBtn = [self makeButton:CGRectMake(165, 100, 150, 44) withTitle:@"Alert"];
    [self.view addSubview:alerBtn];
    alerBtn.tag = 2;
    [alerBtn addTarget:self action:@selector(showPass/*showAlert:*/) forControlEvents:UIControlEventTouchUpInside];
    alerBtn.center = self.view.center;
    alerBtn.backgroundColor = UIColor.yellowColor;

    UIButton *passwd = [self makeButton:CGRectMake(10, 150, 150, 44) withTitle:@"Passwd Alert"];
    [self.view addSubview:passwd];
    [passwd addTarget:self action:@selector(showEdit) forControlEvents:UIControlEventTouchUpInside];
    passwd.backgroundColor = UIColor.redColor;

    UITextView *tView = [[UITextView alloc] initWithFrame:CGRectMake(10, kBLScreenHeight - 50, 150, 44)];
    tView.layer.borderWidth = 1;
    tView.layer.borderColor = UIColor.redColor.CGColor;
    [self.view addSubview:tView];

    [self addLabelLineh];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapAction {
    [self.view endEditing:YES];
}
- (void)addLabelLineh
{
    UILabel *label = [[UILabel alloc] init];
    label.clipsToBounds = YES;
    [label setValue:@(5) forKeyPath:@"layer.cornerRadius"];
    [label setValue:@(3) forKeyPath:@"layer.borderWidth"];
    [label setValue:(id)([UIColor blueColor].CGColor) forKeyOrPath:@"layer.borderColor"];
    [self.view addSubview:label];
    label.backgroundColor = UIColor.yellowColor;
    NSString *text = @"这是信息内容.这是信息内容.这是信息内容."; // @"연말을 맞아 한 해 동안 Polymaker 제품에 많은 관심과 성원을 보내준 고객들에게 보답하고자 'GIFT 증정 이벤트'를 이달 28일부터 12월 말까지 실시하오니 이번 기회를 놓치지 마세요!!\n\n(Polymaker는 3D 인쇄 산업에 사용되는 안전하고 깨끗한 재료를 생산하기 위해 혁신, 품질 그리고 환경을 생각하는 회사입니다.";//@"いつもくだらないけど、\nたくさんの方が観に来てくださって、\n本当に嬉しいですし、\n初見さんの方も増えて、\n通うようになってくださったりとか、、\n本当にありがたいです。。\nもっとたくさんの方に見てもらえるように、\nたくさん配信するぞぉぉー✨\n明日も配信できたらしますね😌\n朝からほぼ何も食べてないから、\nお腹すいたぁぁぁ( ˊ•̥  ̯ •̥`)";// @"Thanks to Leader McConnell for agreeing to bring a Senate vote on Criminal Justice this week! These historic changes will make communities SAFER and SAVE tremendous taxpayers dollars. It brings much needed hope to many families during the Holiday Season.";//@"这是信息。\n这是信息。\n这是信息。这是信息。\n这是信系。";//@"第二次世界大战可以说是人类历史上最残酷的战争，没有之一，全世界61个国家和地区，卷入了这场混战（二战前世界上独立国家才65个），超过20亿人陷入战火之中，生灵涂炭。不过这么多国家参战，成为五大战胜国的只有中美苏英法，也只有这五个国家成为联合国五常。不过关于这个问题，历来就有人不服，不少外国人质疑：“苏美英无话可说，凭啥中国也能是五大战胜国？”";
    NSMutableParagraphStyle *para = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    CGFloat lheight = 35;
    para.maximumLineHeight = lheight;
    para.minimumLineHeight = lheight;
    para.lineSpacing = 10;
    UIFont *font = [UIFont boldSystemFontOfSize:19];
    CGFloat baseOffset = (lheight - font.lineHeight) / 4;
    NSLog(@"lineHeight:%f, fontHeight:%f, baseOffset:%f=====", lheight, font.lineHeight, baseOffset);
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:text attributes:@{ NSFontAttributeName: font, NSParagraphStyleAttributeName: para, NSBaselineOffsetAttributeName: @(baseOffset) }];
//    label.attributedText = attr;
    label.text = text;
    label.numberOfLines = 0;
    label.font = font;// [UIFont systemFontOfSize:19];
//    CGRect rect = [label.attributedText boundingRectWithSize:CGSizeMake(kBLScreenWidth - 60, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(kBLScreenWidth - 60, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
    NSLog(@"rect:%f===linh:%f", rect.size.height, font.lineHeight);
    label.frame = CGRectMake(30, self.view.center.y + 50, rect.size.width /*kBLScreenWidth - 60*/, ceilf(rect.size.height));

    UILabel *lineHeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, 100, label.font.lineHeight /*lheight + 10*/)];
    lineHeightLabel.backgroundColor = UIColor.redColor;
    lineHeightLabel.alpha = 0.3;
    [self.view addSubview:lineHeightLabel];

    UILabel *lLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, 80, lheight)];
    lLabel.backgroundColor = UIColor.purpleColor;
    lLabel.alpha = 0.4;
//    [self.view addSubview:lLabel];
}

- (UIButton *)makeButton:(CGRect)frame withTitle:(NSString *)title
{
    UIButton *showButton = [[UIButton alloc] initWithFrame:frame]; //CGRectMake(10, 100, 150, 44)];
    showButton.layer.borderColor = UIColor.grayColor.CGColor;
    showButton.layer.borderWidth = 1;
    showButton.layer.cornerRadius = 3;
    [showButton setTitle:title forState:UIControlStateNormal];
    [showButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    [showButton addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    return showButton;
}
- (void)showEdit {
    BLEditAlert * alert = [[BLEditAlert alloc] init];
    alert.editType = BLEditTypeTextView;
    alert.editProperties = @{kBorderWidthProperty: @(1), kBorderColorProperty: (id)UIColor.grayColor.CGColor, @"placeholderText": @"thsi is placer holder text!", @"placeholderTextColor": UIColor.redColor, kTextColorProperty: UIColor.purpleColor};
//    alert.txtField.keyboardType = UIKeyboardTypeNumberPad;
//    alert.txtField.returnKeyType = UIReturnKeyDone;
//    alert.txtView.placeholderText = @"place holder ....";
//    alert.txtView.placeholderTextColor = UIColor.redColor;
    alert.txtView.returnKeyType = UIReturnKeyNext;
    [alert show];
    alert.dismissComplete = ^{
        BLLog(@"disssmissssssssss");
    };

}
- (void)showPass
{
    BLPasswdAlert *alert = [[BLPasswdAlert alloc] init];
    alert.align = BLPasswdAlertTextAlignVertical;
    alert.security = YES;
    [alert show];
    __weak BLPasswdAlert *weakAlert = alert;
    alert.buttonResponse = ^BOOL (UIButton *button, ButtonType type) {
        NSLog(@"passwd:%@", weakAlert.textString);
        return YES;
    };
}

- (void)showAlert:(UIButton *)button
{
    BLAlert *alert = [[BLAlert alloc] init];
    UILabel *infoLabel = [[UILabel alloc] init];
    [alert setCustomView:infoLabel];
    infoLabel.numberOfLines = 0;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容." attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: UIColor.redColor }];
    infoLabel.attributedText = attr;
    CGRect rect = [attr boundingRectWithSize:CGSizeMake(kBLScreenWidth - (BL_ADAPTATION(kLeftMargin) + BL_ADAPTATION(kRightMargin) + BL_ADAPTATION(kContainPaddingTop) + BL_ADAPTATION(kContainPaddingBottom)), CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
    UIView *superView = infoLabel.superview;
    infoLabel.backgroundColor = UIColor.clearColor;// .purpleColor;
    infoLabel.alpha = 0.3;
    infoLabel.constraintBlock = ^(MASConstraintMaker *make) {
        make.left.equalTo(superView).offset(BL_ADAPTATION(kLeftMargin));
        make.right.equalTo(superView).offset(-BL_ADAPTATION(kRightMargin));
        make.top.equalTo(superView).offset(BL_ADAPTATION(kContainPaddingTop));
        make.bottom.equalTo(superView).offset(-BL_ADAPTATION(kContainPaddingBottom));
    };
    alert.containHeight = ceilf(rect.size.height) + BL_ADAPTATION(kContainPaddingBottom) + BL_ADAPTATION(kContainPaddingTop) + 2 * kLineHeight;
    alert.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];//]UIColor.blackColor;
//    alert.alpha = 0.1;
    alert.containViewProperties = @{ kBackgroundColorProperty: UIColor.purpleColor, kAlphaProperty: @(1) };
    [alert show];
}

- (void)showConfirm:(UIButton *)button
{
    BLConfirmAlert *alert = [[BLConfirmAlert alloc] init];
    alert.backgroundColor = UIColor.clearColor;
    alert.hiddenTitle = YES;
    alert.hiddenCancel = NO;
    alert.containViewProperties = @{ kBackgroundColorProperty: UIColorFromRGB(0x262C54), kAlphaProperty: @(0.9), kBorderColorProperty: (id)(UIColor.blueColor.CGColor), kBorderWidthProperty: @(2) };
    alert.titleProperties = @{ kTextProperty: @"提示", kTextColorProperty: UIColor.whiteColor, kTextFontProperty: [UIFont systemFontOfSize:16] };
    alert.titleLineProperties = @{ kBackgroundColorProperty: UIColorFromRGB(0x333A67) };
    alert.infoProperties = @{ kTextProperty: @"这是信息内容.这是信息内容.这是信息内容.", kTextColorProperty: UIColor.purpleColor, kTextFontProperty: [UIFont systemFontOfSize:19], kTextAligmentProperty: @(NSTextAlignmentCenter) };
//    alert.infoProperties = @{kAttributeTextProperty: [[NSAttributedString alloc] initWithString:@"这是信息内容.这是信息内容.这是信息内容." attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:19], NSForegroundColorAttributeName: UIColor.yellowColor}], kTextAligmentProperty: @(NSTextAlignmentCenter)};

    alert.infoLineProperties = @{ kBackgroundColorProperty: UIColorFromRGB(0x333A67) };
    alert.buttonLineProperties = @{ kBackgroundColorProperty: UIColorFromRGB(0x333A67) };
    alert.cancelButtonProperties = @{ kBackgroundColorProperty: UIColor.clearColor, kTextProperty: @"以后再说", kTextFontProperty: [UIFont systemFontOfSize:16], kTextColorProperty: UIColorFromRGB(0xBCC2EA) };
    alert.submitButtonProperties = @{ kBackgroundColorProperty: UIColor.clearColor, kTextProperty: @"立即清除", kTextFontProperty: [UIFont systemFontOfSize:16], kTextColorProperty: UIColorFromRGB(0xBCC2EA) };
//    UILabel * infoLabel = [[UILabel alloc] init];
//    [alert setCustomView:infoLabel];
//    infoLabel.numberOfLines = 0;
//    infoLabel.attributedText = [[NSAttributedString alloc] initWithString:@"这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n这是信息内容.\n" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: UIColor.redColor}];
    __weak BLConfirmAlert *weakAlert = alert;
    alert.buttonResponse = ^BOOL (UIButton *button, ButtonType type) {
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

- (void)navChild:(UIViewController *)vc withAlert:(BLConfirmAlert *)alert
{
    ChildViewController *childVC = [[ChildViewController alloc] init];
    if (vc.navigationController) {
        [vc.navigationController pushViewController:childVC animated:YES];
    } else {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
        [vc presentViewController:nav animated:YES completion:nil];
    }
    childVC.CompleteBlock = ^{
//        [alert dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDismissNotification object:nil];
    };
}

@end
