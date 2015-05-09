//
//  ViewController.m
//  BRTextFeild
//
//  Created by gitBurning on 15/5/9.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+Alert.h"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.password setImageWithIsLeft:NO withDefalutImage:[UIImage imageNamed:@"icon-显示密码-01"] withSelectdImage:[UIImage imageNamed:@"icon-显示密码-02"] andIsPassword:YES];
    
    self.password.leftImageSelectd=^(UITextField* test,id other){
        
        NSLog(@"-----");
    };

    [self.password addLeftImageAlterWithImage:[UIImage imageNamed:@"icon-显示密码-02"] andIsPassword:YES];
    // Do any additional setup after loading the view, typically from a nib.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (textField.text.length+string.length>5) {
        [textField showWrongAnnamtionWithImage:[UIImage imageNamed:@"icon-提示"] andIsPassword:NO];
        return NO;
    }
    else
        return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
