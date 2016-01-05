//
//  BaseTableViewCell.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "CELL_STRUCT_KEY.h"
#import "HBBaseTableViewCell.h"
#import "CELL_STRUCT_Common.h"
#import <objc/runtime.h>

@interface HBCirclePoint : UIView
@property(nonatomic,strong) UIColor * color;
@end

@interface HBRedPoint : HBCirclePoint
@end


@interface HBBaseTableViewCell()
@property(nonatomic,strong) HBRedPoint * redPoint;

@end
@implementation HBBaseTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.detailTextLabel.textColor = [UIColor grayColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _redPoint = [[HBRedPoint alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [self.contentView addSubview:_redPoint];
    }
    return self;
}
- (void)awakeFromNib {
    
    
}
 
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageRight) {//重新排版imageview
        CGFloat orix = self.imageView.frame.origin.x;
        CGFloat x = self.contentView.bounds.size.width - self.contentView.bounds.size.height;
        CGFloat y = 5;
        CGFloat width = self.contentView.bounds.size.height - 10;
        CGFloat height = width;
        self.imageView.frame = CGRectMake(x, y, width, height);
        
        x = orix;
        y = self.textLabel.frame.origin.y;
        width = self.textLabel.frame.size.width;
        height = self.textLabel.frame.size.height;
        self.textLabel.frame =  CGRectMake(x, y, width, height);
        
        x = self.detailTextLabel.frame.origin.x - self.imageView.bounds.size.height;
        y = self.detailTextLabel.frame.origin.y;
        width = self.detailTextLabel.frame.size.width;
        height = self.detailTextLabel.frame.size.height;
        self.detailTextLabel.frame = CGRectMake(x, y, width, height);
        self.separatorInset = UIEdgeInsetsMake(0, orix, 0, 0);//上左下右 就可以通过设置这四个参数来设置分割线了
    }
    if (self.CornerRadius) {
        self.imageView .layer.masksToBounds = YES;\
        self.imageView .layer.borderColor =[UIColor whiteColor].CGColor;\
        self.imageView .layer.borderWidth = 0;
        CGFloat width = self.contentView.bounds.size.height - 10;
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, width, width);
        [self.imageView .layer setCornerRadius:width/ 2];
        self.imageView.center = CGPointMake(self.imageView.frame.origin.x + self.imageView.frame.size.width/2, self.contentView.bounds.size.height/2);
        self.textLabel.frame = CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width + 5, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    }
    NSString *textAlignment = [self.dictionary objectForKey:key_cellstruct_textAlignment];
    if (textAlignment) {
        if ([textAlignment isEqualToString:value_cellstruct_textAlignment_left]) {
            self.textLabel.textAlignment = NSTextAlignmentLeft;
            self.textLabel.center = CGPointMake(self.textLabel.bounds.size.width/2 ,self.textLabel.center.y);
        }
        else if ([textAlignment isEqualToString:value_cellstruct_textAlignment_center]) {
            self.textLabel.center = CGPointMake(self.contentView.bounds.size.width/2,self.textLabel.center.y);
        }
        else if ([textAlignment isEqualToString:value_cellstruct_textAlignment_right]) {
            //            self.textLabel.textAlignment = NSTextAlignmentRight;
            self.textLabel.center = CGPointMake(self.contentView.bounds.size.width - self.textLabel.bounds.size.width/2 ,self.textLabel.center.y);
        }
    }
    
    if (self.showTopLine) {
        [self clearTopLayer];
        [self drawToplinelayer];
    }
    if (self.showBottomLine) {
        [self clearBottomLayer];
        [self drawBottomlinelayer];
    }
    //    if (self.showNewPoint) {
    self.redPoint.center = CGPointMake(self.contentView.frame.size.width - 20, self.contentView.frame.size.height/2);
    //    }
    //   [self.textLabel setFrame:CGRectMake(0, 0, self.contentView.bounds.size.width * 3 / 4, self.contentView.bounds.size.height / 2)];
}

