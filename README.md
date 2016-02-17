### animation动画的三个角色
tags: Animation

------

* 导引
在iOS中，展示动画可以类比于显示生活中的“拍电影”。拍电影有三大要素：演员+剧本+开拍，概念类比如下：
 演员--->CALayer，规定电影的主角是谁
剧本--->CAAnimation，规定电影该怎么演，怎么走，怎么变换
开拍--->AddAnimation，开始执行

* 主角

| 类型        | 函数名   |  用途  |
| --------   | -----:  | :----:  |
|基本图层 |CALayer|动画的主角 |
|形状图层 |CAShapeLayer| 绘制不规则图形|
|渐变图层|CAGradientLayer|颜色渐变、阴影|
|复制图层|CAReplicatorLayer|迭代复制同一个图层|


* 剧本

| 类型        | 函数名   |  用途  |
| --------   | -----:  | :----:  |
| 基础动画|CABasicAnimation|位移、透明度、缩放、旋转|
| 关键帧     | CAKeyframeAnimation  | 路径、抖动、关键帧|
|组合动画|CAAnimationGroup|多个动画的结合|
|系统封装动画|CATransition|淡入淡出、推挤、解开、覆盖|
|放射变幻|CGAffineTransform| 旋转缩放|


* 开拍

| 类型        | 函数名 |  
| --------   | :-----:  |
|加入执行动画|\- (void)addAnimation:(CAAnimation *)anim forKey:(nullable NSString *)key;|

![继承关系](https://github.com/Natoto/AnimationDemo/blob/master/screenshot/inherit.png?raw=true) 
###CALayer

CALayer是个与UIView很类似的概念，同样有layer,sublayer...，同样有backgroundColor、frame等相似的属性，我们可以将UIView看做一种特殊的CALayer，只不过UIView可以响应事件而已。一般来说，layer可以有两种用途，二者不互相冲突：一是对view相关属性的设置，包括圆角、阴影、边框等参数，更详细的参数请点击这里；二是实现对view的动画操控。因此对一个view进行core animation动画，本质上是对该view的.layer进行动画操纵。
 
  
### CAAnimation
CAAnimation可分为四种：

#### 1. CABasicAnimation 基本动画
通过设定起始点，终点，时间，动画会沿着你这设定点进行移动。可以看做特殊的CAKeyFrameAnimation
创建cabaseanimation 的方法，但是在最新的apple开发文档没有查到path到底有哪些，网上搜罗了一下，并猜测path跟layer中的属性字段是一致的如background
```
/** Subclass for property-based animations. **/
@interface CAPropertyAnimation : CAAnimation
/* Creates a new animation object with its `keyPath' property set to
 * 'path'. */
+ (instancetype)animationWithKeyPath:(nullable NSString *)path;
/* The key-path describing the property to be animated. */
@property(nullable, copy) NSString *keyPath;
```
|  path   |  用途  |
|  -----  | :----  |
|rotaion.x|旋转，弧度，X轴|
|rotaion.y|旋转，弧度，Y轴|
|rotaion.z|旋转，弧度，Z轴|
|rotaion  |旋转，弧度，Z轴，完全等同于rotation.z|
|scale.x  |缩放，X轴|
|scale.y  |缩放，Y轴|
|scale.z  |缩放，Z轴|
|scale    |缩放，XYZ轴|
|translation.x  |移动，X轴|
|translation.y  |移动，Y轴|
|translation.z  |移动，Z轴|
|translation    |移动，XY轴，value值为NSSize或者CGSize类型|
| opacity等|zPosition、frame、backgroundColor、cornerRadius类似的layer中的各种属性|

所以有如下代码
```
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
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];//同上
    anima.toValue = [NSNumber numberWithFloat:2.0f];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"scaleAnimation"]; 
}

/**
 *  旋转动画
 */
