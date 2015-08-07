//
//  PassPayMentView.h
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#define iphone5  ([UIScreen mainScreen].bounds.size.height == 568)
#define iphone6  ([UIScreen mainScreen].bounds.size.height == 667)
#define iphone6Plus  ([UIScreen mainScreen].bounds.size.height == 736)
#define iphone4  ([UIScreen mainScreen].bounds.size.height == 480)
#define ipadMini2  ([UIScreen mainScreen].bounds.size.height == 1024)

#import <UIKit/UIKit.h>

@class PassPayMentView;

@protocol PassPayMentViewDelegate <NSObject>

@optional

- (NSString *)finish:(NSString *)pwd;
//代理方法:取消
- (void)passPayMentView:(PassPayMentView *)passPatMentView cancelBtnClick:(UIButton *)cancleBtnClick;

@end

@interface PassPayMentView : UIView

/**  输入框*/
@property (nonatomic, strong) UITextField *responsder;

@property (nonatomic, weak) id<PassPayMentViewDelegate>delegate;

@property (nonatomic,copy) void (^finish) (NSString *passWord);

//构造方法
+ (instancetype)initView;

//显示出来
- (void)showInView:(UIView *)view;

//隐藏键盘
- (void)hideKeyBoard;

@end
