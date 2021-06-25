//
//  RootPresenter.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef RootPresenter_h
#define RootPresenter_h


#endif /* RootPresenter_h */
#import <Foundation/Foundation.h>
#import "RootPresenterOutput.h"
#import "RootContainerDelegate.h"
#import "MenuViewController.h"
#import "PrefecturesListViewController.h"
#import "StoryBoard.h"
@interface RootPresenter : NSObject <RootContainerDelegate>
@property (weak, nonatomic) id <RootPresenterOutput> delegate;
- (instancetype)initWithViewControllerDelegate:(id<RootPresenterOutput>)delegate menuView:(MenuViewController *)menu prefecturesListView:(PrefecturesListViewController *)content;
@end
