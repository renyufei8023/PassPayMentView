//
//  PassPayMentView.m
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import "PassPayMentView.h"
#import "PassPayMentInputView.h"

@interface PassPayMentView ()<UITextFieldDelegate,PassPayMentViewDelegate,passPayMentInputDelegate>
//蒙版
@property (nonatomic, strong) UIButton *cover;
//输入框
@property (nonatomic, strong) PassPayMentInputView *inputView;
//返回d的密码
@property (nonatomic, copy) NSString *pwd;

@end
@implementation PassPayMentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCover];
        [self setupInputView];
        [self setupResponsder];
    }
    return self;
}

- (void)setupCover
{
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cover];
    self.cover = cover;
    [self.cover setBackgroundColor:[UIColor blackColor]];
    self.cover.alpha = 0.4;
}

- (void)setupInputView
{
    PassPayMentInputView *inputView = [[PassPayMentInputView alloc]init];
    inputView.delegate = self;
    [self addSubview:inputView];
    self.inputView = inputView;
    
    //点击取消的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelText) name:RYFPassInputViewCancleButtonClick object:nil];
}

- (void)passInputView:(PassPayMentInputView *)passInputView cancleBtnClick:(UIButton *)cancleBtn
{
    if ([self.delegate respondsToSelector:@selector(passInputView:cancleBtnClick:)]) {
        [self.delegate passPayMentView:self cancelBtnClick:cancleBtn];
    }
}

//在那个inputview的基础上面添加一个UITxtfield  不然不会弹出键盘
- (void)setupResponsder
{
    UITextField *responsder = [[UITextField alloc]init];
    responsder.delegate = self;
    responsder.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:responsder];
    self.responsder = responsder;
}

static NSString *tempStr;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //把输入的文字拼接起来
    if (!tempStr) {
        tempStr = string;
    }else{
        tempStr = [NSString stringWithFormat:@"%@%@",tempStr,string];
    }
    
    //属于空的时候相当于删除操作
    if ([string isEqualToString:@""]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:RYFKeyboardDeleteButtonClick object:self];
        if (tempStr.length > 0) {
            //删除最后一个元素
            NSString *tempStr2 = [tempStr substringToIndex:[tempStr length ] - 1];
            tempStr = tempStr2;
        }
    }else{
        if (tempStr.length == 6) {
            [self hideKeyBoard:^(BOOL finish) {
                [self removeFromSuperview];
                [self hideKeyBoard:nil];
            }];
            
            //代理回调
            if ([self.delegate respondsToSelector:@selector(finish:)]) {
                [self.delegate finish:tempStr];
            }
            //block回调
            if (self.finish) {
                self.finish(tempStr);
            }
            tempStr = nil;
            
        }
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[RYFKeyboardBumberKey] = string;
        [[NSNotificationCenter defaultCenter]postNotificationName:RYFKeyboardNumberButtonClick object:self userInfo:userInfo];
    }
    return YES;
}

- (void)cancelText
{
    [self hideKeyBoard:^(BOOL finish) {
        self.inputView.hidden = YES;
        [self removeFromSuperview];
        [self hideKeyBoard:nil];
        [self.inputView setNeedsDisplay];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

- (void)showKeyboard
{
    CGFloat marginTop;
    if (iphone4) {
        marginTop = 42;
    } else if (iphone5) {
        marginTop = 100;
    } else if (iphone6) {
        marginTop = 120;
    } else {
        marginTop = 140;
    }
    
    [self.responsder becomeFirstResponder];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.inputView.transform = CGAffineTransformMakeTranslation(0, marginTop - self.inputView.y);
    } completion:^(BOOL finished) {
    }];

}

#pragma mark - 关闭键盘
- (void)hideKeyBoard:(void (^)(BOOL finish))completion
{
    [self.responsder endEditing:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.inputView.transform = CGAffineTransformIdentity;
    } completion:completion];
}

+ (instancetype)initView
{
    return [[self alloc]init];
}

- (void)hideKeyBoard{
    [self removeFromSuperview];
    [self hideKeyBoard:nil];
}


- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    self.inputView.height = 180;
    self.inputView.y = (self.height - self.inputView.height) * 0.5;
    self.inputView.width = [UIScreen mainScreen].bounds.size.width * 0.94375;
    self.inputView.x = ([UIScreen mainScreen].bounds.size.width - self.inputView.width) * 0.5;
    
    [self showKeyboard];
}
@end