-(void)setcellimageRight:(BOOL)imageRight
{
    self.imageRight = imageRight;
    if (imageRight) {
        [self layoutSubviews];
    }
}
//设置圆角
-(void)setcellimageCornerRadius:(BOOL)CornerRadius
{
    _CornerRadius = CornerRadius;
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (self.RoundCircleType) {
        if (_indexPath.row) {
            
        }
    }
}
-(void)setcelldictionary:(NSMutableDictionary *)dictionary
{
    _dictionary = dictionary;
    UIColor * bgcolor = [dictionary objectForKey:key_cellstruct_background];
    if ([[bgcolor class] isSubclassOfClass:[UIColor class]]) {
        self.contentView.backgroundColor = bgcolor;
        self.backgroundColor = bgcolor;
    }
    if ([[bgcolor class] isSubclassOfClass:[NSString class]]) {
        NSString * bgcolorstring= [dictionary objectForKey:key_cellstruct_background];
        self.contentView.backgroundColor = [CELL_STRUCT colorWithStructKey:bgcolorstring];
        self.backgroundColor = self.contentView.backgroundColor;
    }
    NSString * detailvalue = [dictionary objectForKey:key_cellstruct_detailvalue];
    OBJ_NULL_DEFAULT(detailvalue, @"")
    NSNumber * imageCornerRadius = DIC_OBJ_KEY(dictionary, key_cellstruct_detailvalue);
    OBJ_NULL_DEFAULT(imageCornerRadius, @0)
    
    NSNumber * newmsgcount = DIC_OBJ_KEY(dictionary, key_cellstruct_newmessagecount);
    OBJ_NULL_DEFAULT(newmsgcount, @0)
    self.showNewMsg = newmsgcount.boolValue;//是否显示红点
    self.redPoint.hidden = !self.showNewMsg;
    
    NSNumber * footerheight = DIC_OBJ_KEY(dictionary, key_cellstruct_sectionfooterheight);
    OBJ_NULL_DEFAULT(footerheight, @0)
    NSNumber * accessory = [dictionary objectForKey:key_cellstruct_accessory];
    OBJ_NULL_DEFAULT(accessory, @0)
    NSNumber * imageRight = [dictionary objectForKey:key_cellstruct_imageRight];
    OBJ_NULL_DEFAULT(imageRight, @0)
    UIColor * cellcolor = DIC_OBJ_KEY(dictionary, key_cellstruct_background);
    OBJ_NULL_DEFAULT(cellcolor, [UIColor whiteColor])
    NSString * titlecolor = [dictionary objectForKey:key_cellstruct_titlecolor];
    OBJ_NULL_DEFAULT(titlecolor, @"black")
    NSNumber * sectionheight = [dictionary objectForKey:key_cellstruct_sectionheight];
    OBJ_NULL_DEFAULT(sectionheight, @25)
    //    [self setcellTitleColor:titlecolor];
};



-(void)setcellTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        self.textLabel.font = titleFont;
    }
}
//这个方法需要在子类写[super setcellobject];
-(void)setcellobject:(id)object
{   _object = object;
    
} ;

-(void)setcellobject2:(id)object
{
    _object2 = object;
}

-(void)setcelldelegate:(id)delegate{}


-(void)setcellProfile:(NSString *)profile
{
    if ([profile hasPrefix:@"http://"] || [profile hasPrefix:@"https://"]) {//如果是网络图片 就加载网络图片
//        [self.imageView hb_setImageWithURL:[NSURL URLWithString:profile] placeholderImage:[UIImage imageFileNamed:@"big_icon"] options:0 completed:nil];
        return;
    }
    if (profile.length) {
        self.imageView.image = [UIImage imageNamed:profile];
    }
}

-(void)setcellpicturecolor:(NSString *)picturecolor
{
    if (picturecolor) {
        if (self.imageView) {
            UIColor *  color = [CELL_STRUCT colorWithStructKey:picturecolor];
            self.imageView.backgroundColor = color;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
    }
}
-(void)setcellAttributeTitle:(NSAttributedString *)attributeTitle
{//被坑了  不起作用妈的
    //    if (attributeTitle) {
    //      self.textLabel.attributedText = attributeTitle;
    //    }
}
-(void)setcellTitle:(NSString *)title
{
    self.textLabel.text = title;
}
-(void)setcellTitleColor:(NSString *)color
{
    UIColor * titlecolor = [CELL_STRUCT colorWithStructKey:color] ;
    if (titlecolor) {
        self.textLabel.textColor = titlecolor;
    }
    else
    {
        self.textLabel.textColor = [UIColor blackColor];
    }
}
-(void)setcelldetailtitle:(NSString *)detailtitle
{
    if (detailtitle) {
        self.detailTextLabel.text = detailtitle;
    }
}
-(void)setcellTitleLabelNumberOfLines:(NSInteger)numberOfLines
{
    self.numberOfLines = numberOfLines;
    self.textLabel.numberOfLines = numberOfLines;
    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
}
-(CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [self.textLabel sizeThatFits:size].height;
    totalHeight += [self.detailTextLabel sizeThatFits:size].height;
    return CGSizeMake(size.width, totalHeight);
}

-(void)setcellRightValue:(NSString *)value{};
-(void)setcellValue:(NSString *)value{}
-(void)setcellValue2:(NSString *)value{}
-(void)setcellArray:(NSMutableArray *)array{}
-(void)setcellplaceholder:(NSString *)placeholder{}
-(void)setcellAction:(SEL)action{}
-(void)setinputAccessoryView:(NSString *)inputAccessoryView{}
-(void)setinputView:(NSString *)inputView{}
@end




@implementation UIView(HBBASECELL)
@dynamic toplayer;
@dynamic bottomlayer;

#define PENG_COLOR_LINE [UIColor colorWithRed:219./255. green:219./255. blue:219./255. alpha:1] 
//219 219 219
/**
 *  清除顶部分割线
 */
-(void)clearTopLayer
{
    CALayer *imageLayer = self.toplayer;
    if (imageLayer) {
        imageLayer = [self createLayer:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5) color:[UIColor clearColor]];
        [self.layer replaceSublayer:self.toplayer with:imageLayer];
        self.toplayer = nil;
    }
}

