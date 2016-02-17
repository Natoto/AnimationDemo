//
//  CenterView2Controller.m
//  侧滑菜单
//
//  Created by yixiang on 15/7/14.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "KeyFrameAnimationController.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface KeyFrameAnimationController ()

@property (nonatomic , strong) UIView *demoView;

@end

@implementation KeyFrameAnimationController

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
        [self keyFrameAnimation];
    }
    else if ([cellstruct.title isEqualToString:array[1]]) {
        
        [self pathAnimation];
    }
    else if ([cellstruct.title isEqualToString:array[2]]) {
        
        [self shakeAnimation];
    }
}
-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"关键帧",@"路径",@"抖动", nil];
}

-(NSString *)controllerTitle{
    return @"关键帧动画";
}
 
/**
 *  关键帧动画
 */
-(void)keyFrameAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima.duration = 2.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    anima.delegate = self;//设置代理，可以检测动画的开始和结束
    [_demoView.layer addAnimation:anima forKey:@"keyFrameAnimation"];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"开始动画");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"结束动画");
}

/**
 *  path动画
 */
-(void)pathAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];
}

/**
 *  抖动效果
 */
-(void)shakeAnimation{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*4];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*4];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*4];
    anima.values = @[value1,value2,value3];
    anima.repeatCount = MAXFLOAT;
    
    [_demoView.layer addAnimation:anima forKey:@"shakeAnimation"];
    
    
}

@end
