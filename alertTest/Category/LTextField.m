//
//  LTextField.m
//  alphain
//
//  Created by 李震 on 16/9/1.
//  Copyright © 2016年 afcatstar. All rights reserved.
//

#import "LTextField.h"

@implementation LTextField


- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    
    iconRect.origin.x += 10;
    
    return iconRect;
    
}

//  重写占位符的x值

//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    
//    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
//    
//    placeholderRect.origin.x += 1;
//    
//    return placeholderRect;
//    
//}

//  重写文字输入时的X值

//- (CGRect)editingRectForBounds:(CGRect)bounds{
//    
//    CGRect editingRect = [super editingRectForBounds:bounds];
//    
//    editingRect.origin.x += 20;
//    
//    return editingRect;
//    
//}

//  重写文字显示时的X值

//- (CGRect)textRectForBounds:(CGRect)bounds{
//    
//    CGRect textRect = [super editingRectForBounds:bounds];
//    
//    textRect.origin.x += 20;
//    
//    return textRect;
//    
//}

//@end

//四、这里有一个坑：就是当你同时重写这三个方法时，同时设置他们X的偏移量时会发现运行结果如下图。

//  重写占位符的X值

//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    
//    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
//    
//    placeholderRect.origin.x += 80;
//    
//    return placeholderRect;
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
