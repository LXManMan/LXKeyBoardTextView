//
//  LXKeyboadController.m
//  LXKeyBoardTextView
//
//  Created by chenergou on 2017/12/21.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXKeyboadController.h"
#import "LXKeyBoard.h"

@interface LXKeyboadController ()<UITextViewDelegate>

@property(nonatomic,strong)LXKeyBoard *keyboard;
@property(nonatomic,strong)UILabel *resultLabel;

@end

@implementation LXKeyboadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.title = @"控制多行输入键盘";
    
    [self setup];
    
    if (@available(iOS 11.0, *)) {
      
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // 这部分使用到的过期api
        self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
    }
   
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.keyboard.isDisappear = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.keyboard.isDisappear = YES;
}
-(void)setup{
    [self.view addSubview:self.keyboard];
    [self.view addSubview:self.resultLabel];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(LXKeyBoard *)keyboard{
    if (!_keyboard) {
        _keyboard =[[LXKeyBoard alloc]initWithFrame:CGRectZero];
        _keyboard.backgroundColor =[UIColor whiteColor];
        _keyboard.maxLine = 3;
        _keyboard.font = Font(18);
        _keyboard.topOrBottomEdge = 10;
        [_keyboard beginUpdateUI];
        LXWS(weakSelf);
        
        _keyboard.sendBlock = ^(NSString *text) {
            NSLog(@"%@",text);
            weakSelf.resultLabel.text = text;
            [weakSelf.resultLabel sizeThatFits:CGSizeMake(Device_Width - 40, MAXFLOAT)];
        };
    }
    return _keyboard;
}
-(UILabel *)resultLabel{
    if (!_resultLabel) {
        _resultLabel =[UILabel LXLabelWithText:@"" textColor:[UIColor hexStringToColor:@"3c3c3c"] backgroundColor:[UIColor lightGrayColor] frame:CGRectMake(20, 64, Device_Width - 40, 200) font:Font(15) textAlignment:NSTextAlignmentLeft];
        _resultLabel.numberOfLines = 0;
        _resultLabel.verticalStyle = LXVerticalAlignmentTop;
    }
    return _resultLabel;
}
@end
