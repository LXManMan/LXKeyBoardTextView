//
//  LXKeyBoard.h
//  LXKeyBoardTextView
//
//  Created by chenergou on 2017/12/21.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>

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
