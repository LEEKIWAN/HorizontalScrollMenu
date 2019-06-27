//
//  TabController.m
//  Mulban
//
//  Created by lee kiwan on 2018. 9. 21..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import "TabController.h"

@implementation TabController

@synthesize isViews;



- (instancetype)initWithButtons:(NSMutableArray<UIButton *> *)buttons {
    self = [super init];
    if ( self != nil ) {
        [self setTabs:NO tabs:buttons];
        return self;
    }
    return nil;
}

- (instancetype)initWithButtonViews:(NSMutableArray<TabButtonView *> *)buttonViews {
    self = [super init];
    if ( self != nil ) {
        [self setTabs:YES tabs:buttonViews];
        return self;
    }
    return nil;
}

- (void)setTabs:(BOOL)isViews tabs:(NSMutableArray *)tabs {
    [self setIsViews:isViews];
    if (isViews) {
        [self setButtonViews:tabs];
    } else {
        [self setButtons:tabs];
    }
    [self setEvent];
}

#pragma mark - Set Function

- (void) setEvent {
    if (isViews) {
        for (int i=0;i<_buttonViews.count;i++) {
            TabButtonView *buttonView =  [_buttonViews objectAtIndex:i];
            [buttonView setTag:i];
            [buttonView.actionButton setTag:i];
            [buttonView.actionButton addTarget:self action:@selector(touchTab:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [buttonView setTabSelected:YES];
            }
        }
    } else {
        for (int i=0;i<_buttons.count;i++) {
            UIButton *button =  [_buttons objectAtIndex:i];
            [button setTag:i];
            [button addTarget:self action:@selector(touchTab:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [button setSelected:YES];
            }
        }
    }
}

#pragma mark - Base Funtion

- (void)touchTab:(UIButton *)sender{
    [self updateTab:sender];
    if (isViews) {
        TabButtonView *view = [_buttonViews objectAtIndex:sender.tag];
        if ([_delegate respondsToSelector:@selector(touchTab:selectedButtonView:)]) {
            [_delegate touchTab:self selectedButtonView:view];
        }
    } else {
        if ([_delegate respondsToSelector:@selector(touchTab:selectedButton:)]) {
            [_delegate touchTab:self selectedButton:sender];
        }
    }
}

- (void)selectTabViewButton:(TabButtonView *)sender {
    [self touchTab:sender.actionButton];
}

- (void)selectTabButton:(UIButton *)sender {
    [self touchTab:sender];
}

- (void)selectTabIndex:(NSInteger )index {
    if (isViews) {
        TabButtonView *selectButtonView = nil;
        for (TabButtonView *buttonView in _buttonViews) {
            if (buttonView.tag == index) {
                selectButtonView = buttonView;
                break;
            }
        }
        [self updateTab:selectButtonView.actionButton];
    } else {
        UIButton *selectButton = nil;
        for (UIButton *button in _buttons) {
            if (button.tag == index) {
                selectButton = button;
                break;
            }
        }
        [self updateTab:selectButton];
    }
}

- (void)updateTab:(UIButton *)sender {
    if (isViews) {
        for (TabButtonView *buttonView in _buttonViews) {
            if ([buttonView.actionButton isEqual:sender]) {
                if (!sender.isSelected) {
                    [buttonView setTabSelected:YES];
                }
            } else {
                [buttonView setTabSelected:NO];
            }
        }
    } else {
        for (UIButton *button in _buttons) {
            if ([button isEqual:sender]) {
                if (!sender.isSelected) {
                    [button setSelected:YES];
                }
            } else {
                [button setSelected:NO];
            }
        }
    }
}
- (UIButton *)getButton:(NSInteger)index {
    if (isViews || (_buttons == nil) || (_buttons.count < 1)) {
        return nil;
    }
    
    if ( index >= 0 && index < _buttons.count ) {
        return [_buttons objectAtIndex:index];
    }
    
    return nil;
}

- (TabButtonView *)getButtonView:(NSInteger)index {
    if (!isViews || (_buttonViews == nil) || (_buttonViews.count < 1)) {
        return nil;
    }
    
    if ( index >= 0 && index < _buttonViews.count ) {
        return [_buttonViews objectAtIndex:index];
    }
    
    return nil;
}

- (NSInteger)count {
    if (isViews && _buttonViews != nil) {
        return _buttonViews.count;
    } else if (!isViews && _buttons != nil){
        return _buttons.count;
    }
    return 0;
}

@end
