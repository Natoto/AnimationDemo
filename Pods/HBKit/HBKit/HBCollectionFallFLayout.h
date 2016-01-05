//
//  WaterFLayout.h
//  CollectionView
//
//  Created by d2space on 14-2-24.
//  Copyright (c) 2014年 D2space. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  Constants that specify the types of supplementary views that can be presented using a waterfall layout.
 */

/// A supplementary view that identifies the header for a given section.
extern NSString *const HBWaterFallSectionHeader;
/// A supplementary view that identifies the footer for a given section.
extern NSString *const HBWaterFallSectionFooter;


#pragma mark WaterF
@protocol HBWaterFLayoutDelegate <UICollectionViewDelegate>
@required
/**
 *  Asks the delegate for the size of the specified item’s cell.
 *
 *  @param collectionView
 *    The collection view object displaying the waterfall layout.
 *  @param collectionViewLayout
 *    The layout object requesting the information.
 *  @param indexPath
 *    The index path of the item.
 *
 *  @return
 *    The original size of the specified item. Both width and height must be greater than 0.
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional
/**
 *  Asks the delegate for the height of the header view in the specified section.
 *
 *  @param collectionView
 *    The collection view object displaying the waterfall layout.
 *  @param collectionViewLayout
 *    The layout object requesting the information.
 *  @param section
 *    The index of the section whose header size is being requested.
 *
 *  @return
 *    The height of the header. If you return 0, no header is added.
 *
 *  @discussion
 *    If you do not implement this method, the waterfall layout uses the value in its headerHeight property to set the size of the header.
 *
 *  @see
 *    headerHeight
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section;

/**
 *  Asks the delegate for the height of the footer view in the specified section.
 *
 *  @param collectionView
 *    The collection view object displaying the waterfall layout.
 *  @param collectionViewLayout
 *    The layout object requesting the information.
 *  @param section
 *    The index of the section whose header size is being requested.
 *
 *  @return
 *    The height of the footer. If you return 0, no footer is added.
 *
 *  @discussion
 *    If you do not implement this method, the waterfall layout uses the value in its footerHeight property to set the size of the footer.
 *
 *  @see
 *    footerHeight
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section;

/**
 *  eache columncount of  section 如果没有设置此代理则读取变量columnCount的值
 *
 *  @param collectionView collectionview
 *  @param section        section index
 *
 *  @return count
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView  ColumnCountOfSection:(NSInteger)section;

/**
 *  返回 ReuseIdentifierWithSection 用于HEADER重用 如果没有设置则使用 HBWaterFallSectionHeader
 *
 *  @param collectionView collectionview
 *  @param section        section
 *
 *  @return string ReuseIdentifier
 */
-(NSString *)collectionView:(UICollectionView *)collectionView HeaderReuseIdentifierWithSection:(NSInteger)section;


/**
 *  返回 ReuseIdentifierWithSection 用于Footer重用 如果没有设置则使用 HBWaterFallSectionFooter
 *
 *  @param collectionView collectionview
 *  @param section        section
 *
 *  @return string  ReuseIdentifier
 */
-(NSString *)collectionView:(UICollectionView *)collectionView FooterReuseIdentifierWithSection:(NSInteger)section;
@end

@interface HBCollectionFallFLayout : UICollectionViewLayout

/**
 * The delegate will point to collection view's delegate automatically.
 */
@property (nonatomic, weak) id <HBWaterFLayoutDelegate> delegate;
/**
 *  @brief How many columns for this layout.
 *  @discussion Default: 2 最大有多少行
 */
@property (nonatomic, assign) NSInteger columnCount;

/**
 *  @brief The minimum spacing to use between successive columns.
 *  @discussion Default: 10.0
 */
@property (nonatomic, assign) CGFloat minimumColumnSpacing;

/**
 *  @brief The minimum spacing to use between items in the same column.
 *  @discussion Default: 10.0
 *  @note This spacing is not applied to the space between header and columns or between columns and footer.
 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/**
 *  @brief Height for section header
 *  @discussion
 *    If your collectionView's delegate doesn't implement `collectionView:layout:heightForHeaderInSection:`,
 *    then this value will be used.
 *
 *    Default: 0
 */
@property (nonatomic, assign) CGFloat headerHeight;

/**
 *  @brief Height for section footer
 *  @discussion
 *    If your collectionView's delegate doesn't implement `collectionView:layout:heightForFooterInSection:`,
 *    then this value will be used.
 *
 *    Default: 0
 */
@property (nonatomic, assign) CGFloat footerHeight;

/**
 *  @brief The margins that are used to lay out content in each section.
 *  @discussion
 *    Section insets are margins applied only to the items in the section.
 *    They represent the distance between the header view and the columns and between the columns and the footer view.
 *    They also indicate the spacing on either side of columns. They do not affect the size of the headers or footers themselves.
 *
 *    Default: UIEdgeInsetsZero
 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@end

