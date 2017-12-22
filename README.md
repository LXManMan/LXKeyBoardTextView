# LXKeyBoardTextView
仿微信多行限制多行输入，一体键盘
![image](https://github.com/liuxinixn/LXKeyBoardTextView/blob/master/%E8%BE%93%E5%85%A5%E6%A1%86.gif)

使用方法：
```
-(LXKeyBoard *)keyboard{
    if (!_keyboard) {
        _keyboard =[[LXKeyBoard alloc]initWithFrame:CGRectZero];
        _keyboard.backgroundColor =[UIColor whiteColor];
        _keyboard.maxLine = 4;
        LXWS(weakSelf);
        
        _keyboard.sendBlock = ^(NSString *text) {
            NSLog(@"%@",text);
            weakSelf.resultLabel.text = text;
            [weakSelf.resultLabel sizeThatFits:CGSizeMake(Device_Width - 40, MAXFLOAT)];
        };
    }
    return _keyboard;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.keyboard.isDisappear = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.keyboard.isDisappear = YES;
}
```
