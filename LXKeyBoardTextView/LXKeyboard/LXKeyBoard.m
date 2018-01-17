//
//  LXKeyBoard.m
//  LXKeyBoardTextView
//
//  Created by chenergou on 2017/12/21.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "LXKeyBoard.h"
#import "LXTextView.h"
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

-(void)awakeFromNib{
    [super awakeFromNib];
    
     [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.layer.borderWidth = 1;
    self.layer.borderColor =[UIColor hexStringToColor:@"A5A5A5"].CGColor;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];;
    
    //设置默认属性
    self.topOrBottomEdge = 8;
    self.font = Font(18);
    self.maxLine = 3;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =  [super initWithFrame:frame];
    
    
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor =[UIColor hexStringToColor:@"A5A5A5"].CGColor;
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
        //设置默认属性
        self.topOrBottomEdge = 8;
        self.font = Font(18);
        self.maxLine = 3;
        
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@",self.class);
}


-(void)beginUpdateUI{
    
    //初始化高度 textView的lineHeight + 2 * 上下间距
    CGFloat orignTextH  = ceil (self.font.lineHeight) + 2 * self.topOrBottomEdge;
    
    
    self.frame =  CGRectMake(0, Device_Height - orignTextH, Device_Width, orignTextH);
    
    
    self.btnH = self.lx_height;
    
    
    [self setup];
    
  
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
-(void)textViewDidChange:(UITextView *)textView{
    
    CGFloat contentSizeH = self.textView.contentSize.height;
    CGFloat lineH = self.textView.font.lineHeight;
    
    CGFloat maxHeight = ceil(lineH * self.maxLine + textView.textContainerInset.top + textView.textContainerInset.bottom);
    if (contentSizeH <= maxHeight) {
        self.textView.lx_height = contentSizeH;
    }else{
        self.textView.lx_height = maxHeight;
    }
    
    [textView scrollRangeToVisible:NSMakeRange(textView.selectedRange.location, 1)];
  
    
    CGFloat totalH = ceil(self.textView.lx_height) + 2 * self.topOrBottomEdge;
    self.frame = CGRectMake(0, keyboardY - totalH, self.lx_width, totalH);
   
  
    self.sendBtn.lx_height = totalH;
    self.line.lx_height = totalH - 10;
    
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
#pragma mark---setter---
-(void)setTopOrBottomEdge:(CGFloat)topOrBottomEdge{
    _topOrBottomEdge  = topOrBottomEdge;
    
    if (!_topOrBottomEdge) {
        topOrBottomEdge = 10;
    }
}
-(void)setMaxLine:(int)maxLine{
    _maxLine = maxLine;
    
    if (!_maxLine || _maxLine <=0) {
        _maxLine = 3;
    }
    
}
-(void)setFont:(UIFont *)font{
    _font = font;
    if (!font) {
        _font = Font(16);
    }
    
    
}
-(void)setIsDisappear:(BOOL)isDisappear{
    _isDisappear = isDisappear;
}


#pragma mark---getter---
-(LXTextView *)textView{
    if (!_textView) {
        _textView =[[LXTextView alloc]initWithFrame:CGRectMake(0, self.topOrBottomEdge, self.lx_width - 60, ceil(self.font.lineHeight))];
        _textView.font = self.font;
        _textView.delegate = self;
        _textView.layoutManager.allowsNonContiguousLayout = NO;
         _textView.enablesReturnKeyAutomatically = YES;
        _textView.scrollsToTop = NO;
        _textView.textContainerInset = UIEdgeInsetsZero; //关闭textview的默认间距属性
        _textView.textContainer.lineFragmentPadding = 0;
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
