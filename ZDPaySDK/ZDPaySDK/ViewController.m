//
//  ViewController.m
//  ZDPaySDK
//
//  Created by FANS on 2020/4/20.
//  Copyright © 2020 ZhongDaoGroup. All rights reserved.
//

#import "ViewController.h"
#import "ZDPay_OrderSureViewController.h"
#import "ZDPay_OrderSureModel.h"
#import "ZDPay_MyWalletViewController.h"
#import "ZDPayFuncTool.h"
#import "ZDPickerView.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic ,copy)NSString *mobileStr;
@property (nonatomic ,copy)NSString *sandomNumStr;
@property (nonatomic ,copy)NSString *languageStr;
@property (nonatomic ,copy)NSString *moneyStr;
@property (nonatomic ,copy)NSString *cardNumStr;
@property (nonatomic ,assign)NSInteger btnTag;
@property (nonatomic ,assign)NSInteger btnTagone;
@property (nonatomic ,strong)UIButton *oldBtn;
@property (nonatomic ,strong)UIButton *oldBtnone;
@property (nonatomic ,assign)NSInteger textTag;
@property (nonatomic ,strong)UIScrollView *testScrollView;
@property (nonatomic ,copy)NSString *urlStr;
@property (nonatomic ,copy)NSString *merID_Str;
@property (nonatomic ,copy)NSString *AES_Key_Str;
@property (nonatomic ,copy)NSString *md5_salt_Str;
@property (nonatomic ,strong)ZDPayPopView *popView;
@end

@implementation ViewController
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//        NSString * infoString =@"<div id=\"redirectTo3ds1AcsSimple\" xmlns=\"http://www.w3.org/1999/html\"> <iframe id=\"redirectTo3ds1Frame\" name=\"redirectTo3ds1Frame\" height=\"100%\" width=\"100%\" > </iframe> <form id =\"redirectTo3ds1Form\" method=\"POST\" action=\"https://mtf.gateway.mastercard.com/acs/MastercardACS/dacceb49-988b-44c5-a938-7230584a17fd\" target=\"redirectTo3ds1Frame\"> <input type=\"hidden\" name=\"PaReq\" value=\"eAFVUV1TwjAQfGeG/9Dp+GqTtBYrc4RBUYRBRYHhOaQROkPT0g8+/r2XlormJdlNbrO3B/1TvLMOKsujRPds5lDbUlomYaQ3PXu5eLkN7D5vt2CxzZQazpUsM8XhTeW52CgrCrGGmhV4PqN+YHOYDb7UnsNFk6Ok4wJpIJZmcit0wUHI/eP4nfue7zEK5AIhVtl4yCtR5uP2gOIoUNOgRaz4PNJJKs7WQuUFkIoCmZS6yM78nuLjBkCZ7fi2KNK8S8jxeHTEWjoyiYGYCyBXM7PS2Mqxt1MU8slIpf7hm0x3k2TyuVp2nsV0vP6YrlbLHhDzAkJRKO5Sl1HmdizKul6nyzpAKh5EbOzw+Who3WACpr2agdR8NKgBRgfkLwEYb4b5N200CNQpTbRCRWzu9wzk6vrp1QQqC4zOZ653Z5KrV2CirS6MSoQRoWe/kjEAiCkll6lhItVkkfk38XbrByVPsMk=\" /> <input type=\"hidden\" name=\"TermUrl\" value=\"https://mtf.gateway.mastercard.com/callbackInterface/gateway/3be2ecff4bf28dd98b17cbd5903854075d8a809ea81a3f2a531e2049a4360bc4\" /> <input type=\"hidden\" name=\"MD\" value=\"\" /> </form> <script id=\"authenticate-payer-script\"> var e=document.getElementById(\"redirectTo3ds1Form\"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script> </div>";
//        UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
//        //webView.delegate=self;
//
//        [self.view addSubview:webView];
//
//        [webView loadHTMLString:infoString baseURL:nil];
//
    
    self.mobileStr = @"13927495764";
    self.sandomNumStr = [NSString stringWithFormat:@"%d",[self getRandomNumber:1000000 to:200000000]];
    self.languageStr = @"zh_CN";
    self.moneyStr = @"2";
    self.cardNumStr = @"6223164991230014";
    self.urlStr = @"01";
    self.merID_Str = @"1000000";
    self.AES_Key_Str = @"1234567890secret";
    self.md5_salt_Str = @"md5_key";

    self.topNavBar.hidden = YES;
    [self testScrollView];
    [self registerForKeyboardNotifications];
    [self creatMyWalletBtnSel:@selector(btnAction:)];
    [self creatTestPagramsUISel:@selector(textFieldAction:) languageActiom:@selector(languageBtnAction:)];
}

