//
//  CommonView.m
//  JXL
//
//  Created by BooB on 15-5-1.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "CELL_STRUCT_Common.h"
#import "HBBaseTableViewCell.h"
#import "CELL_STRUCT.h"
#import "UIButton+PENG.h" 
@implementation CELL_STRUCT_Common
@end

@implementation CELL_STRUCT(Common)

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                         target:(id)target
                   selectAction:(SEL)selectAction
{
    return [CELL_STRUCT cell_x_x_struct:title detailvalue:detailvalue footerheight:0 selectionStyle:YES accessory:YES picture:nil target:target selectAction:selectAction ];
}

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                         target:(id)target
                   selectAction:(SEL)selectAction
{
    return [CELL_STRUCT cell_x_x_struct:title detailvalue:detailvalue footerheight:footerheight selectionStyle:selectionStyle accessory:accessory picture:nil target:target selectAction:selectAction ];
}

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                        picture:(NSString *)picture
                         target:(id)target
                   selectAction:(SEL)selectAction
{
    return [CELL_STRUCT cell_x_x_struct:title detailvalue:detailvalue footerheight:footerheight selectionStyle:selectionStyle accessory:accessory cellheight:40 imageRight:NO imageCornerRadius:NO  picture:picture target:target selectAction:selectAction background:[UIColor whiteColor]];
}

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                        picture:(NSString *)picture
                     background:(UIColor *)backgroundcolor
                         target:(id)target
                   selectAction:(SEL)selectAction
{
    return [CELL_STRUCT cell_x_x_struct:title detailvalue:detailvalue footerheight:footerheight selectionStyle:selectionStyle accessory:accessory cellheight:40 imageRight:NO imageCornerRadius:NO  picture:picture target:target selectAction:selectAction background:backgroundcolor];
}


+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                     cellheight:(CGFloat)cellheight
                     imageRight:(BOOL)imageRight
              imageCornerRadius:(BOOL)imageCornerRadius
                        picture:(NSString *)picture
                         target:(id)target
                   selectAction:(SEL)selectAction
                     background:(UIColor *)backgroundcolor
{
    return [CELL_STRUCT cell_x_x_struct:title detailvalue:detailvalue footerheight:footerheight selectionStyle:selectionStyle accessory:accessory cellheight:cellheight imageRight:imageRight imageCornerRadius:imageCornerRadius picture:picture target:target selectAction:selectAction background:backgroundcolor titlecolor:@"black"];
}

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                     cellheight:(CGFloat)cellheight
                     imageRight:(BOOL)imageRight
              imageCornerRadius:(BOOL)imageCornerRadius
                        picture:(NSString *)picture
                         target:(id)target
                   selectAction:(SEL)selectAction
                     background:(UIColor *)backgroundcolor
                     titlecolor:(NSString *)titlecolor
{
    return [CELL_STRUCT cell_x_x_struct:title detailvalue:detailvalue footerheight:footerheight selectionStyle:selectionStyle accessory:accessory cellheight:cellheight imageRight:imageRight imageCornerRadius:imageCornerRadius picture:picture target:target selectAction:selectAction background:backgroundcolor titlecolor:titlecolor sectionheight:30];
}

+(CELL_STRUCT *)cell_x_x_struct:(NSString *)title
                    detailvalue:(NSString *)detailvalue
                   footerheight:(CGFloat)footerheight
                 selectionStyle:(BOOL)selectionStyle
                      accessory:(BOOL)accessory
                     cellheight:(CGFloat)cellheight
                     imageRight:(BOOL)imageRight
              imageCornerRadius:(BOOL)imageCornerRadius
                        picture:(NSString *)picture
                         target:(id)target
                   selectAction:(SEL)selectAction
                     background:(UIColor *)backgroundcolor
                     titlecolor:(NSString *)titlecolor
                  sectionheight:(CGFloat)sectionheight
{
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:title cellclass:NSStringFromClass([HBBaseTableViewCell class]) placeholder:@"" accessory:NO sel_selctor:selectAction delegate:target];
    cell1_0.selectionStyle = selectionStyle;
    cell1_0.cellheight = cellheight;
    cell1_0.detailtitle = detailvalue?detailvalue:@"";
    cell1_0.sectionheight = footerheight;
    cell1_0.imageCornerRadius = imageCornerRadius;
    cell1_0.sectionfooterheight = footerheight;
    cell1_0.accessory = accessory;
    cell1_0.picture = picture;
    cell1_0.imageRight = imageRight;
    cell1_0.titlecolor = titlecolor;
    cell1_0.sectionheight = sectionheight;
    cell1_0.dictionary =[NSMutableDictionary dictionaryWithDictionary: @{key_cellstruct_background:backgroundcolor}];
    return cell1_0;
}



//#define OBJECT_SETTER_FROM_DIC(OBJ,PARA,DIC) OBJ.m_##PARA=[NSString stringWithFormat:@"%@",[DIC objectForKey:[@#PARA stringByReplacingOccurrencesOfString:@"_" withString:@""]]];

