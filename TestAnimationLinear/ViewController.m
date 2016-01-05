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

@interface ViewController ()
@property(nonatomic,strong) NSArray * array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titles = @[@"过渡动画-Transition",@"基础动画",@"关键帧动画",@"组动画",@"仿射变幻",@"综合"];
    self.array = titles;

    [titles enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CELL_STRUCT * cellstruct = [CELL_STRUCT cell_x_x_struct:obj detailvalue:nil target:self selectAction:DEFAULT_CELL_SELECT_ACTION];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, idx)];
    }];
}
GET_CELL_SELECT_ACTION(cellstruct)
{
    if ([cellstruct.title isEqualToString:self.array[0]]) {
        TransitionViewController * ctr = [[TransitionViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else  if ([cellstruct.title isEqualToString:self.array[1]]) {
        BaseAnimationController *  ctr = [[BaseAnimationController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else  if ([cellstruct.title isEqualToString:self.array[3]])
    {
        GroupAnimationController *  ctr = [[GroupAnimationController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else  if ([cellstruct.title isEqualToString:self.array[2]])
    {
        KeyFrameAnimationController *  ctr = [[KeyFrameAnimationController alloc] init];
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
