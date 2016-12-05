//
//  UIColor+Extension.h
//  alphain
//
//  Created by 李震 on 16/8/12.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
}RGBA;

@interface UIColor (Extension)

/**
 *  获取UIColor对象的RGBA值
 *
 *  @param color UIColor
 *
 *  @return RGBA
 */
RGBA RGBAFromUIColor(UIColor *color);

@end
