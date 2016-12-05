//
//  RGBColor.h
//  alphain
//
//  Created by 李震 on 16/8/29.
//  Copyright © 2016年 afcatstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RGBColor : NSObject

//颜色
+(UIColor *) colorWithHexString: (NSString *)stringToConvert;

@end
