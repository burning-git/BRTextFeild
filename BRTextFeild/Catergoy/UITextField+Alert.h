//
//  UITextField+Alert.h
//  BRTextFeild
//
//  Created by gitBurning on 15/5/9.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^leftImageSelectdBlock)(UITextField* textFeild,id other);
@interface UITextField (Alert)
/**
 *  显示错误动画
 *
 *  @param image <#image description#>
 */
-(void)showWrongAnnamtionWithImage:(UIImage*)image andIsPassword:(BOOL)isPasswod;


/**
 *  设置textFeild 图片
 *
 *  @param isLeft       如果 是 no 的时候，并且需要 给 右边增加点击事件，请 给 selected 赋值
 *  @param defalutImage <#defalutImage description#>
 *  @param selecte      <#selecte description#>
 */
-(void)setImageWithIsLeft:(BOOL)isLeft withDefalutImage:(UIImage*)defalutImage withSelectdImage:(UIImage*)selected andIsPassword:(BOOL)password;

/**
 *  增加左边的图片
 *
 *  @param image <#image description#>
 */
-(void)addLeftImageAlterWithImage:(UIImage*)image andIsPassword:(BOOL)password;

/**
 *  增加右边的图片
 *
 *  @param defalutImage <#defalutImage description#>
 *  @param selected     <#selected description#>
 */
-(void)addRightImageWithDefalutImage:(UIImage*)defalutImage withSelectdImage:(UIImage*)selected andIsPassword:(BOOL)password;

/**
 *  是否显示密码
 */
@property(assign,nonatomic) BOOL isShowPassword;
/**
 *  密码的点击事件
 */
@property(assign,nonatomic) leftImageSelectdBlock leftImageSelectd;


/**
 *  当前图片
 */
@property(strong,nonatomic) UIImage * beforeImage;

/**
 *  点中图片
 */
@property(strong,nonatomic) UIImage * selectedImage;

/**
 *  是否是 密码类型
 */
@property(assign,nonatomic) BOOL  isPassword;

@end