- (void)creatTestPagramsUISel:(SEL)action languageActiom:(SEL)languageAction{

    NSArray *libelArray = @[@"注册手机号",@"随机订单号",@"金      额",@"身份证号",@"商 户 号",@"AES_Key",@"md5_salt"];
    NSArray *textArray = @[self.mobileStr,self.sandomNumStr,self.moneyStr,self.cardNumStr,self.merID_Str,self.AES_Key_Str,self.md5_salt_Str];
    for (int i = 0; i<libelArray.count; i++) {
        UILabel *label = [UILabel new];
        [_testScrollView addSubview:label];
        CGRect rect = [ZDPayFuncTool getStringWidthAndHeightWithStr:@"注册手机号" withFont:ZD_Fout_Regular(ratioH(16))];
        label.textColor = COLORWITHHEXSTRING(@"#333333", 1);
        label.font = ZD_Fout_Regular(ratioH(16));
        label.frame = CGRectMake(20, ratioH(200+20) + mcNavBarAndStatusBarHeight + i*(ratioH(40)+ratioH(16)), rect.size.width, ratioH(16));
        label.text = libelArray[i];

        UITextField *textField = [UITextField new];
        textField.tag = 100+i;
        textField.textColor = [UIColor grayColor];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        [_testScrollView addSubview:textField];
        [textField addTarget:self action:action forControlEvents:UIControlEventEditingChanged];

        UIView *lineView = [UIView new];
        lineView.backgroundColor = COLORWITHHEXSTRING(@"#E9EBEE", 1.0);
        [_testScrollView addSubview:lineView];
        
        textField.text = textArray[i];
        textField.frame = CGRectMake(20+rect.size.width+10, ratioH(200)+mcNavBarAndStatusBarHeight+i*(ratioH(56)), ScreenWidth-40-rect.size.width-10, ratioH(56));
        lineView.frame = CGRectMake(20, ratioH(200+57)+mcNavBarAndStatusBarHeight+i*(ratioH(55)), ScreenWidth-40, ratioH(1.0));
        if (i == libelArray.count-1) {
            textField.keyboardType = UIKeyboardTypeASCIICapable;
        }
        
        if (i==2) {
            textField.keyboardType = UIKeyboardTypeDecimalPad;
        }
        if (i==1) {
            textField.keyboardType = UIKeyboardTypeASCIICapable;
        }
        if (i >= 4) {
            textField.keyboardType = UIKeyboardTypeASCIICapable;
        }
    }
    
    NSArray *languageTypeAry = @[@"zh_CN",@"en_US",@"zh_HK"];
    float s = (ScreenWidth-80*languageTypeAry.count-40)/(languageTypeAry.count+1);
    for (int i = 0; i<languageTypeAry.count; i++) {
        UIButton *languageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_testScrollView addSubview:languageBtn];
        [languageBtn addTarget:self action:@selector(languageBtnAction:) forControlEvents:UIControlEventTouchUpInside];

        languageBtn.frame = CGRectMake(20+i*(80 + s), ratioH(280)+mcNavBarAndStatusBarHeight+56*7, 80, 40);
        languageBtn.layer.cornerRadius = 20;
        languageBtn.layer.masksToBounds = YES;
        languageBtn.tag = 200+i;
        languageBtn.backgroundColor = COLORWITHHEXSTRING(@"#333333", 1.0);
        [languageBtn setTitle:languageTypeAry[i] forState:UIControlStateNormal];
        [languageBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        languageBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        if (languageBtn.tag == 200) {
            self.btnTag = 200;
            languageBtn.selected = YES;
            languageBtn.backgroundColor = [UIColor redColor];
        }
    }
}

