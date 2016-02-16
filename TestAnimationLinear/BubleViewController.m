//
//  BubleViewController.m
//  TestAnimation
//
//  Created by zeno on 16/1/6.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "BubleViewController.h"

@interface BubleViewController ()

@end
@class BulbView;
@implementation BubleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    BulbView * bubleview = [[BulbView alloc] init];
    bubleview.frame = CGRectMake(50, 100, 200, 200);
    [self.view addSubview:bubleview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation BulbView


-(id)init {
    if( self = [super init] ) {
        
        // define a default frame.
        self.image = [UIImage imageNamed:@"bulb"];
        self.frame = CGRectMake( 0, 0, self.image.size.width, self.image.size.height );
        
        // general bulb initializer
        [self generalInit];
    }
    return self;
}


// BulbView must be initialized via initWithFrame:.
-(id)initWithFrame:(CGRect)frame {
    if( ( self = [super initWithFrame:frame] ) ) {
        
        // general bulb initializer
        [self generalInit];
    }
    return self;
}

// General bulb initialization.
-(void)generalInit {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    // Grab the bulb image and log whether or not we succeeded to load the image.
    self.image = [UIImage imageNamed:@"bulb"];
    NSLog(@"image==nil? %@",_image==nil?@"yes":@"no");
    
    // Get our layer to do a small custom configuration.
    CALayer* layer = [self layer];
    // By setting opaque to NO it defines our backing store to include an alpha channel.
    layer.opaque = NO;
    
    // The default bulb color is red.
    [self setColor:[UIColor redColor]];
}

-(void)setColor:(UIColor*)color {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    _color = color;
    CGColorRef cgColor = color.CGColor;
    const CGFloat* colors = CGColorGetComponents( cgColor );
    self.red = colors[0] * 255.0;
    self.green = colors[1] * 255.0;
    self.blue = colors[2] * 255.0;
    NSLog(@"%s red: %f, green: %f, blue: %f",__PRETTY_FUNCTION__,self.red,self.green,self.blue );
    
}

-(void)setOn:(BOOL)on animated:(BOOL)animated
{
    if (on) {
        [self animateFrom:0.0 to:255.0];
    }
    else
    {
        [self animateFrom:255.0 to:0.0];
    }
    self.on = on;

}

-(void)animateFrom:(CGFloat)from to:(CGFloat)to
{
    CABasicAnimation* theAnimation = [CABasicAnimation animation];
    theAnimation.duration = 1.0;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    theAnimation.fromValue = @(from);
    theAnimation.toValue = @(to);
    [self.layer addAnimation:theAnimation forKey:@"brightness"];
 
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    // Get the current state of the bulb's "brightness"
    // Core Animation is animating this value on our behalf.
    CGFloat brightness = self.on * 255; //((BulbLayer*)layer).brightness;
    NSLog(@"brightness: %f",brightness);
    
    // Calculate the bulbs current color (via RGB components) based on
    // the bulb's current "brightness".
    CGFloat redDiff = 255 - self.red;
    CGFloat greenDiff = 255 - self.green;
    CGFloat blueDiff = 255 - self.blue;
    CGFloat curRed = self.red + redDiff * ( brightness / 255.0 );
    CGFloat curGreen = self.green + greenDiff * ( brightness / 255.0 );
    CGFloat curBlue = self.blue + blueDiff * ( brightness / 255.0 );
    NSLog(@"curRed: %f, curGreen: %f, curBlue: %f",curRed,curGreen,curBlue);
    
    // Start an offscreen graphics context
    UIGraphicsBeginImageContextWithOptions( _image.size, YES, 1.0f );
    self.currentContext = UIGraphicsGetCurrentContext();
    CGRect imageRect = CGContextGetClipBoundingBox( self.currentContext );
    
    // Fill the context with our bulbs current color.
    UIColor* color = [UIColor colorWithRed:curRed/255.0 green:curGreen/255.0 blue:curBlue/255.0 alpha:1.0];
    [color set];
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGContextGetClipBoundingBox( self.currentContext )];
    [path fill];
    
    // Draw the bulb image into the context.
    CGContextDrawImage( self.currentContext, imageRect, _image.CGImage );
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"image==nil? %@",image==nil?@"yes":@"no");
    UIGraphicsEndImageContext();
    
    // Define the colors that will be masked out of the final image.
    const CGFloat maskingColors[6] = { 248.0, 255.0, 248.0, 255.0, 248.0, 255.0 };
    
    // Apply the mask and create the final image.
    CGImageRef finalImage = CGImageCreateWithMaskingColors( image.CGImage, maskingColors );
    NSLog(@"bulbMask2==NULL? %@",finalImage==NULL?@"yes":@"no");
    
    // Get our context's rect and draw the final bulb image into it.
    CGRect contextRect = CGContextGetClipBoundingBox( context );
    NSLog(@"contextRect: %@",NSStringFromCGRect( contextRect ) );
    CGContextDrawImage( context, contextRect, finalImage );
    
    // Release the final image.
    CGImageRelease( finalImage );
}

// Touch handler for the bulb. Toggles the On/Off state.
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self setOn:!self.on animated:YES];
    [self.layer needsDisplay];;
}

@end