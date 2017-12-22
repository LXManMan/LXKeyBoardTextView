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
@property(nonatomic,assign)BOOL isDisappear;//是否即将消失。
@property(nonatomic,assign)int maxLine;
@property(nonatomic,copy)SendBlock sendBlock;
@end
