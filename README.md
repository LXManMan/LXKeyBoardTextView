# LXKeyBoardTextView
仿微信多行限制多行输入，一体键盘
![image](https://github.com/liuxinixn/LXKeyBoardTextView/blob/master/%E8%87%AA%E5%AE%9A%E4%B9%89.gif)

支持代码以及XIB.
介绍：
```
typedef void (^SendBlock) (NSString *text);
@interface LXKeyBoard : UIView
/**
 
 需要配置的属性（也可不传）
 
 */
@property(nonatomic,assign)BOOL isDisappear;//是否即将消失。
@property(nonatomic,assign)int maxLine;//设置最大行数
@property(nonatomic,assign)CGFloat topOrBottomEdge;//上下间距
@property(nonatomic,strong)UIFont *font;//设置字体大小(决定输入框的初始高度)


//设置好属性之后开始布局
-(void)beginUpdateUI;


//回调
@property(nonatomic,copy)SendBlock sendBlock;
@end

```
使用方法：
```
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.keyboard.isDisappear = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.keyboard.isDisappear = YES;
}
```
