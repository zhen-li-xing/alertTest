//
//  AddFriendAlertShow.m
//  alertTest
//
//  Created by 李震 on 2016/12/4.
//  Copyright © 2016年 李震. All rights reserved.
//

#import "AddFriendAlertShow.h"
#import "Category.h"
#import "Masonry.h"

#define LScreen_Bounds [UIScreen mainScreen].bounds
#define LScreen_Height [UIScreen mainScreen].bounds.size.height
#define LScreen_Width [UIScreen mainScreen].bounds.size.width

@interface AddFriendAlertShow ()<UITextViewDelegate>

/** 输入框 */
@property (nonatomic, strong) UITextView * alertTextView;
/** alert的背景视图 */
@property (nonatomic, strong) UIView * alertBackgroundView;
/** 操作视图 */
@property (nonatomic, strong) UIView * operateView;
/** 传来标题的size */
@property (nonatomic, assign) CGSize titleSize;
/** 取消按钮 */
@property (nonatomic,weak)UIButton * cancelBtn;
/** 确认按钮 */
@property (nonatomic,weak)UIButton * confirmBtn;
/** 分割线 */
@property (nonatomic,strong)UIView * segmentationView;
/** 两个按钮间的分割线 */
@property (nonatomic,strong)UIView * lineView;

@property (nonatomic, copy) ClickBlock confirmBlock;

@end

@implementation AddFriendAlertShow

+ (AddFriendAlertShow *)showAlertView
{
    static dispatch_once_t once;
    static AddFriendAlertShow * _alertView = nil;
    dispatch_once(&once, ^{
        if (_alertView == nil) {
            _alertView = [[self alloc] init];
        }
    });
    return _alertView;
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message AndConfirmTitle:(NSString *)btnTitle AndConfirmAction:(ClickBlock)confirmBlock WithText:(NSString *)text
{
    /** 背景 */
    _alertBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LScreen_Width, LScreen_Height)];
    _alertBackgroundView.backgroundColor = [UIColor yellowColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_alertBackgroundView];
    _alertBackgroundView.alpha = 0;
    [UIView animateWithDuration:0.5f animations:^{
        _alertBackgroundView.alpha = 1;
    }];
    /** alert显示的背景视图 */
    _operateView = [[UIView alloc] init];
    _operateView.center = CGPointMake(LScreen_Width/2, LScreen_Height/2);
    _operateView.backgroundColor = [UIColor whiteColor];
    _operateView.layer.cornerRadius = 6;
    _operateView.clipsToBounds = YES;
    [_alertBackgroundView addSubview:_operateView];
    /** 标题 */
    UILabel * titleLabel = [UILabel labelWithTitle:title color:[UIColor blackColor] font:[UIFont systemFontOfSize:16.0]];
    _titleSize = [title sizeWithFont:[UIFont systemFontOfSize:16.0] maxSize:CGSizeMake(LScreen_Width - 96, MAXFLOAT)];
    titleLabel.frame = CGRectMake(32, 15, LScreen_Width - 128, _titleSize.height);
    [_operateView addSubview:titleLabel];
    /** message */
    //暂时无
    /** 输入框 */
    _alertTextView = [[UITextView alloc] init];
    _alertTextView.font = [UIFont systemFontOfSize:15.0];
    _alertTextView.textColor = [UIColor blackColor];
    _alertTextView.layer.borderColor = [[UIColor blackColor] CGColor];
    _alertTextView.layer.borderWidth = 1.0f;
    _alertTextView.delegate = self;
    _alertTextView.text = text;
    CGSize textSize = [_alertTextView sizeThatFits:CGSizeMake(LScreen_Width - 128, MAXFLOAT)];
    _alertTextView.frame = CGRectMake(32, CGRectGetMaxY(titleLabel.frame) + 10, LScreen_Width - 128, textSize.height);
    [_operateView addSubview:_alertTextView];
    /** 取消按钮 */
    UIButton * cancelBtn = [UIButton buttonWithTitle:@"取消" titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0] target:self action:@selector(removeAlertView)];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(_alertTextView.frame) + 10, (LScreen_Width - 64) / 2, 40);
    [_operateView addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    /** 确认按钮 */
    self.confirmBlock = confirmBlock;
    UIButton * confirmBtn = [UIButton buttonWithTitle:btnTitle titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15.0] target:self action:@selector(clickAction:)];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(_alertTextView.frame) + 10, (LScreen_Width - 64) / 2 - 1, 40);
    [_operateView addSubview:confirmBtn];
    _confirmBtn = confirmBtn;
    /** 分割线 */
    _segmentationView = [UIView new];
    _segmentationView.backgroundColor = [UIColor lightGrayColor];
    _segmentationView.frame = CGRectMake(0, CGRectGetMaxY(_alertTextView.frame) + 10, LScreen_Width - 64, 1);
    [_operateView addSubview:_segmentationView];
    /** 两个按钮间的分割线 */
    _lineView = [UIView new];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    _lineView.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(_alertTextView.frame) + 10, 1, 40);
    [_operateView addSubview:_lineView];
    
    _operateView.bounds = CGRectMake(0, 0, LScreen_Width - 64, 75 + _titleSize.height + textSize.height);
}

- (void)clickAction:(UIButton *)sender
{
    if (self.confirmBlock) {
        self.confirmBlock(_alertTextView.text);
    }
    
    [self removeAlertView];
}

#pragma mark - 移除视图
- (void)removeAlertView
{
    if ([_alertTextView isFirstResponder]) {
        [_alertTextView resignFirstResponder];
    }
    //退出
    [UIView animateWithDuration:0.5f animations:^{
        _alertBackgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.alertBackgroundView removeFromSuperview];
        self.alertBackgroundView = nil;
        self.operateView = nil;
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    static CGFloat maxHeight =52.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {
        size.height=frame.size.height;
    }else{
        if (size.height >= maxHeight)
        {
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    _operateView.bounds = CGRectMake(0, 0, LScreen_Width - 64, 75 + _titleSize.height + size.height);
    
    [_cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_operateView.mas_left).offset(0);
        make.bottom.equalTo(_operateView.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo((LScreen_Width - 64) / 2);
    }];
    [_confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_cancelBtn.mas_right).offset(0);
        make.bottom.equalTo(_operateView.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo((LScreen_Width - 64) / 2 - 1);
    }];
    [_segmentationView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_operateView.mas_left).offset(0);
        make.bottom.equalTo(_confirmBtn.mas_top).offset(0);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(LScreen_Width - 64);
    }];
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(1);
        make.left.equalTo(_cancelBtn.mas_right).offset(0);
        make.bottom.equalTo(_operateView.mas_bottom).offset(0);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
