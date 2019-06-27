//
//  UIView+Constraint.m
//  Mulban
//
//  Created by lee kiwan on 10/01/2019.
//  Copyright © 2019 Baek. All rights reserved.
//

#import "UIView+Constraint.h"

@implementation UIView (Constraint)

- (void)setConstraint:(UIView *)view {
    if ([view superview] == nil) {
        return;
    }
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *viewWidth =  [NSLayoutConstraint constraintWithItem:view
                                                                  attribute:NSLayoutAttributeWidth
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:[view superview]
                                                                  attribute:NSLayoutAttributeWidth
                                                                 multiplier:1
                                                                   constant:0];
    
    
    NSLayoutConstraint *viewHeight =  [NSLayoutConstraint constraintWithItem:view
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:[view superview]
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:1
                                                                    constant:0];
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:[view superview]
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:[view superview]
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    
    [self addConstraints:[NSArray arrayWithObjects:viewWidth,viewHeight,centerX,centerY,nil]];
}

- (NSLayoutConstraint *)findViewConstraint:(UIView *)view identifier:(NSString *)identifier {
    NSLayoutConstraint *findConstraint = nil;
    for(NSLayoutConstraint *cons in view.constraints)   {
        if ([cons.identifier isEqualToString:identifier]) {
            findConstraint = cons;
            break;
        }
    }
    return findConstraint;
}


@end
