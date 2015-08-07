//
//  PassPayMentInputView.m
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//
// 屏幕bounds
#define ScreenBounds [UIScreen mainScreen].bounds
// 屏幕的size
#define ScreenSize [UIScreen mainScreen].bounds.size
// 屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define PassPayMentInputViewNumCount 6

typedef enum {
    PassPayMentInputViewButtonTypeWithCancle = 10000,
    PassPayMentInputViewButtonTypeWithOk = 20000,
}PassPayMentInputViewButtonType;

#import "PassPayMentInputView.h"
#import "NSString+RYF.h"

@interface PassPayMentInputView ()
@property (nonatomic, strong) NSMutableArray *nums;
@property (nonatomic, strong) UIButton *cancleBtn;

@end
@implementation PassPayMentInputView

- (NSMutableArray *)nums
{
    if (_nums == nil) {
        _nums = [NSMutableArray array];
    }
    return _nums;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        //注册键盘通知
        [self setupKeyboardNote];
        //添加子控件
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    /** 取消按钮 */
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:cancleBtn];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"icon.bundle/zhifu-close"] forState:UIControlStateNormal];
    //    [cancleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.cancleBtn = cancleBtn;
    [self.cancleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn.tag = PassPayMentInputViewButtonTypeWithCancle;
}

- (void)setupKeyboardNote
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delete) name:RYFKeyboardDeleteButtonClick object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(number:) name:RYFKeyboardNumberButtonClick object:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _cancleBtn.width = 15;
    _cancleBtn.height = 15;
    _cancleBtn.x = 10;
    _cancleBtn.y = 10;
}

//删除
- (void)delete
{
    [self.nums removeLastObject];
    
    //刷新界面
    [self setNeedsDisplay];
}

//数字
- (void)number:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    NSString *numObj = userInfo[RYFKeyboardBumberKey];
    if (numObj.length >= PassPayMentInputViewNumCount) return;
    [self.nums addObject:numObj];
    [self setNeedsDisplay];
}

- (void)btnClick:(UIButton *)btn
{
    
    if (btn.tag == PassPayMentInputViewButtonTypeWithCancle) {
        if ([self.delegate respondsToSelector:@selector(passInputView:cancleBtnClick:)]) {
            [self.delegate passInputView:self cancleBtnClick:btn];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:RYFPassInputViewCancleButtonClick object:self];
    }
}

- (void)drawRect:(CGRect)rect
{
    //北京
    UIImage *bgImg = [UIImage imageNamed:@"icon.bundle/pssword_bg"];
    //密码输入框
    UIImage *textField = [UIImage imageNamed:@"icon.bundle/password_in"];
    
    [bgImg drawInRect:rect];
    
    CGFloat x = ScreenWidth * 0.096875 * 0.5;
    CGFloat y = ScreenWidth * 0.40625 * 0.5;
    CGFloat w = ScreenWidth * 0.846875;
    CGFloat h = ScreenWidth * 0.121875;
    
    [textField drawInRect:CGRectMake(x, y, w, h)];
    
    //标题
    NSString *title = @"请输入支付密码";
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:ScreenWidth * 0.053125] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat titleW = size.width;
    CGFloat titleH = size.height;
    CGFloat titleX = (self.width - titleW) * 0.5;
    CGFloat titleY = ScreenWidth * 0.03125;
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:ScreenWidth * 0.053125];
    attr[NSForegroundColorAttributeName] = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [title drawInRect:titleRect withAttributes:attr];

    //输入密码时候的黑色圆点
    UIImage *pointImage = [UIImage imageNamed:@"icon.bundle/yuan"];
    CGFloat pointW = ScreenWidth * 0.05;
    CGFloat pointH = pointW;
    CGFloat pointY = ScreenWidth * 0.24;
    CGFloat pointX;
    CGFloat margin = ScreenWidth * 0.0484375;
    CGFloat padding = ScreenWidth * 0.045578125;
    
    for (int i = 0; i < self.nums.count; i++) {
        pointX = margin + padding + i * (pointW + 2 * padding);
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }
    
    NSString *promptText = @"提示:此功能平台将收佣金,慎用";
    CGSize sizeprompt = [promptText sizeWithFont:[UIFont systemFontOfSize:ScreenWidth * 0.053125] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat promptW = sizeprompt.width;
    CGFloat promptH = sizeprompt.height;
    CGFloat promptX = (self.width - promptW) * 0.5;
    CGFloat promptY = ScreenWidth * 13 * 0.03125;
    CGRect promptRect = CGRectMake(promptX, promptY, promptW, promptH);
    
    NSMutableDictionary *propmtAttr = [NSMutableDictionary dictionary];
    propmtAttr[NSFontAttributeName] = [UIFont systemFontOfSize:ScreenWidth * 0.053125];
    propmtAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:0.5];
    [promptText drawInRect:promptRect withAttributes:propmtAttr];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
