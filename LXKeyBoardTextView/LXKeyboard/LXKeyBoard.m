//
//  LXKeyBoard.m
//  LXKeyBoardTextView
//
//  Created by chenergou on 2017/12/21.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXKeyBoard.h"
#import "LXTextView.h"
#define TEXTFONT  Font(16)
#define BTNW 60
@interface LXKeyBoard()<UITextViewDelegate>
@property(nonatomic,strong)LXTextView *textView;
@property(nonatomic,strong)LxButton *sendBtn;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,assign)CGFloat btnH;
@end
@implementation LXKeyBoard
{
    CGFloat keyboardY;
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@",self.class);
}
-(void)setMaxLine:(int)maxLine{
    _maxLine = maxLine;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    
    CGFloat orignTextH  = ceil (TEXTFONT.lineHeight + 16);
    
    self.frame =  CGRectMake(0, Device_Height - orignTextH, Device_Width, orignTextH);
    
    self.maxLine = 3;//默认最大三行
    
    self.btnH = self.lx_height;
    
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor =[UIColor hexStringToColor:@"A5A5A5"].CGColor;
        [self setup];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    return self;
}
-(void)textViewDidChange:(UITextView *)textView{
    
    CGFloat contentSizeH = self.textView.contentSize.height;
    CGFloat lineH = self.textView.font.lineHeight;
    
    
    
    CGFloat contentH = contentSizeH - 16;
    
    int line = contentH / lineH;
    
    NSLog(@"%f",lineH);
    
    
    if (line >self.maxLine) {
        
        CGPoint point = CGPointMake(0, (line -self.maxLine) *lineH +8 );
        [self.textView setContentOffset:point animated:NO];
        self.textView.lx_height = ceil(self.maxLine *lineH +8);
        
    }else{
        self.textView.lx_height = contentSizeH;
        [self.textView setContentOffset:CGPointZero animated:YES];
        
    }
    
    CGFloat textH = self.textView.lx_height;
    self.frame = CGRectMake(0, keyboardY - textH, self.lx_width, textH);
    self.textView.frame = CGRectMake(0, 0, self.lx_width - 60, textH);
    self.btnH = self.lx_height;
    self.sendBtn.frame = CGRectMake(self.lx_width - 60, 0, 60,  self.btnH);
    self.line.frame = CGRectMake(0, 5, 1,  self.btnH - 10);
    
}
-(void)keyboardWillChangeFrame:(NSNotification *)notification{

    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        NSLog(@"%@",NSStringFromCGRect(keyboardF));
    keyboardY = keyboardF.origin.y;

    if (!_isDisappear) {

        [self dealKeyBoardWithKeyboardF:keyboardY duration:duration];
       
    }


}

-(void)keyboardDidChangeFrame:(NSNotification *)notification{

    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        NSLog(@"%@",NSStringFromCGRect(keyboardF));

    keyboardY = keyboardF.origin.y;
//    // 工具条的Y值 == 键盘的Y值 - 工具条的高度
    if (_isDisappear) {
        [self dealKeyBoardWithKeyboardF:keyboardY duration:duration];
    }

}
#pragma mark---处理高度---
-(void)dealKeyBoardWithKeyboardF:(CGFloat)keyboardY duration:(CGFloat)duration {
    
    if (!_isDisappear) {
        [UIView animateWithDuration:duration animations:^{
            // 工具条的Y值 == 键盘的Y值 - 工具条的高度
            
            if (keyboardY > Device_Height) {
                self.lx_y = Device_Height- self.lx_height;
            }else
            {
                self.lx_y = keyboardY - self.lx_height;
            }
        }];
    }else{
        if (keyboardY > Device_Height) {
            self.lx_y = Device_Height- self.lx_height;
        }else
        {
            self.lx_y = keyboardY - self.lx_height;
        }
    }
    
  
}
-(void)setIsDisappear:(BOOL)isDisappear{
    _isDisappear = isDisappear;
}
-(void)setup{
    [self addSubview:self.textView];
    [self addSubview:self.sendBtn];
    [self.sendBtn addSubview:self.line];
    
    LXWS(weakSelf);
    [self.sendBtn addClickBlock:^(UIButton *button) {
        
        if (weakSelf.sendBlock) {
            weakSelf.sendBlock(weakSelf.textView.text);
        }
    }];
}
-(LXTextView *)textView{
    if (!_textView) {
        _textView =[[LXTextView alloc]initWithFrame:CGRectMake(0, 0, self.lx_width - 60, self.lx_height)];
        _textView.font = TEXTFONT;
        _textView.delegate = self;
        _textView.placeholder = @"发表评论:";
    }
    return _textView;
}
-(LxButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn =[LxButton LXButtonWithTitle:@"发送" titleFont:Font(14) Image:nil backgroundImage:nil backgroundColor:[UIColor whiteColor] titleColor:[UIColor hexStringToColor:@"3c3c3c"] frame:CGRectMake(self.lx_width - 60, 0, 60,  self.btnH)];
    }
    return _sendBtn;
}
-(UIView *)line{
    if (!_line) {
        _line =[[UIView alloc]initWithFrame:CGRectMake(0, 5, 1,  self.btnH - 10)];
        _line.backgroundColor =[UIColor hexStringToColor:@"c2c2c2"];
    }
    return _line;
}
@end
