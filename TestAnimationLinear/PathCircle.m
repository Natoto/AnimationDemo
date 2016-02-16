//
//  PathCircle.m
//  TestAnimation
//
//  Created by zeno on 16/1/14.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "PathCircle.h"

@implementation PathCircle

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        CGFloat width = self.bounds.size.width;
//        CGFloat height = self.bounds.size.height;
//        // Get your image somehow
//        UIImage *image = [UIImage imageNamed:@"bulb"];
//        
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
//        
//        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:M_PI endAngle:3*M_PI clockwise:1];
//        
//        
//        [path addClip];
//        // Draw your image
//        [image drawInRect:self.bounds];
//        
//        //画圆圈
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//画笔颜色
//        CGContextSetLineWidth(context, 2);//线的宽度
//        CGContextAddArc(context, width/2, height/2, width/2, 0, 2*M_PI, 0);
//        
//        CGContextStrokePath(context);
//        // Get the image, here setting the UIImageView image
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        
//        // Lets forget about that we were drawing
//        UIGraphicsEndImageContext();
//    
//        self.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    
    [aPath addArcWithCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:M_PI endAngle:3*M_PI clockwise:1];
//    [aPath addClip];
    [aPath stroke];

//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
//    
//    // Set the starting point of the shape.
//    [aPath moveToPoint:CGPointMake(0, 0.0)];
//    // Draw the lines
//    [aPath addLineToPoint:CGPointMake(width, 0)];
//    [aPath addLineToPoint:CGPointMake(width, height)];
//    [aPath addLineToPoint:CGPointMake(0, height)];
//    [aPath addLineToPoint:CGPointMake(0, height/2)];
//    [aPath addArcWithCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:M_PI endAngle:3*M_PI clockwise:1];
//    [aPath addClip];
//    [aPath closePath];//第五条线通过调用closePath方法得到的
//    [aPath fill];
    
//---------------------------------------------------------------------
    
//    CGFloat width = self.bounds.size.width;
//    CGFloat height = self.bounds.size.height;
//    UIBezierPath * bpath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, height/2) radius:width/2 startAngle:0 endAngle:2*M_PI clockwise:1];
//    [bpath stroke];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:29/255.f alpha:1.0].CGColor);
//    CGContextSetRGBStrokeColor(context,1,0,1,1.0);//画笔线的颜色
//    CGContextSetLineWidth(context, 1.0);//线的宽度
//    /*画贝塞尔曲线*/
//    //二次曲线
//    CGContextMoveToPoint(context, 0, 0);//设置Path的起点
//    
//    /* Append a quadratic curve from the current point to `(x, y)', with control
//     point `(cpx, cpy)'. */
//    CGContextAddQuadCurveToPoint(context,200, 0, self.bounds.size.width, self.bounds.size.height);//设置贝塞尔曲线的控制点坐标和终点坐标
//   
//    CGContextAddQuadCurveToPoint(context,0, 300, 0, 0);//设置贝塞尔曲线的控制点坐标和终点坐标
//    CGContextStrokePath(context);
    
}

@end
