//
//  AddFriendAlertShow.h
//  alertTest
//
//  Created by 李震 on 2016/12/4.
//  Copyright © 2016年 李震. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(NSString * inputText);

@interface AddFriendAlertShow : UIView


+ (AddFriendAlertShow *)showAlertView;

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message AndConfirmTitle:(NSString *)btnTitle AndConfirmAction:(ClickBlock)confirmBlock WithText:(NSString *)text;

@end
