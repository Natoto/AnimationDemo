//
//  BubleViewController.h
//  TestAnimation
//
//  Created by zeno on 16/1/6.
//  Copyright © 2016年 peng. All rights reserved.
//

#import <HBKit/HBKit.h>

@interface BubleViewController : HBBaseViewController

@end


@interface BulbView : UIView

@property (nonatomic) CGFloat red, green, blue;
@property (nonatomic) BOOL on;
@property CGContextRef offscreenContext;
@property CGContextRef currentContext;
@property (strong) UIImage* image;
@property (nonatomic, strong) UIColor* color;

-(void)animateFrom:(CGFloat)from to:(CGFloat)to;
-(void)setOn:(BOOL)on animated:(BOOL)animated;
-(void)setColor:(UIColor*)color;
@end