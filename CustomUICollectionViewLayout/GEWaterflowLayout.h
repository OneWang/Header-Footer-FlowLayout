//
//  LIWaterflowLayout.h
//  04-瀑布流
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 LI. All rights reserved.
//  带有头视图,尾视图;

#import <UIKit/UIKit.h>
@class GEWaterflowLayout;

@protocol GEWaterflowLayoutDelegate <NSObject>
/**  根据  cell  的宽度计算  cell  的高度 */
- (CGFloat)waterflowLayout:(GEWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

#pragma mark -- collectionView 有头部\底部视图时要求实现
@optional
/**  collectionView  头部视图的尺寸 */
- (CGSize)waterflowLayout:(GEWaterflowLayout *)waterflowLayout sectionHeaderAtIndexPath:(NSIndexPath *)indexPath;
/**  collectionView  底部视图的尺寸 */
- (CGSize)waterflowLayout:(GEWaterflowLayout *)waterflowLayout sectionFooterAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface GEWaterflowLayout : UICollectionViewLayout
/**  每一组之间的间距 */
@property (assign, nonatomic) UIEdgeInsets sectionEdgeInset;
/**  每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/**  每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/**  item 和 collectionView 左间距 */
@property (nonatomic, assign) CGFloat leftMargin;
/**  item 和 collectionView 右间距 */
@property (nonatomic, assign) CGFloat rightMargin;
/**  显示多少列 */
@property (nonatomic, assign) int columnsCount;

/**  
 *  瀑布流 cell是否按照顺序添加  
 *  YES:按顺序添加 ---  伪瀑布流
 *  NO:从当前最短的那一列下面添加 --
 */
@property (assign, nonatomic) BOOL addItemByOrder;

@property (nonatomic, weak) id<GEWaterflowLayoutDelegate> delegate;

@end
