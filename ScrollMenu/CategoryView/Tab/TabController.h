//
//  TabController.h
//  Mulban
//
//  Created by lee kiwan on 2018. 9. 21..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabButtonView.h"

@protocol TabControllerDelegate;

@interface TabController : NSObject

@property (nonatomic, assign) id <TabControllerDelegate> delegate;
@property (retain, nonatomic) NSMutableArray<TabButtonView *> *buttonViews;
@property (retain, nonatomic) NSMutableArray<UIButton *> *buttons;
@property (assign, nonatomic) BOOL isViews;

- (instancetype)initWithButtons:(NSMutableArray<UIButton *> *)buttons;
- (instancetype)initWithButtonViews:(NSMutableArray<TabButtonView *> *)buttons;

- (void)setTabs:(BOOL)isViews tabs:(NSMutableArray *)tabs;

- (void)selectTabViewButton:(TabButtonView *)sender;
- (void)selectTabButton:(UIButton *)sender;
- (void)selectTabIndex:(NSInteger )index;

- (UIButton *)getButton:(NSInteger)index;
- (TabButtonView *)getButtonView:(NSInteger)index;
- (NSInteger)count;

@end

@protocol TabControllerDelegate <NSObject>
@optional
- (void) touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView;
- (void) touchTab:(TabController *)tabController selectedButton:(UIButton *)button;
@end

