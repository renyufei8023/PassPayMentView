//
//  ViewController.m
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import "ViewController.h"
#import "PassPayMentView.h"

@interface ViewController ()<PassPayMentViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) PassPayMentView *passView;
@property (nonatomic, copy) NSString *pwd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pwd = @"123456";
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)pwdAction:(id)sender {
    [self text];
}

- (void)text
{
    __block ViewController *blockSelf = self;
    self.passView = [PassPayMentView initView];
    self.passView.delegate = self;
    [self.passView showInView:self.view.window];
    self.passView.finish = ^(NSString *pwd){
        NSLog(@"  passWord %@ ",pwd);
        
        [blockSelf.passView hideKeyBoard];
        
        if ([pwd isEqualToString:blockSelf.pwd]) {
            NSLog(@"密码成功");
            
            return ;
        }else{
            
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"支付密码错误" message:nil delegate:blockSelf cancelButtonTitle:@"重试" otherButtonTitles:@"忘记密码", nil];
            [al show];
            NSLog(@"密码错误");
        }

    };
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self text];
        
        NSLog(@" buttonIndex 重试");
    }else if (buttonIndex == 1)
    {
        //        [self.zctView hidenKeyboard];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIViewController *vc = [[UIViewController alloc]init];
            vc.view.backgroundColor = [UIColor redColor];
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@" buttonIndex 忘了密码");
        });
    }
}

- (void)passPayMentView:(PassPayMentView *)passPatMentView cancelBtnClick:(UIButton *)cancleBtnClick
{
    NSLog(@"取消了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
