//
//  RootPresenter.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootPresenter.h"
@implementation RootPresenter
- (instancetype)initWithViewControllerDelegate:(id<RootPresenterOutput>)delegate menuView:(MenuViewController *)menu prefecturesListView:(PrefecturesListViewController *)content{
    self = [self init];
    if (self) {
        self.delegate = delegate;
        menu.delegate = self;
        content.delegate = self;
    }
    return self;
}
/// 選択したメニューのViewController表示
- (void)setMenuID:(int)listIndex {
    [self.delegate performChild:listIndex];
}

/// RootViewControllerの子ビューよりRootViewControllerのメニュースライドボタンの表示・非表示制御
- (void)viewWillAppear {
    [self.delegate toggleIsHidden];
}
@end