+(CELL_STRUCT *)cell_x_x_structWithDictionary:(NSDictionary *)dictionary
{
    
    NSString * title = [dictionary objectForKey:key_cellstruct_title];
    id target = [dictionary objectForKey:key_cellstruct_delegate];
    SEL selectAction = NSSelectorFromString([dictionary objectForKey:key_cellstruct_selector]);
    NSNumber *selectionStyle = [dictionary objectForKey:key_cellstruct_selectionStyle];
    OBJ_NULL_DEFAULT(selectionStyle, @1)
    NSNumber * cellheight = [dictionary objectForKey:key_cellstruct_cellheight];
    OBJ_NULL_DEFAULT(cellheight, @40)
    NSString * detailvalue = [dictionary objectForKey:key_cellstruct_detailvalue];
    OBJ_NULL_DEFAULT(detailvalue, @"")
    NSNumber * imageCornerRadius = DIC_OBJ_KEY(dictionary, key_cellstruct_detailvalue);
    OBJ_NULL_DEFAULT(imageCornerRadius, @0)
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
    NSString * textAlignment = [dictionary objectForKey:key_cellstruct_textAlignment];
    
    CELL_STRUCT * cell1_0 = [[CELL_STRUCT alloc] initWithtitle:title cellclass:NSStringFromClass([HBBaseTableViewCell class]) placeholder:@"" accessory:NO sel_selctor:selectAction delegate:target];
    cell1_0.selectionStyle = selectionStyle.boolValue;
    cell1_0.cellheight = cellheight.floatValue;
    cell1_0.detailtitle = detailvalue;
    cell1_0.sectionheight = sectionheight.floatValue;
    cell1_0.imageCornerRadius = imageCornerRadius.boolValue;
    cell1_0.sectionfooterheight = footerheight.floatValue;
    cell1_0.accessory = accessory.boolValue;
    cell1_0.imageRight = imageRight.boolValue;
    cell1_0.titlecolor = titlecolor;    
    cell1_0.dictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [cell1_0.dictionary setObject:textAlignment forKey:key_cellstruct_textAlignment];
    return cell1_0;
}

/**
 *+ (UIColor *)blackColor;      // 0.0 white
 + (UIColor *)darkGrayColor;   // 0.333 white
 + (UIColor *)lightGrayColor;  // 0.667 white
 + (UIColor *)whiteColor;      // 1.0 white
 + (UIColor *)grayColor;       // 0.5 white
 + (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB
 + (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB
 + (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB
 + (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB
 + (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB
 + (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB
 + (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB
 + (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
 + (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB
 + (UIColor *)clearColor;      // 0.0 white, 0.0 alpha
 */
 
+(UIColor *)colorWithStructKey:(NSString *)key
{
    if ([key isEqualToString:value_cellstruct_blue]) {
        return  CELL_STRUCT_COLOR(blue);
    }
    else if([key isEqualToString:value_cellstruct_red])
    {
        return CELL_STRUCT_COLOR(red);
    }
    else if([key isEqualToString:value_cellstruct_clear])
    {
        return CELL_STRUCT_COLOR(clear);
    }
    else if([key isEqualToString:value_cellstruct_white])
    {
        return CELL_STRUCT_COLOR(white);
    }
    else if([key isEqualToString:value_cellstruct_gray])
    {
        return CELL_STRUCT_COLOR(gray);
    } 
    
    return nil;
}

@end


@implementation UIViewController(KEYINDEXPATH)
-(NSString *)KEY_INDEXPATH:(NSInteger )SECTION ROW:(NSInteger)ROW
{
  return KEY_INDEXPATH(SECTION,ROW); //[NSString stringWithFormat:@"section%u_%u",(int)SECTION,(int)ROW];
}

-(NSString *)KEY_SECTION:(NSInteger)SECTION
{
    return KEY_SECTION(SECTION);
}
//#define KEY_SECTION(SECTION) [NSString stringWithFormat:@"section%d",(int)SECTION]
//#define KEY_SECTION_MARK(SECTION) [NSString stringWithFormat:@"section%d_",(int)SECTION]
-(NSString *)KEY_SECTION_MARK:(NSInteger)SECTION
{
    return  [NSString stringWithFormat:@"section%d_",(int)SECTION];
}

-(NSString *)KEY_SECTION_INDEX_STR:(NSString *)INDEXPATHKEY
{
    return  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil);
}
//#define KEY_SECTION_INDEX_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil)

//SECTION
//#define KEY_INDEXPATH_SECTION_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil)
-(NSString *)KEY_INDEXPATH_SECTION_STR:(NSString *)INDEXPATHKEY
{
    return  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, 1)]:nil);
}

//ROW
//#define KEY_INDEXPATH_ROW_STR(INDEXPATHKEY)  [INDEXPATHKEY substringFromIndex:(([INDEXPATHKEY rangeOfString:@"_"]).location + ([INDEXPATHKEY rangeOfString:@"_"]).length)]
-(NSString *)KEY_INDEXPATH_ROW_STR:(NSString *)INDEXPATHKEY
{
    return  [INDEXPATHKEY substringFromIndex:(([INDEXPATHKEY rangeOfString:@"_"]).location + ([INDEXPATHKEY rangeOfString:@"_"]).length)];
}

//-(void)reduceblock:(void (^)(NSString *, NSNumber *))block
//{
//}

@end