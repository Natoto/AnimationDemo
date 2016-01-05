//
//  UIButton+PENG.m
//  PENG
//
//  Created by 跑酷 on 15/6/8.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import "UIButton+PENG.h"
//#import "UIImage+HBExtension.h"
@implementation UIButton(PENG)

+ (UIButton *)CreateButtonWithFrame:(CGRect)frame andTxt:(NSString *)TXT txtcolor:(UIColor *)color tag:(NSInteger)tag target:(id)target action:(SEL)action
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] initWithFrame:frame];
    [button setTitle:TXT forState:UIControlStateNormal];
    button.frame=frame;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    return button;
}
+ (UIButton *)CreateButtonWithFrame:(CGRect)frame andTxt:(NSString *)TXT txtcolor:(UIColor *)color
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] initWithFrame:frame];
    [button setTitle:TXT forState:UIControlStateNormal];
    button.frame=frame;
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)CreateButtonWithFrame:(CGRect)frame andTxt:(NSString *)TXT
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] initWithFrame:frame];
    [button setTitle:TXT forState:UIControlStateNormal];
    button.frame=frame;
    button.showsTouchWhenHighlighted = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)CreateButtonWithFrame:(CGRect)frame andTxt:(NSString *)TXT andImage:(UIImage *)image
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] initWithFrame:frame];
    [button setTitle:TXT forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.frame=frame;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)CreateButtonWithFrame:(CGRect)frame
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    return button;
}

+ (UIButton *)CreateButtonWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.frame=frame;
    return button;
}

+ (UIButton *)CreateButtonWithFrame:(CGRect)frame andimage:(NSString *)imagename
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] initWithFrame:frame];
    UIImage * image=[UIImage imageNamed:imagename];
    [button setImage:image forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.frame=frame;
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)CreateButtonWithFrame:(CGRect)frame andimage:(NSString *)imagename selectImage:(NSString *)selectimage
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom]; //[[UIButton alloc] initWithFrame:frame];
    UIImage * image=[UIImage imageNamed:imagename];
    [button setImage:image forState:UIControlStateNormal];
    image = [UIImage imageNamed:selectimage];
    [button setImage:image forState:UIControlStateSelected];
    [button setImage:image forState:UIControlStateHighlighted];
    button.frame=frame;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}


+ (UIButton *)CreateButtonWithFrame:(CGRect)frame
                             andTxt:(NSString *)txt
                         andTxtSize:(NSInteger)txtsize
                           andImage:(UIImage *)image
                        andTXTColor:(UIColor *)txtcolor
                             target:(id)target
                           selector:(SEL)selector
                          superview:(UIView *)superview
                                tag:(NSInteger)tag
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    if (txt && !image) {
        button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    }
    if (txt) {
        [button setTitle:txt forState:UIControlStateNormal];
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (txtcolor) {
        [button setTitleColor:txtcolor forState:UIControlStateNormal];
    }
    if (target && selector) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    if (txtsize) {
        button.titleLabel.font = [UIFont systemFontOfSize:txtsize];
    }
    if (superview) {
        [superview addSubview:button];
    }
    button.tag = tag;
    button.frame=frame;
    return button;
}
#pragma mark 下划线
-(void)setUnderlineStyleSingle:(NSString *)text
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [self setAttributedTitle:str forState:UIControlStateNormal];
}
#pragma mark - 生成背景图
-(void)setBackgroundImage:(UIColor *)backgroundColor
{
    [self setBackgroundImage:[UIButton buttonImageFromColor:backgroundColor frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateNormal];
}

-(void)setSelectBackgroundImage:(UIColor *)backgroundColor
{
    [self setBackgroundImage:[UIButton buttonImageFromColor:backgroundColor frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateSelected];
}
-(void)setDisableBackgroundImage:(UIColor *)backgroundColor
{
    [self setBackgroundImage:[UIButton buttonImageFromColor:backgroundColor frame:CGRectMake(0, 0, 1, 1)] forState:UIControlStateDisabled];
}
#pragma mark -
-(void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)setSelectedTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateSelected];
}
-(void)setFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

-(void)setlayercolor:(UIColor *)color
{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.5;
}

-(void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

-(void)setTitleSelectedColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
}

/**
 * 通过颜色生成一种纯色的图片
 */
+(UIImage *)buttonImageFromColor:(UIColor *)color frame:(CGRect)frame
{
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
