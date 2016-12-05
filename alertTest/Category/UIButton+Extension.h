//
//  UIButton+Extension.h
//  SomeFunction
//
//  Created by 李震 on 16/8/4.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  创建按钮--有文字,有颜色,有字体,有图片,没有背景
 *
 *  @param title      标题
 *  @param titleColor 字体颜色
 *  @param font       字体大小
 *  @param imageName  图片名称
 *  @param target     tatget
 *  @param action     SEL
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/**
 *  创建按钮有文字,有颜色,有字体,有图片,有背景
 *
 *  @param title         标题
 *  @param titleColor    字体颜色
 *  @param font          字体大下
 *  @param imageName     图片名称
 *  @param target        target
 *  @param action        SEL
 *  @param backImageName 背景图片名称
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName target:(id)target action:(SEL)action backImageName:(NSString *)backImageName;

/**
 *  创建按钮有文字,有颜色,有字体
 *
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param font       字体大小
 *  @param target     target
 *  @param action     SEL
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;

/**
 *  创建按钮有文字,有颜色,有字体,有背景
 *
 *  @param title         标题
 *  @param titleColor    标题颜色
 *  @param font          字体大小
 *  @param target        target
 *  @param action        SEL
 *  @param backImageName 背景图片名称
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action backImageName:(NSString *)backImageName;


/**
 *  创建按钮--有文字,有颜色,有字体,有图片,有选中图片,没有背景
 *
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param size       字体大小
 *  @param imageName  图片名称
 *  @param highName   高亮图片名称
 *  @param target     target
 *  @param action     SEL
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat )size imageName:(NSString *)imageName HighlightedImageName:(NSString *)highName target:(id)target action:(SEL)action;

/**
 *  创建按钮--有文字,有颜色,有字体,有图片,有选中图片,有背景
 *
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param size       字体大小
 *  @param imageName  图片名称
 *  @param highName   高亮图片名称
 *  @param target     target
 *  @param action     SEL
 *  @param backImageName 背景图片名称
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(CGFloat )size imageName:(NSString *)imageName HighlightedImageName:(NSString *)highName target:(id)target action:(SEL)action backImageName:(NSString *)backImageName;


@end
