//
//  MainCategoryTabButtonView.h
//  TestTabView
//
//  Created by lee kiwan on 2018. 11. 3..
//  Copyright © 2018년 lee kiwan. All rights reserved.
//

#import "TabButtonView.h"
#import "UIView+Constraint.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomCategoryItem : TabButtonView

@property (retain, nonatomic) IBOutlet UIView *view;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
//@property (retain, nonatomic) NSLayoutConstraint *viewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidthConstraint;

@property (retain, nonatomic) UIFont *normalFont;
@property (retain, nonatomic) UIColor *normalColor;
@property (retain, nonatomic) UIFont *selectFont;
@property (retain, nonatomic) UIColor *selectColor;

- (void)setTabSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
