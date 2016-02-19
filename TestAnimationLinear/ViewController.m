//
//  ViewController.m
//  TestAnimationLinear
//
//  Created by zeno on 16/1/5.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "TransitionViewController.h"
#import "ViewController.h"
#import <HBKit/HBKit.h>
#import "BaseAnimationController.h"
#import "GroupAnimationController.h"
#import "KeyFrameAnimationController.h"
#import "GradientLayerViewController.h"
#import "ScrollLabelViewController.h"
#import "LoadingViewController.h"
#import "shapeLayerViewController.h"
@interface ViewController ()
AS_CELL_STRUCT_COMMON(transition)
AS_CELL_STRUCT_COMMON(baseanimation)
AS_CELL_STRUCT_COMMON(keyframeanimation)
AS_CELL_STRUCT_COMMON(groupanimation)
AS_CELL_STRUCT_COMMON(affineanimation)
AS_CELL_STRUCT_COMMON(compositeanimation)
AS_CELL_STRUCT_COMMON(gradientanimation)
AS_CELL_STRUCT_COMMON(scrolllabel)
AS_CELL_STRUCT_COMMON(loadingview)
AS_CELL_STRUCT_COMMON(shapelayer)
@end


@implementation ViewController
GET_CELL_STRUCT_WITH(transition, 过渡动画-Transition)
GET_CELL_STRUCT_WITH(baseanimation, 基础动画)
GET_CELL_STRUCT_WITH(keyframeanimation, 关键帧动画)
GET_CELL_STRUCT_WITH(groupanimation, 组动画)
GET_CELL_STRUCT_WITH(affineanimation, 仿射变幻)
GET_CELL_STRUCT_WITH(compositeanimation, 综合动画)
GET_CELL_STRUCT_WITH(gradientanimation, 渐变色)
GET_CELL_STRUCT_WITH(scrolllabel, text)
GET_CELL_STRUCT_WITH(shapelayer, CAShapeLayer)
GET_CELL_STRUCT_WITH(loadingview, 加载动画)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int sectionIndex = 0;
    int rowIndex = 0;
    [self.dataDictionary setObject:self.cell_struct_transition forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_baseanimation forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_keyframeanimation forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_groupanimation forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)]; 
    [self.dataDictionary setObject:self.cell_struct_affineanimation forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_compositeanimation forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
   
    sectionIndex++;
    rowIndex = 0;
    [self.dataDictionary setObject:self.cell_struct_gradientanimation forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_shapelayer forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    [self.dataDictionary setObject:self.cell_struct_loadingview forKey:KEY_INDEXPATH(sectionIndex, rowIndex++)];
    
}


GET_CELL_SELECT_ACTION(cellstruct)
{
    if (cellstruct == self.cell_struct_transition) {
        TransitionViewController * ctr = [[TransitionViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else  if (cellstruct == self.cell_struct_baseanimation) {
        BaseAnimationController *  ctr = [[BaseAnimationController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else  if (cellstruct == self.cell_struct_groupanimation)
    {
        GroupAnimationController *  ctr = [[GroupAnimationController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else  if (cellstruct == self.cell_struct_keyframeanimation)
    {
        KeyFrameAnimationController *  ctr = [[KeyFrameAnimationController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else  if (cellstruct == self.cell_struct_gradientanimation)
    {
        GradientLayerViewController * ctr = [[GradientLayerViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_scrolllabel)
    {
        ScrollLabelViewController * ctr = [[ScrollLabelViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }    
    else if(cellstruct == self.cell_struct_loadingview)
    {
        LoadingViewController * ctr = [LoadingViewController new];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(cellstruct == self.cell_struct_shapelayer)
    {
        shapeLayerViewController * ctr = [shapeLayerViewController new];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
