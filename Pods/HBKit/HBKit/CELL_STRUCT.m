//
//  CELL_STRUCT.m
//  JXL
//
//  Created by BooB on 15-4-15.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "CELL_STRUCT.h" 

@implementation CELL_STRUCT
-(id)initWithtitle:(NSString *)title cellclass:(NSString *)cellclass placeholder:(NSString *)placehoder accessory:(BOOL)accessory sel_selctor:(SEL)selector delegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.uploadingIndex = 0;
        self.selectionStyle = YES;
        self.uploadobjcts = [NSMutableArray new];
        self.array = [NSMutableArray new];
        self.cellheight = 50.0;
        self.sectionheight = 0;
        self.titlecolor = @"black";
        self.title = title;
        self.cellclass = cellclass;
        self.placeHolder = placehoder;
        self.accessory = accessory;
        self.selectionStyle = YES;
        self.sel_selector = selector;
        self.delegate = delegate;
        self.sectionheight = 0;
        self.sectionfont = 13;
        self.titleLabelNumberOfLines = 1;
        self.dictionary = [NSMutableDictionary new];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
         
    }
    return self;
}

//-(NSString *)description
//{
//    return [NSString stringWithFormat:@"cell_struct: %@ %@ %@ ...",_title,_cellclass,_object];
//}
@end
