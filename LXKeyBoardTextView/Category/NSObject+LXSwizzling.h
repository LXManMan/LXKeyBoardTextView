//
//  NSObject+LXSwizzling.h
//  RunttimeLearn
//
//  Created by zhongzhi on 2017/7/27.
//  Copyright © 2017年 漫漫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (LXSwizzling)
+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector
                         bySwizzledSelector:(SEL)swizzledSelector;
@end
