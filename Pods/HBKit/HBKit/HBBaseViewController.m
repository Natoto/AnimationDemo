//
//  BaseViewController.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "HBBaseViewController.h"
#import "UIButton+PENG.h"

#define HB_UIColorWithRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@implementation BackGroundView
-(void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self.image drawInRect:CGRectMake(0, -10, rect.size.width, rect.size.height + 10)];
    // Drawing code
}
@end
 
@implementation HBBaseViewController


-(void)setShowBackItem:(BOOL)showBackItem
{
    _showBackItem = showBackItem;
    //TODO:设置返回按钮
    if (_showBackItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(backtoparent:)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
//    REMOVE_HBSIGNAL_OBSERVER(self, @"networkerror", @"HTTPSEngile")
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = HB_UIColorWithRGB(245, 245, 245);
}
-(IBAction)hbNavigationbartitleTap:(id)sender
{
    
}


-(void)setStatusBarStyleDefault:(BOOL)statusBarStyleDefault
{
    _statusBarStyleDefault = statusBarStyleDefault;
    if (self.statusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.useStatusBar) {
        statusbarhidden = [UIApplication sharedApplication].statusBarHidden;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.useStatusBar) {
        if (statusbarhidden != [UIApplication sharedApplication].statusBarHidden) {
            [[UIApplication sharedApplication] setStatusBarHidden:statusbarhidden];
        }
    }
}

-(void)changeFaceStyle:(int)style view:(UIView *)View
{
    
}

-(void)userDefaultBackground
{
    [self changeBackGroundWithBackColor:HB_UIColorWithRGB(14, 113, 196)];
}

-(void)changeBackGroundWithBackImage:(UIImage *)Image
{
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];//
    if (!imageview) {
        imageview = [[UIImageView alloc] initWithImage:Image];
        imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
        [self.view addSubview:imageview];
        imageview.tag = 2222;
        [self.view sendSubviewToBack:imageview];
    }
    imageview.image = Image;
}

-(void)changeBackGroundWithBackColor:(UIColor *)color
{
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];
    if (!imageview) {
        imageview = [[UIImageView alloc] init];
        imageview.tag = 2222;
        [self.view addSubview:imageview];
    }
    imageview.backgroundColor = color;
    imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
    [self.view sendSubviewToBack:imageview];
}

-(void)changeBackGroundWithBackimg:(NSString *)imgname ofType:(NSString *)type
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imgname ofType:type]; 
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView * imageview = (UIImageView *)[self.view viewWithTag:2222];
    if (!imageview) {
        imageview = [[UIImageView alloc] initWithImage:img];
        imageview.tag = 2222;
        [self.view addSubview:imageview];
    }
    imageview.image = img;
    imageview.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 20);
    [self.view sendSubviewToBack:imageview];
}
-(void)changeBackGroundWithBackimg:(NSString *)imgname
{
    [self changeBackGroundWithBackimg:imgname ofType:@"png"];
}


-(void)showhbnavigationbarBackItem:(BOOL)show
{
    if (show) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(backtoparent:)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
//TODO:设置返回键
//    [self.navigationbar setleftBarButtonItemWithImage:[UIImage imageNamed:@"white_back_btn"] target:self selector:@selector(backtoparent:)];
}

-(IBAction)backtoparent:(id)sender
{
    if (self.navigationController.childViewControllers.count >1 && self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark 点击手势
-(void)observeTapgestureWithSuperView:(UIView *)superview target:(id)target sel:(SEL)seletor
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:seletor];
    [superview addGestureRecognizer:tap];
}

-(BackGroundView *)backgroundview
{
    if (!_backgroundview) {
        BackGroundView * backgroundview =  [[BackGroundView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backgroundview = backgroundview;
    }
    return _backgroundview;
}



@end
