//
//  CELL_STRUCT_KEY.h
//  JXL
//
//       \\    \   \    \   \\\      \      \   \\\\\\\     \ \\\\\\      \\\\
//      \\    \   \    \   \  \     \ \    \   \           \      \     \    \
//     \\\\\\\   \    \   \   \\   \  \   \  \     \\\    \  \\\\      \    \
//    \\    \   \    \   \\\\\\\  \    \ \   \      \    \      \     \    \
//   \\    \    \\\     \      \ \      \     \\\\\     \ \\\\\\      \\\
//
//  Created by 星盛 on 15/4/16.
//  Copyright (c) 2015年 BooB. All rights reserved.
//


#import <UIKit/UIKit.h>
#ifndef JXL_CELL_STRUCT_KEY_h
#define JXL_CELL_STRUCT_KEY_h


static NSString * key_cellstruct_sectionfooterheight    = @"key_cellstruct_sectionfooterheight";
static NSString * key_cellstruct_cellheight             = @"key_cellstruct_cellheight";
static NSString * key_cellstruct_selector               = @"key_cellstruct_sel_selector";

static NSString * key_cellstruct_selectionStyle         = @"key_cellstruct_selectionStyle";

static NSString * key_cellstruct_key_indexpath          = @"key_cellstruct_key_indexpath";
static NSString * key_cellstruct_sectiontitle           = @"key_cellstruct_sectiontitle";
static NSString * key_cellstruct_sectionfooter          = @"key_cellstruct_sectionfooter";
static NSString * key_cellstruct_sectionheight          = @"key_cellstruct_sectionheight";
static NSString * key_cellstruct_sectionHeaderView      = @"key_cellstruct_sectionHeaderView";

static NSString * key_cellstruct_title                  = @"key_cellstruct_title";
static NSString * key_cellstruct_titleFont              = @"key_cellstruct_titleFont";
static NSString * key_cellstruct_titlecolor             = @"key_cellstruct_titlecolor";
static NSString * key_cellstruct_textAlignment          = @"key_cellstruct_textAlignment";

static NSString * key_cellstruct_placehoder             = @"key_cellstruct_placehoder";
static NSString * key_cellstruct_detailvalue            = @"key_cellstruct_detailvalue";
static NSString * key_cellstruct_newmessagecount        = @"key_cellstruct_newmessagecount";

static NSString * key_cellstruct_imageCornerRadius      = @"key_cellstruct_imageCornerRadius";
static NSString * key_cellstruct_imageRight             = @"key_cellstruct_imageRight";
static NSString * key_cellstruct_txtsecureTextEntry     = @"key_cellstruct_txtsecureTextEntry";
static NSString * key_cellstruct_txtkeyboardtype        = @"key_cellstruct_txtkeyboardtype";

static NSString * key_cellstruct_accessory              = @"key_cellstruct_accessory";
static NSString * key_cellstruct_cellclass              = @"key_cellstruct_cellclass";
static NSString * key_cellstruct_delegate               = @"key_cellstruct_delegate";
static NSString * key_cellstruct_background             = @"key_cellstruct_background";
static NSString * key_cellstruct_profile                = @"key_cellstruct_profile";
static NSString * key_cellstruct_xibvalue              = @"key_cellstruct_xibvalue";
static NSString * key_cellstruct_subvalue2              = @"key_cellstruct_subvalue2";

static NSString * key_cellstruct_active                 = @"key_cellstruct_active";
static NSString * key_cellstruct_editing                = @"key_cellstruct_editing";
static NSString * key_cellstruct_editabled              = @"key_cellstruct_editabled";
static NSString * key_cellstruct_pushcontroller         = @"key_cellstruct_pushcontroller";
static NSString * key_cellstruct_pushcontroller_xib     = @"key_cellstruct_pushcontroller_xib";
static NSString * key_cellstruct_hiddenView             = @"key_cellstruct_hiddenView";
static NSString * key_cellstruct_leftWidth             = @"key_cellstruct_leftWidth";
static NSString * key_cellstruct_rightWidth             = @"key_cellstruct_rightWidth";
static NSString * key_cellstruct_numberOfLines             = @"key_cellstruct_numberOfLines";
static NSString * key_cellstruct_lbl_title_width      = @"key_cellstruct_lbl_title_width";
static NSString * key_cellstruct_showtoplayer           = @"key_cellstruct_showtoplayer";
static NSString * key_cellstruct_showbottomlayer           = @"key_cellstruct_showbottomlayer";

static NSString * key_cellstruct_imageHeight            = @"key_cellstruct_imageHeight";

static NSString * key_cellstruct_AutoSavePictures             = @"key_cellstruct_AutoSavePictures";

static NSString * value_cellstruct_black = @"black";      // 0.0 white
static NSString * value_cellstruct_Gray = @"Gray"; //GrayColor;   // 0.333 white
static NSString * value_cellstruct_lightGray = @"lightGrayColor";  // 0.667 white
static NSString * value_cellstruct_white = @"white";//Color;      // 1.0 white
static NSString * value_cellstruct_gray = @"gray";//Color;       // 0.5 white
static NSString * value_cellstruct_clear = @"clear";

static NSString * value_cellstruct_red= @"red";//Color;        // 1.0, 0.0, 0.0 RGB
static NSString * value_cellstruct_green = @"green";//Color;      // 0.0, 1.0, 0.0 RGB
static NSString * value_cellstruct_blue=@"blue";// Color;       // 0.0, 0.0, 1.0 RGB
static NSString * value_cellstruct_cyan =@"cyan";// Color;       // 0.0, 1.0, 1.0 RGB
static NSString * value_cellstruct_yellow = @"yellow";// Color;     // 1.0, 1.0, 0.0 RGB
static NSString * value_cellstruct_magenta = @"magenta";//Color;    // 1.0, 0.0, 1.0 RGB
static NSString * value_cellstruct_orange = @"orange";//Color;     // 1.0, 0.5, 0.0 RGB
static NSString * value_cellstruct_purple = @"purple";//Color;     // 0.5, 0.0, 0.5 RGB
static NSString * value_cellstruct_brown = @"brown";//Color;      // 0.6, 0.4, 0.2 RGB


//textalignment
static NSString * value_cellstruct_textAlignment_left = @"left";
static NSString * value_cellstruct_textAlignment_right = @"right";
static NSString * value_cellstruct_textAlignment_center = @"center";

static NSString * value_cellstruct_txtkeyboardtype_number          = @"number";
static NSString * value_cellstruct_txtkeyboardtype_default         = @"default";


#define CELL_STRUCT_COLOR(COLORKEY) [UIColor  COLORKEY##Color]

#define DIC_OBJ_KEY(DIC,PARA) [DIC objectForKey:PARA]
#define OBJ_NULL_DEFAULT(OBJ,VALUE) if (!OBJ) {\
OBJ = VALUE;\
}

#endif
