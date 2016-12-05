//
//  LZImageBtn.m
//  CreateButton
//
//  Created by chanyezhenghe on 16/4/28.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "LZImageBtn.h"

@implementation LZImageBtn

- (instancetype)initWithImageStyle:(LZImageStyle)imageStyle andTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font andImage:(NSString *)image andBlock:(myBtnBlock)block{
    self = [super init];
    if (self) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        UILabel * label = [[UILabel alloc] init];
        label.text = title;
        if (color) {
            label.textColor = color;
        }else{
            label.textColor = [UIColor blackColor];
        }
        
        if (font) {
            label.font = font;
        }else{
            label.font = [UIFont systemFontOfSize:15.0];
        }
        
        [self addSubview:imageView];
        [self addSubview:label];
        
        if (imageStyle == LZImageStyleLeft) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(10);
                make.top.equalTo(self).offset(11);
                make.bottom.equalTo(self).offset(-11);
                make.right.equalTo(label.mas_left).offset(-8);
            }];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.height.mas_equalTo(self);
                make.right.equalTo(self).offset(-10);
                
            }];
            
            
            
        }else if (imageStyle == LZImageStyleRight){
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.height.mas_equalTo(self);
                make.left.equalTo(self).offset(10);
                make.right.equalTo(imageView.mas_left).offset(-3);
            }];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(20);
                make.top.equalTo(self).offset(12);
                make.bottom.equalTo(self).offset(-12);
                make.right.equalTo(self).offset(-8);
            }];
            
        }else if (imageStyle == LZImageStyleTop){
            
        }
        
        self.tempBlock = block;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    _tempBlock(self);
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