- (void)creatMyWalletBtnSel:(SEL)action {
    NSArray *array = @[@"测式环境",@"正试环境"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
        
        CGRect envir_BtnRect = [ZDPayFuncTool getStringWidthAndHeightWithStr:array[i] withFont:[UIFont systemFontOfSize:15]];
        UIButton *envir_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [envir_Btn addTarget:self action:@selector(envir_BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        envir_Btn.frame = CGRectMake(20+i*(envir_BtnRect.size.width+20+40), 40, envir_BtnRect.size.width+40,45);
        envir_Btn.backgroundColor = COLORWITHHEXSTRING(@"#333333", 1.0);
        [envir_Btn setTitle:array[i] forState:UIControlStateNormal];
        envir_Btn.layer.cornerRadius = 22.5;
        envir_Btn.layer.masksToBounds = YES;
        envir_Btn.tag = 33+i;
        [_testScrollView addSubview:envir_Btn];
        if (envir_Btn.tag == 33) {
            self.btnTagone = 33;
            envir_Btn.selected = YES;
            envir_Btn.backgroundColor = [UIColor redColor];
        }
    }];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(40, 130, [UIScreen mainScreen].bounds.size.width-80,45);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"支付" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 22.5;
    btn.layer.masksToBounds = YES;
    btn.tag = 100;
    [_testScrollView addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(40, 200, [UIScreen mainScreen].bounds.size.width-80,45);
    btn2.backgroundColor = [UIColor redColor];
    //[[ZDPayInternationalizationModel sharedSingleten] getModelData].MY_WALLET
    [btn2 setTitle:@"我的钱包" forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 22.5;
    btn2.layer.masksToBounds = YES;
    btn2.tag = 101;
    [_testScrollView addSubview:btn2];
}

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 100) {
        [self callbackInterface];
    } else {

        NSDictionary *dic = @{

            @"mcc": @"5045",
            @"orderNo": self.sandomNumStr,//@"23423143253215"
            @"notifyUrl": @"http://test.powerpay.hk/notify",
            @"realIp": @"127.0.0.1",
            @"service": @"1",
            @"subject": @"HK Micro Test",
            @"phoneSystem":@"Ios",
            @"userId": @"oNLy6wLBpaX8QK8rk3v0ikzB-thg",
            @"version": @"1.0",
            @"txnAmt": self.moneyStr,
            @"language": self.languageStr,
            @"registerCountryCode": @"86",
            @"registerMobile": self.mobileStr,//@"13927495764"
            @"txnCurr": @"1",
            @"purchaseType":@"TRADE",//TRADE
            @"countryCode":@"HK",
            @"isSendPurchase":@"1",
            @"payInst":@"ALIPAYCN",
//        @"AES_Key":@"030646fd09ba4c44",//正式
//        @"md5_salt":@"FqkTPuuSbPO7iYZ",//正式
//        @"merId": @"606034453992033",//正式
//        @"urlStr":@"00",//正式
            @"merId": self.merID_Str,//测试
            @"AES_Key":self.AES_Key_Str,//测试
            @"md5_salt":self.md5_salt_Str,//测试
            @"urlStr":self.urlStr,//测试
//            @"merId": @"868000291807927",//测试
//            @"AES_Key":@"92ef5e4590ab46a5",//测试
//            @"md5_salt":@"b0dc78df9",//测试
//            @"urlStr":self.urlStr,//测试
        };
        [[ZDPay_OrderSureModel sharedSingleten] setModelProcessingDic:dic];
        ZDPay_MyWalletViewController *vc = [ZDPay_MyWalletViewController new];
        vc.orderModel = [[ZDPay_OrderSureModel sharedSingleten] getModelData];
        vc.walletType = WalletType_binding;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)callbackInterface {
    NSDictionary *dic = @{
        @"desc": @"desc",
        @"mcc": @"5045",
        @"orderNo": self.sandomNumStr,
        @"notifyUrl": @"http://test.powerpay.hk/notify",
        @"realIp": @"127.0.0.1",
        @"referUrl": @"www.baidu.com",
        @"service": @"1",
        @"subAppid": @"wx53a612d04b9e1a22",
        @"subject": @"HK Micro Test",
        @"timeExpire": @"2",
        @"phoneSystem":@"Ios",
        @"userId": @"oNLy6wLBpaX8QK8rk3v0ikzB-thg",
        @"version": @"1.0",
        @"txnAmt": self.moneyStr,
        @"language": self.languageStr,
        @"registerCountryCode": @"86",
        @"registerMobile": self.mobileStr,
        @"txnCurr": @"HK",
        @"cardNum": self.cardNumStr,//6223164991230014
        @"purchaseType":@"TRADE",
        @"isSendPurchase":@"1",
        @"countryCode":@"HK",
        @"subject": @"HK Micro Test",
        @"merchantid":@"merchant.testhk.qtopay.cn.ZDPaySDK",
        @"payTimeout": @"20200427094403",
        @"txnTime": @"20200427094403",//@"txnTime": @"20200427094403",
        @"currencyCode":@"HKD",
        @"BeeMall":@"苹果支付",
        @"isPopup":@"1",
        @"title":@"温馨提示",
        @"massage":@"订购【蜜蜂海淘】商品,请确保【订购人】信息您的支付宝/微信/银行卡名字对应。否则您的订单将无法清关,无法收货!",
        @"associate_domain":@"https://www.bmall.com.hk/.well-known/apple-app-site-association",
        @"payInst":@"ALIPAYCN",
//        @"AES_Key":@"030646fd09ba4c44",//正式
//        @"md5_salt":@"FqkTPuuSbPO7iYZ",//正式
//        @"merId": @"606034453992033",//正式
//        @"urlStr":@"00",//正式
        @"merId": self.merID_Str,//测试
        @"AES_Key":self.AES_Key_Str,//测试
        @"md5_salt":self.md5_salt_Str,//测试
        @"urlStr":self.urlStr,//测试
//        @"merId": @"868000291807927",//测试
//        @"AES_Key":@"92ef5e4590ab46a5",//测试
//        @"md5_salt":@"b0dc78df9",//测试
//        @"urlStr":self.urlStr,//测试
    };
    
    [[ZDPay_OrderSureModel sharedSingleten] setModelProcessingDic:dic];
    ZDPay_OrderSureViewController *vc = [ZDPay_OrderSureViewController new];
    vc.orderModel = [[ZDPay_OrderSureModel sharedSingleten] getModelData];
    [vc ZDPay_PaymentResultCallbackWithCompletionBlock:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [self showMessage:[responseObject objectForKey:@"message"] target:nil];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 键盘遮挡
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
}

//键盘弹出 处理遮挡问题
- (void)keyboardWillShown: (NSNotification *)notify {
    UITextField *_numField = [_testScrollView viewWithTag:self.textTag];
    NSDictionary *dic = notify.userInfo;
//    CGFloat duration = [[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue *value = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize size = [value CGRectValue].size;
//获取键盘高度
    CGFloat keyBoardHeight = size.height;

    CGRect frame = _numField.frame;
    int offset = frame.origin.y + 100 - (ScreenHeight - keyBoardHeight);
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    
    //将视图y坐标向上移动offset个单位，以使下面有地方显示键盘
    
    if(offset > 0){
        _testScrollView.frame = CGRectMake(0.0f, -offset, ScreenWidth,ScreenHeight);
        _testScrollView.backgroundColor = [UIColor whiteColor];
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.textTag = textField.tag;
    return YES;
}

#pragma mark--UITextFieldDelegate编辑完成，视图恢复原状
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _testScrollView.frame =CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - lazy loading
- (UIScrollView *)testScrollView {
    if (!_testScrollView) {
        _testScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
        _testScrollView.contentSize = CGSizeMake(ScreenWidth, ratioH(280)+mcNavBarAndStatusBarHeight+56*7+40+50);
        _testScrollView.showsVerticalScrollIndicator = YES;
        [self.view addSubview:_testScrollView];
        
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_testScrollView addGestureRecognizer:tap];
    }
    return _testScrollView;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self.testScrollView endEditing:YES];
}

#pragma mark - Action
- (void)envir_BtnAction:(UIButton *)sender
{
//    ZDPayPopView *popView = [ZDPayPopView readingEarnPopupViewWithType:6];
//    [popView showPopupMakeViewWithData:nil addCreditCard:^(UIButton * _Nonnull sender) {
//
//    }];
    if (sender.tag == 33) {
        self.urlStr = @"01";
    } else {
        self.urlStr = @"00";
    }

    self.oldBtnone = [self.view viewWithTag:self.btnTagone];
    if (sender.tag == self.btnTagone) {
        return;
    }
    if (sender.selected == YES) {
        sender.backgroundColor = [UIColor redColor];
        self.oldBtnone.backgroundColor = COLORWITHHEXSTRING(@"#333333", 1.0);
        sender.selected = NO;
        self.btnTagone = sender.tag;
    } else {
        sender.backgroundColor = [UIColor redColor];
        self.oldBtnone.backgroundColor = COLORWITHHEXSTRING(@"#333333", 1.0);
        self.btnTagone = sender.tag;
        sender.selected = YES;
    }
}

- (void)textFieldAction:(UITextField *)textField {
    self.textTag = textField.tag;
    if (textField.tag == 100) {
        self.mobileStr = textField.text;
    }
    if (textField.tag == 101) {
        self.sandomNumStr = textField.text;
    }
    if (textField.tag == 102) {
        self.moneyStr = textField.text;
    }
    if (textField.tag == 103) {
        self.cardNumStr = textField.text;
    }
    if (textField.tag == 104) {
        self.merID_Str = textField.text;
    }
    if (textField.tag == 105) {
        self.AES_Key_Str = textField.text;
    }
    if (textField.tag == 106) {
        self.md5_salt_Str = textField.text;
    }
}

- (void)languageBtnAction:(UIButton *)sender {
    self.languageStr = sender.titleLabel.text;

    self.oldBtn = [self.view viewWithTag:self.btnTag];
    
    if (sender.tag == self.btnTag) {
        return;
    }
    if (sender.selected == YES) {
        sender.backgroundColor = [UIColor redColor];
        self.oldBtn.backgroundColor = COLORWITHHEXSTRING(@"#333333", 1.0);
        sender.selected = NO;
        self.btnTag = sender.tag;
    } else {
        sender.backgroundColor = [UIColor redColor];
        self.oldBtn.backgroundColor = COLORWITHHEXSTRING(@"#333333", 1.0);
        self.btnTag = sender.tag;
        sender.selected = YES;
    }
}
@end
