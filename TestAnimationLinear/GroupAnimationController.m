//
//  CenterView3Controller.m
//  侧滑菜单
//
//  Created by yixiang on 15/7/18.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "GroupAnimationController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface GroupAnimationController ()

@property (nonatomic , strong) UIView *demoView;

@end

@implementation GroupAnimationController

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewDidLoad
{ 
    [super viewDidLoad];
    COLLECTIONVIEW_REGISTER_XIB_CELLCLASS(self.collectionView, @"BaseCollectionViewCell");
    
    NSArray * array = [self operateTitleArray];
    [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CELL_STRUCT * cellstruct = [CELL_STRUCT cell_x_x_struct:obj detailvalue:nil target:self selectAction:DEFAULT_CELL_SELECT_ACTION];
        cellstruct.cellclass = @"BaseCollectionViewCell";
        cellstruct.cellheight = 50;
        cellstruct.sectionheight = 0;
        cellstruct.key_indexpath = KEY_INDEXPATH(0, index);
        [cellstruct.dictionary setObject:[UIColor colorWithWhite:1 alpha:0.5] forKey:key_cellstruct_background];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, idx)];
        
    }];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50,50,50)];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    self.title = [self controllerTitle];
}

GET_CELL_SELECT_ACTION(cellstruct)
{
    NSArray * array = [self operateTitleArray];
    if ([cellstruct.title isEqualToString:array[0]]) {
          [self groupAnimation1];
    }
    else if ([cellstruct.title isEqualToString:array[1]]) {
        
        [self groupAnimation2];
    }
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"同时",@"连续", nil];
}


-(void)groupAnimation1{
//    //位移动画
    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:anima1,anima2,anima3, nil];
    groupAnimation.duration = 4.0f;
    
    [_demoView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
//-------------如下，使用三个animation不分装成group，只是把他们添加到layer，也有组动画的效果。-------------
//    //位移动画
//    CAKeyframeAnimation *anima1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
//    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
//    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
//    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
//    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
//    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
//    anima1.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
//    anima1.duration = 4.0f;
//    [_demoView.layer addAnimation:anima1 forKey:@"aa"];
//    
//    //缩放动画
//    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
//    anima2.toValue = [NSNumber numberWithFloat:2.0f];
//    anima2.duration = 4.0f;
//    [_demoView.layer addAnimation:anima2 forKey:@"bb"];
//    
//    //旋转动画
//    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
//    anima3.duration = 4.0f;
//    [_demoView.layer addAnimation:anima3 forKey:@"cc"];
}

/**
 *  顺序执行的组动画
 */
-(void)groupAnimation2{
    CFTimeInterval currentTime = CACurrentMediaTime();
    //位移动画
    CGFloat beginTime = 0.0f;
    CABasicAnimation *anima1 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima1.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-75)];
    anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-75)];
    anima1.beginTime = currentTime + beginTime++;
    anima1.duration = 1.0f;
    anima1.fillMode = kCAFillModeForwards;
    anima1.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima1 forKey:@"aa"];
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:2.0f];
    anima2.beginTime = currentTime + beginTime++;
    anima2.duration = 1.0f;
    anima2.fillMode = kCAFillModeForwards;
    anima2.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima2 forKey:@"bb"];
    
    //旋转动画
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*4];
    anima3.beginTime = currentTime + beginTime++;
    anima3.duration = 1.0f;
    anima3.fillMode = kCAFillModeForwards;
    anima3.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima3 forKey:@"cc"];
    
    //huangbo added
    CABasicAnimation *anima4 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima4.toValue = [NSNumber numberWithFloat:-M_PI*4];
    anima4.beginTime = currentTime + beginTime++;
    anima4.duration = 1.0f;
    anima4.fillMode = kCAFillModeForwards;
    anima4.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima4 forKey:@"dd"];
    
    
    CABasicAnimation *anima5 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima5.fromValue = [NSNumber numberWithFloat:1.2f];
    anima5.toValue = [NSNumber numberWithFloat:0.8f];
    anima5.beginTime = currentTime + beginTime++;
    anima5.duration = 1.0f;
    anima5.fillMode = kCAFillModeForwards;
    anima5.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima5 forKey:@"ee"];
    
    CABasicAnimation *anima6 = [CABasicAnimation animationWithKeyPath:@"position"];
    anima6.fromValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-75)];
    anima6.toValue = [NSValue valueWithCGPoint:CGPointMake(20, SCREEN_HEIGHT/2-75)];
    anima6.beginTime = currentTime + beginTime++;
    anima6.duration = 1.0f;
    anima6.fillMode = kCAFillModeForwards;
    anima6.removedOnCompletion = NO;
    [_demoView.layer addAnimation:anima6 forKey:@"ff"];
    
    
}

-(NSString *)controllerTitle{
    return @"组动画";
}


@end
