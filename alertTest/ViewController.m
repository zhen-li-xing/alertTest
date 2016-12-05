//
//  ViewController.m
//  alertTest
//
//  Created by 李震 on 2016/12/4.
//  Copyright © 2016年 李震. All rights reserved.
//

#import "ViewController.h"
#import "AddFriendAlertShow.h"
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 80, [UIScreen mainScreen].bounds.size.height / 2 - 22, 160, 44);
    [btn setTitle:@"点击弹出alert" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
//    UITextView * tv = [[UITextView alloc] init];
//    tv.font = [UIFont systemFontOfSize:17.0];
//    tv.backgroundColor = [UIColor yellowColor];
//    CGFloat tvW = [UIScreen mainScreen].bounds.size.width - 100;
//    CGFloat tvX = 50;
//    CGFloat tvY = [UIScreen mainScreen].bounds.size.height / 2  - 100;
//    
//    tv.frame = CGRectMake(tvX, tvY, tvW, 44);
//    tv.delegate = self;
//    [self.view addSubview:tv];
    
}

- (void)textViewDidChange:(UITextView *)textView{

    static CGFloat maxHeight =60.0f;
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
}

- (void)btnClicked:(UIButton *)btn{
    [[AddFriendAlertShow showAlertView] showAlertViewWithTitle:@"您需要发送验证申请等待对方通过啊哈哈" message:nil AndConfirmTitle:@"发送" AndConfirmAction:^(NSString *inputText) {
        NSLog(@"%@",inputText);
    }WithText:@"您需要发送验证申请等待对方通过啊哈哈"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
