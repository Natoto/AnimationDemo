//
//  GradientLayerViewController.m
//  TestAnimation
//
//  Created by zeno on 16/1/6.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "GradientLayerViewController.h"

@interface GradientLayerViewController ()

@property (strong, nonatomic) CAGradientLayer *m_gradientLayer;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation GradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBackGroundWithBackImage:[UIImage imageNamed:@"elcaptan"]];
//    [self normalgradientLayer];
//    [self testgradientLayer];
    [self testslidetounlock];
    
    self.view.backgroundColor = [UIColor grayColor];
}
//做颜色渐变
-(void)testslidetounlock
{
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
    textLabel.center = self.view.center;
    textLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = @">> 滑动来解锁 >>>";
    [self.view addSubview:textLabel];

    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.backgroundColor = [UIColor grayColor].CGColor;
    gradient.frame = textLabel.bounds;
    UIColor *startColor = [UIColor blackColor];
    UIColor *endColor   = [UIColor clearColor];
    gradient.colors = @[(id)endColor.CGColor,(id)startColor.CGColor, (id)endColor.CGColor];
    gradient.startPoint = CGPointMake(0, 0);//(左，下)
    gradient.endPoint = CGPointMake(1, 0);//(右，下)
//    [textLabel.layer insertSublayer:gradient atIndex:0];
    gradient.locations = @[@.2,@.5,@.8];
    
    textLabel.layer.mask = gradient;
    CABasicAnimation * gradientanimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientanimation.fromValue = @[@0, @0,@0.25];
    gradientanimation.toValue = @[@0.75,@1 ,@1];
    gradientanimation.duration = 2.5;
    gradientanimation.repeatCount = HUGE;
//    gradientanimation.autoreverses = YES;//原路径返回
    [gradient addAnimation:gradientanimation forKey:@"gradientanimation"];//gradient, forKey: nil)
    
}

-(void)normalgradientLayer
{ 
    //    [self changeBackGroundWithBackImage:[UIImage imageNamed:@"elcaptan"]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    
    UIColor *startColor = [UIColor clearColor]; // [UIColor colorWithRed:1.\
    green:149./255.\
    blue:0.\
    alpha:1.];
    UIColor *endColor   = [UIColor purpleColor];//[UIColor colorWithRed:255.\
    green:94./255.\
    blue:58./255.\
    alpha:1.];
    
    gradient.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
    
    /**
     *渐变的起点和终点时吸入到层的
      *坐标空间。开始点对应于第一梯度
      *站，终点到最后的渐变。这两个点是
      *在一个单元中定义的坐标空间，然后将其映射到
      *当绘制图层的边界矩形。 （即，[0,0]是左下
      *层的角落，[1,1]是右上角。）默认值
      *是[.5,0]和[.5,1]分别。两者都是动画。
     
     | 0,1   1,1|
     |          |
     |          |
     | 0,0   1,0|
     */
    
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(0, 1);
    /**
     * NSNumber的一个可选的对象阵列定义每个的位置
      *梯度停止作为在范围[0,1]的值。该值必须是
      *单调递增。如果一个零数组给出的车站
      *假设为均匀分布在[0,1]区间。当呈现，
      *颜色被映射到输出颜色空间是前
      *插值。默认为无。动画。
     */
    //    gradient.locations = @[@(0.5f) ,@(1.f)];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)testgradientLayer {
    
    //初始化imageView
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"elcaptan"]];
//    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
//    imageView.center = self.view.center;
//    [self.view addSubview:imageView];
    
    [self changeBackGroundWithBackImage:[UIImage imageNamed:@"elcaptan"]];
    BackGroundView * imageView = [self.view viewWithTag:2222];
    //初始化渐变层
    self.m_gradientLayer = [CAGradientLayer layer];
    self.m_gradientLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:self.m_gradientLayer];
    
    //设置渐变颜色方向
    self.m_gradientLayer.startPoint = CGPointMake(0, 0);
    self.m_gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设定颜色组
    self.m_gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor purpleColor].CGColor];
    
    //设定颜色分割点
    self.m_gradientLayer.locations = @[@(0.5f) ,@(1.0f)];
    
    //定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f
                                                  target:self
                                                selector:@selector(TimerEvent)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)TimerEvent
{
    //定时改变颜色
    self.m_gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                  (__bridge id)[UIColor colorWithRed:arc4random() % 255 / 255.0
                                                               green:arc4random() % 255 / 255.0
                                                                blue:arc4random() % 255 / 255.0
                                                               alpha:1.0].CGColor];
    
    //定时改变分割点
    self.m_gradientLayer.locations = @[@(arc4random() % 10 / 10.0f), @(1.0f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
