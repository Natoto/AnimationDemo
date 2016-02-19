//
//  ViewController.m
//  CATransition
//
//  Created by 李泽鲁 on 14/12/12.
//  Copyright (c) 2014年 李泽鲁. All rights reserved.
//

#define IMAGE1 @"01.jpg"
#define IMAGE2 @"02.jpg"
#define DURATION 0.7f

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property (nonatomic, assign) int subtype;

@end

typedef enum : NSUInteger {
    Fade = 0,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;

@implementation TransitionViewController

-(void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidLoad {
    _subtype = 0;
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {//这个是需要的
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
       
    COLLECTIONVIEW_REGISTER_XIB_CELLCLASS(self.collectionView, @"BaseCollectionViewCell");
    // Do any additional setup after loading the view, typically from a nib.
    [self addBgImageWithImageName:IMAGE2];
    
    for (int index = Fade; index <= FlipFromRight; index ++) {
        CELL_STRUCT * cellstruct = [CELL_STRUCT cell_x_x_struct:[self titleOfAnimationType:index] detailvalue:nil target:self selectAction:DEFAULT_CELL_SELECT_ACTION];
        cellstruct.cellclass = @"BaseCollectionViewCell";
        cellstruct.cellheight = 100;
        cellstruct.sectionheight = 0;
        cellstruct.key_indexpath = KEY_INDEXPATH(0, index);
        [cellstruct.dictionary setObject:[UIColor colorWithWhite:1 alpha:0.5] forKey:key_cellstruct_background];
        [self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, index)];
    }
    [self adjustContentOffSet:0 bottom:0];
}

-(NSString *)titleOfAnimationType:(AnimationType)type
{
    switch (type) {
        case Fade:
            return @"//淡入淡出";
            break;
        case Push:
            return @"//推挤";
            break;
        case Reveal:
            return @"//揭开";
            break;
        case MoveIn:
            return @"//覆盖";
            break;
        case Cube:
            return @"立方体";
            break;
        case  SuckEffect:return @"//吮吸"; break;
        case  OglFlip:return @"//翻转"; break;
        case  RippleEffect:return @"//波纹"; break;
        case  PageCurl:return @"//翻页"; break;
        case PageUnCurl:return @"//反翻页";break;
        case CameraIrisHollowOpen:return @"//开镜头"; break;
        case CameraIrisHollowClose:return @"//关镜头";break;
        case CurlDown:return @"//下翻页";break;
        case CurlUp:return @"//上翻页";break;
        case FlipFromLeft:return @"//左翻转";break;
        case FlipFromRight:return @"//右翻转";break;
        default:
            return @"";
            break;
    }
}

GET_CELL_SELECT_ACTION(cellcellstruct)
{
    NSString * key_indexpath = cellcellstruct.key_indexpath;
    NSString * rowIndexString = KEY_INDEXPATH_ROW_STR(key_indexpath);
    [self tapButton:rowIndexString.integerValue];
}

- (IBAction)tapButton:(NSInteger)tag {
    
    AnimationType animationType = tag;
    
    NSString *subtypeString;
    
    switch (_subtype) {
        case 0:
            subtypeString = kCATransitionFromLeft;
            break;
        case 1:
            subtypeString = kCATransitionFromBottom;
            break;
        case 2:
            subtypeString = kCATransitionFromRight;
            break;
        case 3:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    _subtype += 1;
    if (_subtype > 3) {
        _subtype = 0;
    }
    
    
    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self.view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CurlDown:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
            
        default:
            break;
    }
    
    static int i = 0;
    if (i == 0) {
        [self addBgImageWithImageName:IMAGE1];
        i = 1;
    }
    else
    {
        [self addBgImageWithImageName:IMAGE2];
        i = 0;
    }
}

#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DURATION;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
    
}



#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}



#pragma 给View添加背景图
-(void)addBgImageWithImageName:(NSString *) imageName
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
