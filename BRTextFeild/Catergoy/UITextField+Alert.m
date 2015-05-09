//
//  UITextField+Alert.m
//  BRTextFeild
//
//  Created by gitBurning on 15/5/9.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "UITextField+Alert.h"
#import <objc/runtime.h>
#define kRightTag 10
#define kShakeKey @"shake100"

static char blockKey = 'b';
static char isRemoberKey = 'w';
static char beforeImageKey ='m';
static char leftSelectImageKey ='s';
static char isPasswodKey  ='p';
@implementation UITextField (Alert)
-(void)showWrongAnnamtionWithImage:(UIImage *)image andIsPassword:(BOOL)isPasswod{
    
    
    [self resignFirstResponder];
    if (image) {
        UIView * view=self.rightView;
        UIImageView * imageView=(UIImageView*)[view viewWithTag:10];
        if (imageView) {
            imageView.image=image;
        }
        else{
            [self setImageWithIsLeft:NO withDefalutImage:image withSelectdImage:nil andIsPassword:isPasswod];
        }
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    animation.delegate=self;
    /**
     *  把动画设置 标记，多个动画 需要 定位到 具体 某一个 动画
     */
    [animation setValue:kShakeKey forKey:kShakeKey];
    
    [self.layer addAnimation:animation forKey:@"shake"];
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSString * name=[anim valueForKey:kShakeKey];
    if ([name isEqualToString:kShakeKey]) {
        /**
         *  延迟 0.5s 消失
         *
         *  @param errorDelayDissmiss: <#errorDelayDissmiss: description#>
         *
         *  @return <#return value description#>
         */
        [self performSelector:@selector(errorDelayDissmiss:) withObject:nil afterDelay:0.5];
    }
}
-(void)errorDelayDissmiss:(id)sender{
    UIView * view=self.rightView;
    UIImageView * imageView=(UIImageView*)[view viewWithTag:kRightTag];
    if ([imageView.image isEqual:self.beforeImage]) {
        
        self.rightView=nil;
    }
    else{
        imageView.image=self.beforeImage;
    }
}


-(void)addLeftImageAlterWithImage:(UIImage *)image andIsPassword:(BOOL)password{
    
    [self setImageWithIsLeft:YES withDefalutImage:image withSelectdImage:nil andIsPassword:password];
}
-(void)addRightImageWithDefalutImage:(UIImage *)defalutImage withSelectdImage:(UIImage *)selected andIsPassword:(BOOL)password{
    
    [self setImageWithIsLeft:NO withDefalutImage:defalutImage withSelectdImage:selected andIsPassword:password];
}


-(void)setImageWithIsLeft:(BOOL)isLeft withDefalutImage:(UIImage *)defalutImage withSelectdImage:(UIImage *)selected andIsPassword:(BOOL)password
{
    UIView *leftAccountView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30, 30.f)];
    UIImageView *leftAccountImage = [[UIImageView alloc] initWithImage:defalutImage];
    [leftAccountView addSubview:leftAccountImage];
    leftAccountView.backgroundColor = [UIColor clearColor];
    leftAccountImage.contentMode=UIViewContentModeScaleAspectFit;
    leftAccountImage.tag=kRightTag;
    
    //设置图片
    
    if (isLeft) {
        leftAccountImage.frame = CGRectMake(5.0f, 7.0f, 28, 16.0f);
        
        self.leftView = leftAccountView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    else{
        if (password) {
            self.secureTextEntry=!self.isShowPassword;

        }
        
        leftAccountImage.frame = CGRectMake(0.0f, 7.0f, 28, 16.0f);
        
        self.rightView = leftAccountView;
        self.rightViewMode = UITextFieldViewModeAlways;
        
        self.beforeImage=defalutImage;
    }
    
    if (!isLeft && selected) {
        
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPassword:)];
        [leftAccountView addGestureRecognizer:tap];
    }
    
    
    leftAccountView=nil;
    leftAccountImage=nil;
    
    
}

-(void)tapPassword:(UITapGestureRecognizer*)tap{
    
    //void(^blcok1)(UIImageView*image)=self.block;
    UIView * view=tap.view;
    UIImageView * imageView=(UIImageView*)[view viewWithTag:10];
    self.isShowPassword=!self.isShowPassword;
    
    if (self.isShowPassword) {
        imageView.image=[UIImage imageNamed:@"icon-显示密码-02"];
        
    }
    else{
        imageView.image=[UIImage imageNamed:@"icon-显示密码-01"];
        
    }
    
    self.secureTextEntry=!self.isShowPassword;
    
    if (self.leftImageSelectd) {
        self.leftImageSelectd(self,nil);
    }
}



#pragma mark---扩展的属性
-(leftImageSelectdBlock)leftImageSelectd
{
    return objc_getAssociatedObject(self, &blockKey);
    
}
-(void)setLeftImageSelectd:(leftImageSelectdBlock)leftImageSelectd{
    objc_setAssociatedObject(self, &blockKey, leftImageSelectd, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}



-(BOOL)isShowPassword{
    NSNumber * number=objc_getAssociatedObject(self, &isRemoberKey);
    return number.boolValue;
}
-(void)setIsShowPassword:(BOOL)isShowPassword{
    objc_setAssociatedObject(self, &isRemoberKey, @(isShowPassword), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}
-(BOOL)isPassword{
    NSNumber * number=objc_getAssociatedObject(self, &isPasswodKey);
    return number.boolValue;
}
-(void)setIsPassword:(BOOL)isPassword{
    objc_setAssociatedObject(self, &isPasswodKey, @(isPassword), OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(UIImage *)beforeImage{
    return objc_getAssociatedObject(self, &beforeImageKey);
}
-(void)setBeforeImage:(UIImage *)beforeImage{
    objc_setAssociatedObject(self, &beforeImageKey, beforeImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}
-(UIImage *)selectedImage{
    return objc_getAssociatedObject(self, &leftSelectImageKey);
    
}
-(void)setSelectedImage:(UIImage *)selectedImage{
    objc_setAssociatedObject(self, &leftSelectImageKey, selectedImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

@end
