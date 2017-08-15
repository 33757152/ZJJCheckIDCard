//
//  ViewController.m
//  ZJJCheckIDCard
//
//  Created by 张锦江 on 2017/8/14.
//  Copyright © 2017年 ZJJ. All rights reserved.
//
#define  SCREEN_WIDTH  self.view.frame.size.width

#import "ViewController.h"
#import "ZJJResultDesModel.h"
#import "ZJJCalculateIDCardCorrect.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *resLabel;
@property (nonatomic, strong) UITextField *inputTF;
@property (nonatomic, strong) UIButton *checkBtn;
@property (nonatomic, strong) NSDictionary *desDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatBaseSeting];
}

- (void)creatBaseSeting {
    [self.view addSubview:self.resLabel];
    [self.view addSubview:self.inputTF];
    [self.view addSubview:self.checkBtn];
}

- (UILabel *)resLabel {
    if (!_resLabel) {
        _resLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 150)];
        _resLabel.backgroundColor = [UIColor greenColor];
        _resLabel.text = @"展示结果区";
        _resLabel.textColor = [UIColor redColor];
        _resLabel.font = [UIFont systemFontOfSize:25.0f];
        _resLabel.textAlignment = NSTextAlignmentCenter;
        _resLabel.numberOfLines = 0;
    }
    return _resLabel;
}

- (UITextField *)inputTF {
    if (!_inputTF) {
        _inputTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, SCREEN_WIDTH-40, 40)];
        _inputTF.borderStyle = UITextBorderStyleRoundedRect;
        _inputTF.keyboardType = UIKeyboardTypeNamePhonePad;
        _inputTF.returnKeyType = UIReturnKeyDone;
        _inputTF.placeholder = @"请输入有效的身份证号码...";
        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTF.delegate = self;
    }
    return _inputTF;
}

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _checkBtn.frame = CGRectMake(100, 300, SCREEN_WIDTH-200, 50);
        _checkBtn.backgroundColor = [UIColor redColor];
        [_checkBtn setTitle:@"开始检验" forState:UIControlStateNormal];
        [_checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_checkBtn addTarget:self action:@selector(checkID) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

- (NSDictionary *)desDic {
    if (!_desDic) {
        ZJJResultDesModel *object = [[ZJJResultDesModel alloc] init];
        _desDic = object.desDic;
    }
    return _desDic;
}
- (void)checkID {
    int resultInt = [ZJJCalculateIDCardCorrect checkIDCardIsCorrectWithStr:_inputTF.text];
    NSString *resStr = [NSString stringWithFormat:@"%d",resultInt];
    _resLabel.text = self.desDic[resStr];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
