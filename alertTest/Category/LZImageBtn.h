//
//  LZImageBtn.h
//  CreateButton
//
//  Created by chanyezhenghe on 16/4/28.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

typedef NS_ENUM(NSInteger,LZImageStyle) {
    //图片在左侧
    LZImageStyleLeft = 0,
    //图片在右侧
    LZImageStyleRight = 1,
    //图片在上侧
    LZImageStyleTop = 2,
//    //图片在底部
//    LZImageStyleBottom = 3,
};

@class LZImageBtn;

//myBlock 可以看做一个类,也可以看做指向一堆代码块的指针
typedef void (^myBtnBlock)(LZImageBtn * button);


@interface LZImageBtn : UIView

//定义一个具体的block ,可以理解为一个对象,必须用copy
@property (nonatomic,copy)myBtnBlock tempBlock;

- (instancetype)initWithImageStyle:(LZImageStyle)imageStyle andTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font andImage:(NSString *)image andBlock:(myBtnBlock)block;






@end
