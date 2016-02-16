//
//  LoadingViewController.m
//  TestAnimation
//
//  Created by zeno on 16/2/16.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "LoadingViewController.h"

@interface PlayingAnimationView : UIView

@end

@implementation PlayingAnimationView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer new];
        replicatorLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        replicatorLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
        replicatorLayer.anchorPoint = CGPointMake(0, 0);
        [self.layer addSublayer:replicatorLayer];
        
        
        CALayer * rectangle = [CALayer new];
        
        CGFloat width = (frame.size.width - 30)/4;
        
        rectangle.bounds = CGRectMake(0, 0, width, frame.size.height - 10);//: 0, y: 0, width: 30, height: 90)
        rectangle.anchorPoint = CGPointMake(0, 0);
        rectangle.position = CGPointMake(frame.origin.x + 10, frame.origin.y + 110);
        rectangle.cornerRadius = 2;
        rectangle.backgroundColor = [UIColor whiteColor].CGColor;
        [replicatorLayer addSublayer:rectangle];
    
        
        CABasicAnimation * moveRectangle = [CABasicAnimation animationWithKeyPath:@"position.y"];
        moveRectangle.toValue = @(rectangle.position.y - 70);
        moveRectangle.duration = 0.7;
        moveRectangle.autoreverses = true;
        moveRectangle.repeatCount = HUGE;
        
        [rectangle addAnimation:moveRectangle forKey:nil];
        
        //复制动画和状态
        //重复次数
        replicatorLayer.instanceCount = 4;
        //平移点的间隔 x y z
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(width + 10, 0, 0);
        replicatorLayer.masksToBounds = true;
        replicatorLayer.instanceDelay =0.3;//延迟动画开始时间 以造成旋转的效果
//        rectangle.transform = CATransform3DTranslate(<#CATransform3D t#>, <#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
        
        
    }
    return self;
}
@end

@interface LoadingView : UIView

@end

@implementation LoadingView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAReplicatorLayer * replicatorLayer = [CAReplicatorLayer new];
        replicatorLayer.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        replicatorLayer.position = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self.layer addSublayer:replicatorLayer];
        
        CALayer * circle = [CALayer new];
        circle.bounds = CGRectMake(0, 0, 15, 15);
        circle.position = CGPointMake(frame.size.width/2, frame.size.height/2 - 55);
        circle.cornerRadius = 7.5;
        circle.backgroundColor = [UIColor whiteColor].CGColor;
        [replicatorLayer addSublayer:circle];
        
        //复制15个同样的layer
        replicatorLayer.instanceCount = 15;
        CGFloat angle = 2 * M_PI/ 15.;
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
        replicatorLayer.instanceDelay = 1./15.;//延迟动画开始时间 以造成旋转的效果
     
        CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scale.fromValue = @1;
        scale.toValue = @0.1;
        scale.duration = 1;
        scale.repeatCount = HUGE;
        
        circle.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
        [circle addAnimation:scale forKey:nil];
        

    }
    return self;
}

@end

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    PlayingAnimationView * playingview = [[PlayingAnimationView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    playingview.center = CGPointMake(self.view.center.x, 80);
    [self.view addSubview:playingview];
    
    LoadingView * view = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:view];
    
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
