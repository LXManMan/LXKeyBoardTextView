//
//  UILabel+LXVerticalStyle.m
//  UIlable字体居上
//
//  Created by chenergou on 2017/11/18.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import "UILabel+LXVerticalStyle.h"
#import "NSObject+LXSwizzling.h"
static NSString *style = @"verticalStyle";
@implementation UILabel (LXVerticalStyle)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class =   objc_getClass("UILabel");
        [class methodSwizzlingWithOriginalSelector:@selector(textRectForBounds:limitedToNumberOfLines:) bySwizzledSelector:@selector(LXTextRectForBounds:limitedToNumberOfLines:) ];
        
          [class methodSwizzlingWithOriginalSelector:@selector(drawTextInRect:) bySwizzledSelector:@selector(LXDrawTextInRect:) ];
        
    });
}
-(void)setVerticalStyle:(LXVerticalAlignment)verticalStyle{
    
    objc_setAssociatedObject(self, &style, @(verticalStyle), OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsDisplay];
}
-(LXVerticalAlignment)verticalStyle{
   id value =  objc_getAssociatedObject(self, &style);
    return [value intValue];
}

-(CGRect)LXTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect textRect = [self LXTextRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalStyle) {
        case LXVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case LXVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case LXVerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)LXDrawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [self LXDrawTextInRect:actualRect];
}


@end
