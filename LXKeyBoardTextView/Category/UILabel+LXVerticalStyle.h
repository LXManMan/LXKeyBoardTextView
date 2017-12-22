//
//  UILabel+LXVerticalStyle.h
//  UIlable字体居上
//
//  Created by chenergou on 2017/11/18.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    
     LXVerticalAlignmentMiddle = 0, // default
    LXVerticalAlignmentTop,
    LXVerticalAlignmentBottom,
} LXVerticalAlignment;
@interface UILabel (LXVerticalStyle)
@property(nonatomic,assign)LXVerticalAlignment verticalStyle;
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
//- (void)layoutLabelWithStyle:(LXVerticalAlignment)style;

@end
