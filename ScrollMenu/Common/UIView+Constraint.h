//
//  UIView+Constraint.h
//  Mulban
//
//  Created by lee kiwan on 10/01/2019.
//  Copyright © 2019 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Constraint)

- (void)setConstraint:(UIView *)view;
- (NSLayoutConstraint *) findViewConstraint:(UIView *)view identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