-(void)rotateAnimation{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//绕着z轴为矢量，进行旋转(@"transform.rotation.z"==@@"transform.rotation")
    anima.toValue = [NSNumber numberWithFloat:3*M_PI];
    anima.duration = 1.0f;
    [_demoView.layer addAnimation:anima forKey:@"rotateAnimation"];
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
```
有人会疑惑addanimation:forkey: 这个key到底是什么官方的注释是
```
/** Animation methods. **/

/* Attach an animation object to the layer. Typically this is implicitly
 * invoked through an action that is an CAAnimation object.
 *
 * 'key' may be any string such that only one animation per unique key
 * is added per layer. The special key 'transition' is automatically
 * used for transition animations. The nil pointer is also a valid key.
 *
 * If the `duration' property of the animation is zero or negative it
 * is given the default duration, either the value of the
 * `animationDuration' transaction property or .25 seconds otherwise.
 *
 * The animation is copied before being added to the layer, so any
 * subsequent modifications to `anim' will have no affect unless it is
 * added to another layer. */
```
翻译下
```
/ * *动画方法。* * // 
* 将动画对象附加到层。通常这是隐式地
* 通过一个动作是一个CAAnimation对象调用。
* “key”可以是任何字符串,这样每个唯一键只有一个动画
* 添加每层。特殊键自动“过渡”
* 用于过渡动画。空指针也是一个有效的关键。
* 如果动画的“持续时间”属性是零或消极
* 默认时间,给出的值
*  animationDuration事务属性或。25秒。
*  动画复制之前添加到层,所以任何后续修改“动画”没有影响,除非它是添加到另一层
```
所以大家放心使用CABasicAnimation！

### 2. CAKeyframeAnimation 关键帧动画
Keyframe顾名思义就是关键点的frame，你可以通过设定CALayer的始点、中间关键点、终点的frame，时间，动画会沿你设定的轨迹进行移动 CAKeyframeAnimation 的一些比较重要的属性

2.1. path
这是一个 CGPathRef 对象，默认是空的，当我们创建好CAKeyframeAnimation的实例的时候，可以通过制定一个自己定义的path来让某一个物体按照这个路径进行动画。这个值默认是nil，当其被设定的时候values 这个属性就被覆盖。 

2.2. values

一个数组，提供了一组关键帧的值，当使用path的 时候 values的值自动被忽略。

下面是一个简单的例子  效果为动画的连续移动一个block到不同的位置
```
/**
 *  关键帧动画 values
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
```
 对比UIView动画跟关键帧动画，关键帧动画引入了动画占比时长的概念，这让我们能控制每个关键帧动画的占用比例而不是传入一个无意义的动画时长 —— 这让我们的代码更加难以理解。当然，除了动画占比之外，关键帧动画的options参数也让动画变得更加平滑，下面是关键帧特有的配置参数：
 > UIViewKeyframeAnimationOptionCalculationModeLinear      // 连续运算模式，线性
UIViewKeyframeAnimationOptionCalculationModeDiscrete    // 离散运算模式，只显示关键帧
UIViewKeyframeAnimationOptionCalculationModePaced       // 均匀执行运算模式，线性
UIViewKeyframeAnimationOptionCalculationModeCubic       // 平滑运算模式
UIViewKeyframeAnimationOptionCalculationModeCubicPaced  // 平滑均匀运算模式

#### 3. CAAnimationGroup 组合动画
* Group也就是组合的意思，可以保存一组动画对象，将CAAnimationGroup对象加入图层后，组中所有动画对象可以同时并发运行
* animations属性：用来保存一组动画对象的NSArray
* 注意：默认情况下，一组动画对象是同时运行的，也 可以通过设置动画对象的beginTime属性来更改动画的开始时间
```
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
    }
```
![组合动画](https://github.com/Natoto/AnimationDemo/blob/master/screenshot/groupanimation.gif?raw=true)

  PS：一个layer设定了很多动画，他们都会同时执行，而且是顺序执行。(详见demo)
  
#### 4. CATransition 系统封装的过渡动画

* 对于UIView的动画 
   
|UIViewAnimationTransition 声明|过渡方向|
|--|--|  
|UIViewAnimationTransitionFlipFromLeft| 向左转动|
|UIViewAnimationTransitionFlipFromRight| 向右转动|
|UIViewAnimationTransitionCurlUp| 向上翻动|
|UIViewAnimationTransitionCurlDown| 向下翻动|
 
```
//写法一
-(void)test
{
  [UIView beginAnimations:@"animationID" context:nil];
  [UIView setAnimationDuration:0.5f]; //动画时长
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES]; //给视图添加过渡效果
//在这里写你的代码.
  [UIView commitAnimations]; //提交动画
}
#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}
```
* 对于layer的动画

|名称 CATransition.type|过渡效果|
|----|----|
|    kCATransitionFade | //淡入淡出 (不支持过渡方向)|
|  kCATransitionPush,    |                   //推挤|
|kCATransitionReveal |                     //揭开|
|  kCATransitionMoveIn|                    //覆盖|
|  Cube|                      //立方体|
| SuckEffect|                 //吮吸|
|    OglFlip|                    //翻转|
|    rippleEffect|               //波纹|
|    pageCurl|                   //翻页|
|    pageUnCurl|                 //反翻页|
|   cameraIrisHollowOpen|       //开镜头  相机镜头打开效果(不支持过渡方向)|
|  cameraIrisHollowClose|      //关镜头 相机镜头打开效果(不支持过渡方向)|
 
 CATransition含有type和subtype两个属性，分别的解释是
 > /* The name of the transition. Current legal transition types include
 * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */
@property(copy) NSString *type;
 
>/* An optional subtype for the transition. E.g. used to specify the
 * transition direction for motion-based transitions, in which case
 * the legal values are `fromLeft', `fromRight', `fromTop' and
 * `fromBottom'. */
@property(nullable, copy) NSString *subtype;

由此可见设置CATransition动画就是动画效果和方向的结合 
```
//写法二
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
```
   
#### CGAffineTransform 仿射变换
transform是一个非常重要的属性，它在矩阵变换的层面上改变视图的显示效果，完成旋转、形变、平移等等操作。在它被修改的同时，视图的frame也会被真实改变。有两个数据类型用来表示transform，分别是CGAffineTransform和CATransform3D。前者作用于UIView，后者为layer层次的变换类型。基于后者可以实现更加强大的功能，但我们需要先掌握CGAffineTransform类型的使用。
```
struct CGAffineTransform {
  CGFloat a, b, c, d;
  CGFloat tx, ty;
};
```
其实就是对应如下矩阵
| a | b | 0 |
|  c | d | 0 |
| tx | ty | 0 |

对于想要了解矩阵变换是如何作用实现的，
创建一个仿射矩阵
在开始使用transform实现你的动画之前，我先介绍几个常用的函数：
> /// 用来连接两个变换效果并返回。返回的t = t1 * t2
CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2)
/// 矩阵初始值。[ 1 0 0 1 0 0 ]
CGAffineTransformIdentity
/// 自定义矩阵变换，需要掌握矩阵变换的知识才知道怎么用。参照上面推荐的原理链接
CGAffineTransformMake(CGFloat a, CGFloat b, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty)
/// 旋转视图。传入参数为 角度 * (M_PI / 180)。等同于 CGAffineTransformRotate(self.transform, angle)
CGAffineTransformMakeRotation(CGFloat angle)
CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
/// 缩放视图。等同于CGAffineTransformScale(self.transform, sx, sy)
CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
/// 缩放视图。等同于CGAffineTransformTranslate(self.transform, tx, ty)
CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
 
