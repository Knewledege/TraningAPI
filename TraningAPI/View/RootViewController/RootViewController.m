//
//  RootViewController.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "RootViewController.h"
#import "RootPresenter.h"
#import "StoryBoard.h"
@interface RootViewController ()

@end

@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuToggle = [UIButton systemButtonWithImage:[UIImage systemImageNamed:@"text.justify"] target:self action:@selector(menuOpen:)];
    self.menuToggle.frame = CGRectMake(20, 44, 56, 38);
    [self.menuToggle setImage:[UIImage systemImageNamed:@"xmark"] forState:UIControlStateSelected];
    [self.menuToggle setHidden:true];

    MenuViewController *menu = [StoryBoard performMenuView:self];
    PrefecturesListViewController *firstContentViewController = [StoryBoard performPrefecturesListView:self];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:firstContentViewController];
    self.contentView = navi.view;
    menu.view.frame = self.menuView.frame;
    self.menuView = menu.view;
    [self addChildViewController:navi];
    [self addChildViewController:menu];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.menuView];
    [[RootPresenter alloc] initWithViewControllerDelegate: self menuView:menu prefecturesListView:firstContentViewController];
    self.menuHiddenPosition = -self.menuView.frame.size.width;
    [self.view addSubview:self.menuToggle];
    self.menuPosition = self.menuView.layer.position;
    CGPoint menuViewFrame = self.menuView.layer.position;
    menuViewFrame.x = self.menuHiddenPosition;
    self.menuView.layer.position = menuViewFrame;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
}
- (void)menuOpen: (UIButton *)sender {
    CGFloat xPosition = 0;
    if (sender.isSelected) {
        xPosition = self.menuHiddenPosition;
    } else {
        xPosition = self.menuPosition.x;
    }
    [self animateMenuView: xPosition];
    [sender setSelected:!sender.isSelected];
}
- (void)animateMenuView: (CGFloat)position {
    [UIView animateWithDuration:0.5 animations: ^{
        CGPoint menuViewFrame = self.menuView.layer.position;
        menuViewFrame.x = position;
        self.menuView.layer.position = menuViewFrame;
    }];
}
- (void)swiped:(UIGestureRecognizer *)sender {
    if (self.menuToggle.isSelected) {
        [self animateMenuView:self.menuHiddenPosition];
        [self.menuToggle setSelected:false];
    }
}
- (void)performChild:(int)to {
    if (to == 0) {
        UIViewController *nectVC = [StoryBoard performLicenceListView:self];
        [self.childViewControllers.firstObject.childViewControllers.firstObject.navigationController pushViewController:nectVC animated:true];
        [self animateMenuView:self.menuHiddenPosition];
        [self.menuToggle setHidden:true];
        [self.menuToggle setSelected:false];
    }
}

- (void)toggleIsHidden {
    [self.menuToggle setHidden:!self.menuToggle.isHidden];
}

@end
