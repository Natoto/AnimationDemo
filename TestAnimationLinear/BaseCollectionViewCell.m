//
//  BaseCollectionViewCell.m
//  TestAnimationLinear
//
//  Created by zeno on 16/1/5.
//  Copyright © 2016年 peng. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setcellTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
