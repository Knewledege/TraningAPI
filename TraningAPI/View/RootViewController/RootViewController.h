//
//  RootViewController.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootPresenterOutput.h"
NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController <RootPresenterOutput>
@property (nonatomic) CGPoint menuPosition;
@property (nonatomic) CGFloat menuHiddenPosition;
@property (nonatomic) UIButton *menuToggle;
@property (nonatomic) IBOutlet UIView *menuView;
@property (nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuViewLeadingConstraint;
- (void)menuOpen: (UIButton *)sender;
- (void)animateMenuView: (CGFloat)position;
- (void)swiped: (UIGestureRecognizer *)sender;
@end

NS_ASSUME_NONNULL_END
