//
//  PassPayMentInputView.h
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+RYF.h"
//取消时候的通知名称
static NSString *RYFPassInputViewCancleButtonClick = @"RYFPassInputViewCancleButtonClick";
//确定按钮的通知名称（暂时没用）
static NSString *RYFPassInputViewOkButtonClick = @"RYFPassInputViewOkButtonClick";
//输入密码删除时候的通知名称
static NSString *RYFKeyboardDeleteButtonClick = @"RYFKeyboardDeleteButtonClick";
//输入密码内容的通知名称
static NSString *RYFKeyboardNumberButtonClick = @"RYFKeyboardNumberButtonClick";
//输入的内容
static NSString *RYFKeyboardBumberKey = @"RYFKeyboardBumberKey";

@class PassPayMentInputView;
@protocol passPayMentInputDelegate <NSObject>

@optional
- (void)passInputView:(PassPayMentInputView *)passInputView cancleBtnClick:(UIButton *)cancleBtn;

@end
@interface PassPayMentInputView : UIView

@property (nonatomic, weak) id<passPayMentInputDelegate>delegate;

@end
