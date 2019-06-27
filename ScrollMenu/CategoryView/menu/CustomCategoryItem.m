//
//  MainCategoryTabButtonView.m
//  TestTabView
//
//  Created by lee kiwan on 2018. 11. 3..
//  Copyright © 2018년 lee kiwan. All rights reserved.
//

#import "CustomCategoryItem.h"

@implementation CustomCategoryItem


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
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setNib];
        [self setUI];
    }
    return self;
}

- (void)setNib {
    _view = [[[NSBundle mainBundle] loadNibNamed:@"CustomCategoryItem" owner:self options:nil] objectAtIndex:0];
    [_view setFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    [self addSubview:_view];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;

    if(_viewWidthConstraint == nil) {
        self.viewWidthConstraint =  [NSLayoutConstraint constraintWithItem:self
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:1
                                                              constant:100];
        [self addConstraint:_viewWidthConstraint];
    }
}

- (void)setUI {
    [self setDefaultView];
}

- (void)setTabSelected:(BOOL)isSelected {
    [super setTabSelected:isSelected];
    if (isSelected) {
        [self setSelectedView];
    } else {
        [self setDefaultView];
    }
}

- (void)setDefaultView {
    if (_normalColor == nil) {
        [_titleLabel setTextColor:UIColor.blackColor];
    } else {
        [_titleLabel setTextColor:_normalColor];
    }
    
    if (_normalFont == nil) {
        UIFont *font = [UIFont systemFontOfSize:[_titleLabel.font pointSize]];
        [_titleLabel setFont:font];
    } else {
        [_titleLabel setFont:_normalFont];
    }
    
}

- (void)setSelectedView {
    if (_selectColor == nil) {
        [_titleLabel setTextColor:UIColor.orangeColor];
    } else {
        [_titleLabel setTextColor:_selectColor];
    }
    
    if (_selectColor == nil) {
        UIFont *font = [UIFont boldSystemFontOfSize:[_titleLabel.font pointSize]];
        [_titleLabel setFont:font];
    } else {
        [_titleLabel setFont:_selectFont];
    }
}

@end
