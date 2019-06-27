//
//  MainCategoryView.m
//  TestTabView
//
//  Created by lee kiwan on 2018. 11. 3..
//  Copyright © 2018년 lee kiwan. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

- (instancetype)init {
    self = [self initWithFrame:[[[UIApplication sharedApplication] keyWindow] bounds]];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setNib];
        [self setUI];
        [self setEvent];
        [self setController];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setNib];
        [self setUI];
        [self setEvent];
        [self setController];
    }
    return self;
}

- (void)setNib{
    _view = [[[NSBundle mainBundle] loadNibNamed:@"CategoryView" owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [_view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:_view];
    [self setConstraint:_view];
}

- (void)setController {
    tabController = [[TabController alloc] init];
    [tabController setDelegate:self];
}

- (void)setUI {
    _tabAnimationDuration = 0.3;
    _maxShowCount = 5;
    baseGatherButtonWidth = 42;
}

- (void)setEvent {
}

- (void)setSelectIndex:(NSInteger)index {
    if (!isViewTabData && [_data count] < 1) {
        return;
    }

    
    isAnimation = YES;
    _selectIndex = index;
    [self doDelegate];

    [self layoutIfNeeded];
    
    CustomCategoryItem *tabView = (CustomCategoryItem *)[tabController getButtonView:_selectIndex];
    [tabController selectTabIndex:_selectIndex];
    if (_pagerScollView != nil) {
        [_pagerScollView setContentOffset:CGPointMake([_pagerScollView bounds].size.width * _selectIndex, _pagerScollView.contentOffset.y) animated:YES];
    }
    [self moveCenterScrollView:_selectIndex];
    
    [UIView animateWithDuration:_tabAnimationDuration
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [self.selectBarLeftConstraint setConstant:tabView.frame.origin.x];
                         [self.selectBarWidthConstraint setConstant:[tabView.viewWidthConstraint constant]];
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         self->isAnimation = NO;
                     }];
    
}

- (void)readyScrollAnimation {
    [_contentView setHidden:YES];
}

- (void)startScrollAnimation {
    [_contentView setHidden:NO];
    [_scrollView setContentOffset:CGPointMake(-_scrollView.bounds.size.width, 0)];
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^(void) {
                         [self.scrollView setContentOffset:CGPointMake(0, 0)];
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)setData:(NSMutableArray<NSString *> *)data {
    _data = data;
    isViewTabData = NO;
    [self updateUI];
}

- (NSString *)getCurrentData {
    if (!isViewTabData && [_data count] > 0) {
        return [_data objectAtIndex:_selectIndex];
    }
    return nil;
}


- (void)updateUI {
//    [_view layoutIfNeeded];
//    [_scrollView layoutIfNeeded];
    
    for (UIView *view in [tabController buttonViews]) {
        [view removeFromSuperview];
    }
    
    [self updateDataUI];
  
    [self layoutIfNeeded];
}


- (void)updateDataUI {
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    CustomCategoryItem *beforeTabView = nil;
    CGFloat contentViewWidth = 0;
    for (int i=0;i<[_data count];i++) {
        CustomCategoryItem *tabView = [[CustomCategoryItem alloc] init];
        [tabView.titleLabel setText:[_data objectAtIndex:i]];
        [tabs addObject:tabView];
        [_contentView addSubview:tabView];
        [self setFitTextWidth:tabView];
        contentViewWidth += [tabView.viewWidthConstraint constant];
        
        NSLayoutConstraint *top =  [NSLayoutConstraint constraintWithItem:tabView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:_contentView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
        
        NSLayoutConstraint *bottom =  [NSLayoutConstraint constraintWithItem:_contentView
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:tabView
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:1];
        NSLayoutConstraint *left = nil;
        if (beforeTabView == nil) {
            left = [NSLayoutConstraint constraintWithItem:tabView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:_contentView
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1
                                                 constant:0];
            [_selectBarLeftConstraint setConstant:0];
            [_selectBarWidthConstraint setConstant:[tabView.viewWidthConstraint constant]];
        } else {
            left = [NSLayoutConstraint constraintWithItem:tabView
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:beforeTabView
                                                attribute:NSLayoutAttributeRight
                                               multiplier:1
                                                 constant:0];
        }
        beforeTabView = tabView;
        [_contentView addConstraints:[NSArray arrayWithObjects:top,bottom,left, nil]];
    }
    [tabController setTabs:YES tabs:tabs];
    [_contentViewWidthConstraint setConstant:contentViewWidth];
    [self checkScrollViewWidth:_data.count];
}

- (void)checkScrollViewWidth:(NSInteger)dataCount {
    if (dataCount < 1) {
        return;
    }
    
    if (_isFitTextWidth) {
        if ([_contentViewWidthConstraint constant] > _view.bounds.size.width - baseGatherButtonWidth) {
        } else {
            [_view layoutIfNeeded];
            CGFloat buttonWidth = _scrollView.frame.size.width;
            buttonWidth = _scrollView.frame.size.width / dataCount;
            for (CustomCategoryItem *tabView in [tabController buttonViews]) {
                [tabView.viewWidthConstraint setConstant:buttonWidth];
            }
            [_contentViewWidthConstraint setConstant:_scrollView.frame.size.width];
        }
    }
}

- (void)setFitTextWidth:(CustomCategoryItem *)tabView {
    CGFloat buttonWidth = _scrollView.bounds.size.width;
    if (_isFitTextWidth) {
        CGFloat labelWidth = [self getStringWidth:tabView.titleLabel] + 24;
        [tabView.viewWidthConstraint setConstant:labelWidth];
    } else {
        CGFloat buttonCount = _scrollView.bounds.size.width;
      
        buttonCount = (_data.count >= _maxShowCount) ? _maxShowCount:_data.count;
        
        buttonWidth = _scrollView.bounds.size.width / buttonCount;
        [tabView.viewWidthConstraint setConstant:buttonWidth];
    }
}

- (CGFloat)getStringWidth:(UILabel *)label {
    CGRect rect = [label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.frame.size.height)
                                                     options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.width + 1;
}

- (void)updatePagerScrollView {
    if(isAnimation || _pagerScollView == nil) {
        return;
    }
    if ([self moveSelectBar]) {
        [self updateSelectBarWidth];
    }
    
    if (currentScrollPercent < 1) {
        NSInteger beforeIndex = _selectIndex;
        _selectIndex = currentIndex;
        [tabController selectTabIndex:_selectIndex];
        [self moveCenterScrollView:_selectIndex];
        if (beforeIndex != _selectIndex) {
            [self doDelegate];
        }
    }
    
    beforeOffsetX = currentOffsetX;
}

- (MainCategoryPagerScrollDirection) getCurrentDirection {
    if (_pagerScollView == nil) {
        return NoneDirection;
    }
    if (beforeOffsetX > currentIndex) {
        return LeftDirection;
    }
    return RightDirection;
}

- (void) moveCenterScrollView:(NSInteger)index {
    CustomCategoryItem *tabView = (CustomCategoryItem *)[tabController getButtonView:index];
    CGFloat movePositionX = tabView.frame.origin.x + ([tabView.viewWidthConstraint constant]/2) - _scrollView.bounds.size.width/2;
    CGFloat limitPosition = _contentView.bounds.size.width - _scrollView.bounds.size.width;
    movePositionX = (movePositionX < 0) ? 0:movePositionX;
    movePositionX = (movePositionX > limitPosition) ? limitPosition:movePositionX;
    [_scrollView setContentOffset:CGPointMake(movePositionX, _scrollView.contentOffset.y) animated:YES];
}

- (BOOL)moveSelectBar {
    currentOffsetX = [_pagerScollView contentOffset].x;
    CGFloat pagerScrollWidth = [_pagerScollView bounds].size.width;
    currentIndex = [_pagerScollView contentOffset].x / [_pagerScollView bounds].size.width;
    currentTabView = (CustomCategoryItem *)[tabController getButtonView:currentIndex];
    currentScrollPercent = ((int)currentOffsetX % (int)pagerScrollWidth) / pagerScrollWidth * 100;
    CGFloat tabViewPercentWidth = [currentTabView.viewWidthConstraint constant] * currentScrollPercent / 100;
    
    if (currentScrollPercent < 0 || currentTabView == nil || !(currentIndex >= 0 && currentIndex < [tabController count] - 1 )) {
        return false;
    }
    
    switch ([self getCurrentDirection]) {
        case LeftDirection: {
            CGFloat minusPosition = [currentTabView.viewWidthConstraint constant] - tabViewPercentWidth;
            [_selectBarLeftConstraint setConstant:(currentTabView.frame.origin.x + [currentTabView.viewWidthConstraint constant]) - minusPosition];
        }
            break;
        case RightDirection: {
            [_selectBarLeftConstraint setConstant:currentTabView.frame.origin.x + tabViewPercentWidth];
        }
            break;
        default:
            break;
    }
    
    return true;
}

- (void)updateSelectBarWidth {
    CustomCategoryItem *nextTabView = (CustomCategoryItem *)[tabController getButtonView:currentIndex+1];
    if (nextTabView == nil || currentTabView == nil) {
        return;
    }
    
    CGFloat percent = (([nextTabView.viewWidthConstraint constant] -[currentTabView.viewWidthConstraint constant]) * currentScrollPercent / 100);
    [_selectBarWidthConstraint setConstant:[currentTabView.viewWidthConstraint constant] + percent];
}



- (void)doDelegate {
    if ([_delegate respondsToSelector:@selector(didSelectMainCategoryTab:data:)]) {
        [_delegate didSelectMainCategoryTab:self data:[_data objectAtIndex:_selectIndex]];
    }
    
    if ([_delegate respondsToSelector:@selector(didSelectMainCategoryTab:index:)]) {
        [_delegate didSelectMainCategoryTab:self index:_selectIndex];
    }
}


#pragma mark - TabController Delegate

- (void)touchTab:(TabController *)tabController selectedButtonView:(TabButtonView *)buttonView {
    [self setSelectIndex:[buttonView tag]];
}

@end
