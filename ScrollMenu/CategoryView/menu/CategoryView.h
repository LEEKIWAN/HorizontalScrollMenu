//
//  MainCategoryView.h
//  TestTabView
//
//  Created by lee kiwan on 2018. 11. 3..
//  Copyright © 2018년 lee kiwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabController.h"
#import "CustomCategoryItem.h"
#import "UIVIew+Constraint.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MainCategoryPagerScrollDirection) {
    NoneDirection,
    LeftDirection,
    RightDirection
};


@protocol CategoryViewDelegate;

@interface CategoryView: UIView <TabControllerDelegate> {
    TabController *tabController;
    CGFloat beforeOffsetX;
    BOOL isAnimation;
    CGFloat currentOffsetX;
    NSInteger currentIndex;
    CGFloat currentScrollPercent;
    CGFloat baseGatherButtonWidth;
    CustomCategoryItem *currentTabView;
    BOOL isViewTabData;
}
@property (nonatomic, assign) id <CategoryViewDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *selectBarWidthConstraint;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *selectBarLeftConstraint;
@property (retain, nonatomic) IBOutlet UIView *selectBarView;
@property (retain, nonatomic) NSMutableArray<NSString *> *data;

@property (assign, nonatomic) BOOL isFitTextWidth;
@property (assign, nonatomic) NSInteger maxShowCount;
@property (assign, nonatomic) NSInteger selectIndex;
@property (assign, nonatomic) CGFloat tabAnimationDuration;

- (NSString *)getCurrentData;

@end

@protocol CategoryViewDelegate <NSObject>

@optional
- (void)didSelectMainCategoryTab:(CategoryView *)view data:(NSString *)data;
- (void)didSelectMainCategoryTab:(CategoryView *)view index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
