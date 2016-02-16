//
//  BaseAnimationController.m
//  TestAnimationLinear
//
//  Created by zeno on 16/1/5.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "BaseAnimationController.h"
#import "BubleViewController.h"

@interface BaseAnimationController ()

@property (nonatomic , strong) UIView *demoView;
@end

@implementation BaseAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {//这个是需要的
//        self.edgesForExtendedLayout = UIRectEdgeAll;
//    }
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
    
    self.title = [self controllerTitle];
    _demoView = [[UIView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-50, [UIScreen mainScreen].bounds.size.height-200,100 ,100 )];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
}
-(NSString *)controllerTitle{
    return @"基础动画";
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"位移",@"透明度",@"缩放",@"旋转",@"背景色",@"电灯", nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    
}

GET_CELL_SELECT_ACTION(cellstruct)
{
    NSArray * array = [self operateTitleArray];
    if ([cellstruct.title isEqualToString:array[0]]) {
        [self positionAnimation];
    }else if ([cellstruct.title isEqualToString:array[1]]) {
        [self opacityAniamtion];
        
    }else if ([cellstruct.title isEqualToString:array[2]]) {
        [self scaleAnimation];
        
    }else if ([cellstruct.title isEqualToString:array[3]]) {
        [self rotateAnimation];
        
    }else if ([cellstruct.title isEqualToString:array[4]]) {
        [self backgroundAnimation];
        
    }
    else if([cellstruct.title isEqualToString:array[5]])
    {
        BubleViewController * ctr = [[BubleViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  位移动画演示
 */
-(void)positionAnimation{
    //使用CABasicAnimation创建基础动画
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, [UIScreen mainScreen].bounds.size.width/2-75)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height/2-75)];
    anima.duration = 1.0f;
    //如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    //anima.fillMode = kCAFillModeForwards;
    //anima.removedOnCompletion = NO;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_demoView.layer addAnimation:anima forKey:@"positionAnimation"];
    
    
    //使用UIView Animation 代码块调用
    //    _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
    //    [UIView animateWithDuration:1.0f animations:^{
    //        _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
    //    } completion:^(BOOL finished) {
    //        _demoView.frame = CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-50, 50, 50);
    //    }];
    //
    //使用UIView [begin,commit]模式
    //    _demoView.frame = CGRectMake(0, SCREEN_HEIGHT/2-50, 50, 50);
    //    [UIView beginAnimations:nil context:nil];
    //    [UIView setAnimationDuration:1.0f];
    //    _demoView.frame = CGRectMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50, 50, 50);
    //    [UIView commitAnimations];
}

/**
 *  透明度动画
 */
-(void)opacityAniamtion{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue = [NSNumber numberWithFloat:0.2f];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"opacityAniamtion"];
}

/**
 *  缩放动画
 */
-(void)scaleAnimation{
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"bounds"];
    //    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    //    anima.duration = 1.0f;
    //    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"];
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
    anima.toValue = [NSNumber numberWithFloat:2.0f];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"];
    
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    //    anima.toValue = [NSNumber numberWithFloat:0.2f];
    //    anima.duration = 1.0f;
    //    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"];
}

/**
 *  旋转动画
 */
-(void)rotateAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima.toValue = [NSNumber numberWithFloat:3*M_PI];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    //    //valueWithCATransform3D作用与layer
    //    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
    //    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];//绕着矢量（x,y,z）旋转
    //    anima.duration = 1.0f;
    //    //anima.repeatCount = MAXFLOAT;
    //    [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
    
    //    //CGAffineTransform作用与View
    //    _demoView.transform = CGAffineTransformMakeRotation(0);
    //    [UIView animateWithDuration:1.0f animations:^{
    //        _demoView.transform = CGAffineTransformMakeRotation(M_PI);
    //    } completion:^(BOOL finished) {
    //
    //    }];
}

/**
 *  背景色变化动画
 */
-(void)backgroundAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue =(id) [UIColor greenColor].CGColor;
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"backgroundAnimation"];
}


@end
