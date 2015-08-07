//
//  UIView+RYF.h
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RYF)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
@end
