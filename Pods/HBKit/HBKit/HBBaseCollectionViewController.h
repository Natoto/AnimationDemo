//
//  BaseCollectionViewController.h
//  PENG
//
//  Created by zeno on 15/11/18.
//  Copyright © 2015年 nonato. All rights reserved.
//
#import "HBCollectionFallFLayout.h"
#import "HBBaseViewController.h"

#warning 使用之前注册collection cell
/*
注册collection NIB CELL
 */
#define COLLECTIONVIEW_REGISTER_XIB_CELLCLASS(COLLECTIONVIEW,CELLCLSSTR)  [COLLECTIONVIEW registerNib:[UINib nibWithNibName:CELLCLSSTR bundle:nil] forCellWithReuseIdentifier:CELLCLSSTR];

/*
 注册SECTION header 或者 footer xib
 */
#define COLLECTIONVIEW_REGISTER_XIB_FORSUPPLEMENTARYVIEW(COLLECTIONVIEW,CELLSLSSTR) [COLLECTIONVIEW registerNib:[UINib nibWithNibName:CELLSLSSTR bundle:nil] forSupplementaryViewOfKind:CELLSLSSTR withReuseIdentifier:CELLSLSSTR];

/*
 注册SECTION header 或者 footer class 暂时有点问题 如需注册手动编写
 */
//#define COLLECTIONVIEW_REGISTER_CLASS_FORSUPPLEMENTARYVIEW(COLLECTIONVIEW,CELLSLSSTR) \
    [COLLECTIONVIEW registerClass:[CELLSLSSTR class] forSupplementaryViewOfKind:CELLSLSSTR withReuseIdentifier:CELLSLSSTR];


/*
 注册collection Cell class
 */
#define COLLECTIONVIEW_REGISTER_CELLCLASS(COLLECTIONVIEW,CELLCLSSTR) \
[COLLECTIONVIEW registerClass:NSClassFromString(CELLCLSSTR) forCellWithReuseIdentifier:CELLCLSSTR];



@protocol HBCollectionViewControllerConfig <NSObject>
@required
/**
 *  自己配置列数量需要对其重写
 *
 *  @return columnCount
 */
#warning  配置列数量 子类需要对其重载
/**
 *  配置最大列的值
 *
 *  @return 列数目
 */
-(NSInteger)configColumnCount;
//配置偏移量需要重载
/**
 *  配置collectionView距上左下右的距离
 *
 *  @return  UIEdgeInsets
 */
-(UIEdgeInsets)configSectionInset;

-(UIEdgeInsets)configInsetForSectionAtIndex:(NSInteger)section;

/**
 *  配置列(左右)之间的间距
 *
 */
-(CGFloat)configMinimumColumnSpacing;
/**
 *  配置行(上下)之间的间距
 *
 *  @return 间距
 */
-(CGFloat)configMinimumInteritemSpacing;
@end

@interface HBBaseCollectionViewController : HBBaseViewController<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,HBCollectionViewControllerConfig,HBWaterFLayoutDelegate>

@property (nonatomic,strong ) NSMutableDictionary       * dataDictionary;
@property (nonatomic, strong) UICollectionView          *collectionView;
@property (nonatomic, strong) HBCollectionFallFLayout   *collectionViewFlowLayout;


@property (nonatomic, assign         ) BOOL    nodeselectRow;
@property (nonatomic, assign,readonly) CGFloat itemWidth;

#if 1 //是否需要用到MJRefresh
//上下拉要用到的
@property (nonatomic, assign         ) BOOL    noFooterView;
@property (nonatomic, assign         ) BOOL    noHeaderFreshView;
//调用上下拉需要的
-(void)refreshView;
-(void)getNextPageView;
-(void)FinishedLoadData;
#endif

-(void)viewDidCurrentView;
-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom;

@end
