//
//  ScrollLabelViewController.m
//  TestAnimationLinear
//
//  Created by zeno on 16/1/5.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "ScrollLabelViewController.h"
#import "Circle.h"
#import "PathCircle.h"

@interface ScrollLabelViewController ()
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@end

@implementation ScrollLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Circle * circle = [[Circle alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:circle];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    PathCircle * pathcircle = [[PathCircle alloc] initWithFrame:CGRectMake(100, 250, 200, 200)];
    [self.view addSubview:pathcircle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)animationTap:(id)sender {
    
    UIView * button = self.backgroundView;
    CGFloat OFFSETWIDTH = 40;
    if (button.bounds.size.width > 300) {
        OFFSETWIDTH = -40;
    }
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:10 options:0 animations:^{
        button.bounds = CGRectMake(button.bounds.origin.x - OFFSETWIDTH, button.bounds.origin.y, button.bounds.size.width + 2*OFFSETWIDTH, button.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    //    [self.lbl_content sizeToFit];
    //    CGFloat contentoffsetx = 0;
    //    if (contentoffsetx == self.lbl_content.frame.origin.x) {
    //        contentoffsetx = self.backgroundView.bounds.size.width -  self.lbl_content.bounds.size.width;
    //    }
    //
    //    [UIView beginAnimations:@"testAnimation"context:NULL];
    //    [UIView setAnimationDuration:8.8f];
    //    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    //    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationRepeatAutoreverses:YES];
    //    [UIView setAnimationRepeatCount:1];
    //    CGRect frame = self.lbl_content.frame;
    //    frame.origin.x = (contentoffsetx>0?0:contentoffsetx);
    //    NSLog(@"%f",frame.origin.x);
    //    self.lbl_content.frame = frame;
    //    [UIView commitAnimations];
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
