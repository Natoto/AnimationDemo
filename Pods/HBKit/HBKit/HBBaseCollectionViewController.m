//
//  BaseCollectionViewController.m
//  PENG
//
//  Created by zeno on 15/11/18.
//  Copyright © 2015年 nonato. All rights reserved.
//

#import "HBBaseCollectionViewController.h"
#import "HBBaseCollectionViewCell.h"
#import "HBCollectionFallFLayout.h"

#if 1 //是否需要用到MJRefresh
#import <MJRefresh/MJRefresh.h>
#endif

@interface HBBaseCollectionViewController ()
{
    BOOL config;
}
/**
 *  每一行有多少项目的Item
 */
//@property (nonatomic,assign,readonly)  NSUInteger          columnCount;
//@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation HBBaseCollectionViewController

-(NSInteger)configColumnCount
{
    return 2;
}
-(UIEdgeInsets)configSectionInset
{
    return UIEdgeInsetsZero;
}

-(UIEdgeInsets)configInsetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(CGFloat)configMinimumColumnSpacing
{
    return 5.;
}

-(CGFloat)configMinimumInteritemSpacing
{
    return 5.;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {//这个是需要的
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //默认两行
    self.view.backgroundColor = [UIColor colorWithRed:239./255. green:239./255. blue:239./255. alpha:1];// UIColor(239,239,239);
    self.collectionView.backgroundColor = self.view.backgroundColor;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self userDefaultConfig];
}
/**
 * 使用默认配置 供子类调用
 */
-(void)userDefaultConfig
{
    if (config) {
        return;
    }
    config = YES;
    [self userDefaultBackground];
//    [self.navigationbar setTitle:title];
    if (self.navigationController.childViewControllers.count > 1 && self.navigationController.topViewController == self) {
        self.showBackItem = YES;
    }
//    [self.navigationbar setBackgroundColor:PENG_COLOR_NAVIGATIONBAR];
//    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
    
}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary =  [NSMutableDictionary new];
    }
    return _dataDictionary;
}

#define UISCREEN_BOUNDS [UIScreen mainScreen].bounds

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGRect collectionViewFrame = CGRectMake(0,
                                                0,
                                                self.view.bounds.size.width,
                                                self.view.bounds.size.height);
        
        HBCollectionFallFLayout *collectionViewFlowLayout = [[HBCollectionFallFLayout alloc] init];
        collectionViewFlowLayout.delegate = self;
        
        collectionViewFlowLayout.headerHeight = 50;
        collectionViewFlowLayout.minimumColumnSpacing = self.configMinimumColumnSpacing;
        collectionViewFlowLayout.minimumInteritemSpacing = self.configMinimumInteritemSpacing;
        collectionViewFlowLayout.sectionInset = self.configSectionInset;//UIEdgeInsetsMake(5, 5, 5, 5);
        collectionViewFlowLayout.columnCount = self.configColumnCount;
        self.collectionViewFlowLayout = collectionViewFlowLayout;
        _collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:collectionViewFlowLayout];
//        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.allowsMultipleSelection = YES;
//        _collectionView.allowsSelection = YES;
        _collectionView.alwaysBounceVertical = YES;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#ifndef	weakify
#if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
#else	// #if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	weakify

#ifndef	strongify
#if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __weak_##x##__;
#else	// #if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __block_##x##__;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	@normalize


-(void)viewDidCurrentView{

}

