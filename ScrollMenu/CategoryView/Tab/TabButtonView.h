//
//  TabButtonView.h
//  Mulban
//
//  Created by lee kiwan on 2018. 9. 25..
//  Copyright © 2018년 Baek. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabButtonView : UIView

@property (retain, nonatomic) IBOutlet UIButton *actionButton;

- (void)setTabSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
