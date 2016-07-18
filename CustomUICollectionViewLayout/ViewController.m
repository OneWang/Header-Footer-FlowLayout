//
//  ViewController.m
//  CustomUICollectionViewLayout
//
//  Created by LI on 16/3/9.
//  Copyright © 2016年 LI. All rights reserved.
//

#define K_Screen_Width [UIScreen mainScreen].bounds.size.width

/** 控制器 */
#import "ViewController.h"

/** cell */
#import "ShopCell.h"

/** Third Lib */
#import "MJExtension.h"
#import "MJRefresh.h"

/** 模型类 */
#import "ShopModel.h"

/** 布局类 */
#import "GEWaterflowLayout.h"
#import "WaterFallLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,GEWaterflowLayoutDelegate>
/** collectionView */
@property (weak, nonatomic) UICollectionView *collectionView;
/** 数据源数组 */
@property (strong, nonatomic) NSMutableArray *shops;

@end


static NSString * const HeaderID = @"HeaderID";
static NSString * const FooterID = @"FooterID";

@implementation ViewController

- (NSMutableArray *)shops
{
    if (_shops == nil) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString * const ID = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.初始化数据
    NSArray * shopArray = [ShopModel objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopArray];
    
    //2.创建collectionview
    GEWaterflowLayout *layout = [[GEWaterflowLayout alloc] init];
    layout.delegate = self;
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        header.backgroundColor = [UIColor redColor];
        return header;
    }
    else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterID forIndexPath:indexPath];
        footer.backgroundColor = [UIColor blueColor];
        return footer;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"-------%ld-------%ld", indexPath.section, indexPath.item);
}

#pragma mark GEWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(GEWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    ShopModel *shop = self.shops[indexPath.item];
    return shop.h / shop.w * width;
}

/**  collectionView  headerView */
- (CGSize)waterflowLayout:(GEWaterflowLayout *)waterflowLayout sectionHeaderAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(K_Screen_Width, 60);
}

/**  collectionView  footerView */
- (CGSize)waterflowLayout:(GEWaterflowLayout *)waterflowLayout sectionFooterAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(K_Screen_Width, 40);
}

@end