/**
 *  清除底部分割线
 */
-(void)clearBottomLayer
{
    CALayer *imageLayer = self.bottomlayer;
    if (imageLayer) {
        imageLayer =  [self createLayer:CGRectMake(0, self.frame.size.height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5) color:[UIColor clearColor]];
        [self.layer replaceSublayer:self.bottomlayer with:imageLayer];
        self.bottomlayer = nil;
    }
}

-(void)drawBottomlinelayer
{
    CALayer *imageLayer = self.bottomlayer;
    if (!imageLayer) {
        imageLayer =  [self createLayer:CGRectMake(0, self.frame.size.height - 0.5, [UIScreen mainScreen].bounds.size.width, 0.5) color:PENG_COLOR_LINE];
        [self.layer addSublayer:imageLayer];
        self.bottomlayer = imageLayer;
    }
}

-(void)drawToplinelayer
{
    CALayer *imageLayer = self.toplayer;
    if (!imageLayer) {
        imageLayer =  [self createLayer:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5) color:PENG_COLOR_LINE];
        [self.layer addSublayer:imageLayer];
        self.toplayer = imageLayer;
    }
}

-(CALayer *)createLayer:(CGRect)frame color:(UIColor *)color
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = frame; //CGRectMake(0, 0, UISCREEN_WIDTH, 0.5);
    imageLayer.cornerRadius = 0;  //设置layer圆角半径
    imageLayer.masksToBounds = YES;  //隐藏边界
    imageLayer.borderColor = color.CGColor;//[UIColor colorWithWhite:0.6 alpha:0.8].CGColor;  //边框颜色
    imageLayer.borderWidth = 0.5;
    return imageLayer;
}

static char  key_toplayer;
static char  key_bottomlayer;

-(CALayer *)toplayer
{
    CALayer * layer = (CALayer *)objc_getAssociatedObject(self, &key_toplayer);
    return layer;
}

-(void)setToplayer:(CALayer *)toplayer
{
    objc_setAssociatedObject(self, &key_toplayer, toplayer, OBJC_ASSOCIATION_RETAIN);
}
-(CALayer *)bottomlayer
{
    CALayer * layer = (CALayer *)objc_getAssociatedObject(self, &key_bottomlayer);
    return layer;
}

-(void)setBottomlayer:(CALayer *)bottomlayer
{
    objc_setAssociatedObject(self, &key_bottomlayer, bottomlayer, OBJC_ASSOCIATION_RETAIN);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end



#pragma mark - REDPoint

@implementation HBRedPoint
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        self.color = [UIColor redColor];
        // Initialization code
    }
    return self;
}
@end

@implementation HBCirclePoint : UIView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawCircleWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2)
                        radius:rect.size.width/2];
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    //    [self setNeedsDisplay];
}

//圆形
-(void)drawCircleWithCenter:(CGPoint)center
                     radius:(float)radius
{
    CGContextRef     context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGPathAddArc(pathRef,
                 &CGAffineTransformIdentity,
                 center.x,
                 center.y,
                 radius,
                 -M_PI/2,
                 radius*2*M_PI-M_PI/2,
                 NO);
    CGPathCloseSubpath(pathRef);
    
    CGContextAddPath(context, pathRef);
    UIColor * color = self.color?self.color:[UIColor redColor];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    //    CGContextDrawPath(context,kCGPathFillStroke); //画空心圆 并且去掉前面两行
    CGPathRelease(pathRef);
}

@end
