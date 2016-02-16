//
//  Circle.m
//  TestAnimation
//
//  Created by zeno on 16/1/14.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "Circle.h"

@implementation Circle
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
 - (void)drawRect:(CGRect)rect {
     
     CGContextRef context = UIGraphicsGetCurrentContext();
     /*画矩形*/
     CGContextStrokeRect(context,CGRectMake(100, 120, 10, 10));//画方框
     CGContextFillRect(context,CGRectMake(120, 120, 10, 10));//填充框
     //矩形，并填弃颜色
     UIColor *rectColor = [UIColor whiteColor];
//     CGContextSetLineWidth(context, 2.0);//线的宽度
//     rectColor = [UIColor blueColor];//blue蓝色
     CGContextSetFillColorWithColor(context, rectColor.CGColor);//填充颜色
//     rectColor = [UIColor yellowColor];
//     CGContextSetStrokeColorWithColor(context, rectColor.CGColor);//线框颜色
     CGContextAddRect(context,self.bounds);//画方框
     CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
     
//     //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
//     // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
     
     CGContextSetRGBStrokeColor(context,1,0,1,1.0);//画笔线的颜色
     
     CGFloat radius = (self.bounds.size.width>self.bounds.size.height)?self.bounds.size.height/2:(self.bounds.size.width/2);
     radius = radius;
     //画大圆并填充颜
     UIColor*aColor = [UIColor clearColor];//[UIColor colorWithRed:1 green:0.0 blue:0 alpha:0.5];
     CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
     CGContextSetLineWidth(context, 1.0);//线的宽度
     CGContextAddArc(context,self.bounds.size.width/2, self.bounds.size.height/2, radius -1, 0, 2*M_PI, 0); //添加一个圆
     //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
     CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
     
//     CGContextClosePath(context);//封起来
//     CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}


@end