> CGAffineTransformMake 直接赋值来创建
CGAffineTransformMakeRotation 设置角度来生成矩阵
结果就是
CGAffineTransformMakeScale  设置缩放，及改变a、d的值
CGAffineTransformMakeTranslation  设置偏移
改变已经存在的放射矩阵--
CGAffineTransformTranslate  原始的基础上加上偏移
CGAffineTransformScale加上缩放
CGAffineTransformRotate加上旋转
CGAffineTransformInvert 反向的仿射矩阵比如（x，y）通过矩阵t得到了（x',y'）那么通过这个函数生成的t'作用与（x',y'）就能得到原始的(x,y)
CGAffineTransformConcat 通过两个已经存在的放射矩阵生成一个新的矩阵t' = t1 * t2
应用仿射矩阵
CGPointApplyAffineTransform 得到新的点
CGSizeApplyAffineTransform  得到新的size
CGRectApplyAffineTransform  得到新的rect
评测矩阵
CGAffineTransformIsIdentity  是否是CGAffineTransformIsIdentity
CGAffineTransformEqualToTransform 看两个矩阵是否相等

更多cgaffinetransform深入介绍查看
https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CGAffineTransform/
http://www.cnblogs.com/v2m_/archive/2013/05/09/3070187.html

![demo预览](https://github.com/Natoto/AnimationDemo/blob/master/screenshot/animation.gif?raw=true)
- 博客地址 http://www.jianshu.com/p/88ab3415a3fe
- 如果有兴趣欢迎下载[DEMO](https://github.com/Natoto/AnimationDemo)
- 喜欢就点个赞呗！

![ExtremeFruit](http://mp.weixin.qq.com/mp/qrcode?scene=10000004&size=102&__biz=MzA3ODQyNDM0Mg==)