-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.collectionView.frame = CGRectMake(0, top, self.view.bounds.size.width ,self.view.bounds.size.height - top - bottom);
    return self.collectionView.frame;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    BaseCollectionViewCell * cell = (BaseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.cellSelected = !cell.cellSelected;
//    [self selectChange:cell.cellSelected indexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.nodeselectRow) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    CELL_STRUCT * cellstruct = [self.dataDictionary  objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    if ( cellstruct.sel_selector && [self respondsToSelector:cellstruct.sel_selector])
    {
        [self performSelector:cellstruct.sel_selector withObject:cellstruct afterDelay:0];
    }
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.dataDictionary.allKeys.count;
    NSArray * keys = self.dataDictionary.allKeys;
    NSString * sectionx = KEY_SECTION_MARK(section);
    
    //[NSString stringWithFormat:@"section%ld_",(long)section];
    NSInteger rowcount = 0;
    for (int index = 0; index < keys.count; index ++) {
        NSString * key =[keys objectAtIndex:index];
        if ([key rangeOfString:sectionx].location != NSNotFound) {
            rowcount ++;
        }
    }
    return rowcount;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSInteger maxsection = 1;
    for (int index = 0; index < keys.count; index ++) {
        NSString * key =[keys objectAtIndex:index];
        
        NSString * sectionstr = KEY_SECTION_INDEX_STR(key);
        if ((sectionstr.integerValue +1) > maxsection) {
            maxsection = (sectionstr.integerValue + 1);
        }
    }
    return maxsection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSString * identifier01 = cellstruct.cellclass;
    HBBaseCollectionViewCell *cell ;
    cell =  [collectionView dequeueReusableCellWithReuseIdentifier:identifier01 forIndexPath:indexPath];
    if (!cell) {
        cell = [[HBBaseCollectionViewCell alloc] init];
    }
    if ([[cell class] isSubclassOfClass:[HBBaseCollectionViewCell class]]) {
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell setcellimageRight:cellstruct.imageRight];
        [cell setcelldetailtitle:cellstruct.detailtitle];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellTitle:cellstruct.title];
        [cell setcellProfile:cellstruct.picture];
        [cell setcellpicturecolor:cellstruct.picturecolor];
        [cell setcellobject:cellstruct.object];
        [cell setcellobject2:cellstruct.object2];
        [cell setcellTitleColor:cellstruct.titlecolor];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellValue:cellstruct.value];
    }
    return cell;
}


-(CGFloat)itemWidth
{
    return  (self.view.bounds.size.width - 5 * (self.configColumnCount + 1)) / self.configColumnCount;;
}
#pragma mark - UICollectionViewDelegateFlowLayout
 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets edgeinset = [self configInsetForSectionAtIndex:indexPath.section];
     CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSInteger realcolumcount = self.configColumnCount;
    if ([self respondsToSelector:@selector(collectionView:ColumnCountOfSection:)]) {
        realcolumcount = [self collectionView:collectionView ColumnCountOfSection:indexPath.section];
    }
    CGFloat cellSideLength = (self.view.bounds.size.width - edgeinset.left * (realcolumcount + 1)) / realcolumcount;
    CGFloat itemheight = (cellstruct.cellheight>0) ? cellstruct.cellheight:cellSideLength;
    CGSize cellSize = CGSizeMake(cellSideLength, itemheight);
    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return [self configInsetForSectionAtIndex:section];//UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionheight;
}


#pragma mark - 1

#if 1 //是否需要用到MJRefresh

-(void)setNoHeaderFreshView:(BOOL)noHeaderFreshView
{
    _noHeaderFreshView = noHeaderFreshView;
    if (!_noHeaderFreshView) { @weakify(self);
        _collectionView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            @strongify(self)
            [self refreshView];
        }];
    }
}

-(void)setNoFooterView:(BOOL)noFooterView
{
    _noFooterView = noFooterView;
    if (!_noFooterView) {
        @weakify(self);
        _collectionView.footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{@strongify(self)
            [self getNextPageView];
        }];
    }
    else
    {
        _collectionView.footer = nil;
    }
}

-(void)refreshView
{
    //    [self.collectionView.header beginRefreshing];
}
-(void)getNextPageView
{
    //    [self.collectionView.footer beginRefreshing];
}
-(void)FinishedLoadData{
    [self.collectionView.header endRefreshing];
    [self.collectionView.footer endRefreshing];
}
#endif
@end
