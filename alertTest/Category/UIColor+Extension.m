//
//  UIColor+Extension.m
//  alphain
//
//  Created by 李震 on 16/8/12.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

RGBA RGBAFromUIColor(UIColor *color)
{
    return RGBAFromCGColor(color.CGColor);
}

RGBA RGBAFromCGColor(CGColorRef color)
{
    RGBA rgba;
    
    CGColorSpaceRef color_space = CGColorGetColorSpace(color);
    CGColorSpaceModel color_space_model = CGColorSpaceGetModel(color_space);
    const CGFloat *color_components = CGColorGetComponents(color);
    size_t color_component_count = CGColorGetNumberOfComponents(color);
    
    switch (color_space_model)
    {
        case kCGColorSpaceModelMonochrome:
        {
            assert(color_component_count == 2);
            rgba = (RGBA)
            {
                .r = color_components[0],
                .g = color_components[0],
                .b = color_components[0],
                .a = color_components[1]
            };
            break;
        }
            
        case kCGColorSpaceModelRGB:
        {
            assert(color_component_count == 4);
            rgba = (RGBA)
            {
                .r = color_components[0],
                .g = color_components[1],
                .b = color_components[2],
                .a = color_components[3]
            };
            break;
        }
            
        default:
        {
            rgba = (RGBA) { 0, 0, 0, 0 };
            break;
        }
    }
    
    return rgba;
}

@end
