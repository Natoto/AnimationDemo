//
//  BaseCollectionViewCell.m
//  PENG
//
//  Created by 星盛 on 15/10/20.
//  Copyright © 2015年 nonato. All rights reserved.
//

#import "HBBaseCollectionViewCell.h"
#import "CELL_STRUCT_Common.h"
#import "CELL_STRUCT_KEY.h"

@implementation HBBaseCollectionViewCell
-(void)setcelldictionary:(NSMutableDictionary *)dictionary{
    self.dictionary = dictionary;
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
}

-(void)setcellimageRight:(BOOL)imageRight{}
-(void)setcellpicturecolor:(NSString *)picturecolor{}
-(void)setcellobject:(id)object{ self.object = object;};
-(void)setcellobject2:(id)object{}
-(void)setcelldelegate:(id)delegate{self.delegate = delegate;}
-(void)setcellProfile:(NSString *)profile{}
-(void)setcellTitle:(NSString *)title{}
-(void)setcellTitleColor:(NSString *)color{}
-(void)setcelldetailtitle:(NSString *)detail{}
-(void)setcellValue:(NSString *)value{}
@end
