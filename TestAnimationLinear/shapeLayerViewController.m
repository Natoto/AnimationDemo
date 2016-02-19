//
//  shapeLayerViewController.m
//  TestAnimation
//
//  Created by zeno on 16/2/19.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "shapeLayerViewController.h"

@interface ProgressView : UIView

@end

@implementation ProgressView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAShapeLayer * shapelayer = [CAShapeLayer layer];
    
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2) radius:frame.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
        //[UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:frame.size.width/2];
        //路径
        shapelayer.path = path.CGPath;
        //填充色
        shapelayer.fillColor = [UIColor clearColor].CGColor;
        // 设置线的颜色
        shapelayer.strokeColor = [UIColor orangeColor].CGColor;
        //线的宽度
        shapelayer.lineWidth = 5;
        [self.layer addSublayer:shapelayer];
        
        //设置stroke起始点
//        shapelayer.strokeStart = 0;
//        shapelayer.strokeEnd = 0.75;
        
        CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        anima.fromValue = [NSNumber numberWithFloat:0.f];
        anima.toValue = [NSNumber numberWithFloat:1.f];
        anima.duration = 4.0f;
        anima.repeatCount = MAXFLOAT;
        anima.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        [shapelayer addAnimation:anima forKey:@"strokeEndAniamtion"];
 
        
        CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        anima3.toValue = [NSNumber numberWithFloat:-M_PI*2];
        anima3.duration = 2.0f;
        anima3.repeatCount = MAXFLOAT;
        anima3.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        [self.layer addAnimation:anima3 forKey:@"rotaionAniamtion"];
    }
    return self;
}
@end

@interface shapeLayerViewController ()

@end

@implementation shapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ProgressView * layer = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    layer.center = self.view.center;
    [self.view addSubview:layer];
//    layer.backgroundColor = [UIColor grayColor];
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
