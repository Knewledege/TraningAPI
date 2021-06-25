//
//  PrefecturesListViewController.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefecturesView.h"
#import "PrefecturesPresenter.h"
#import "PrefecturesPresenterInput.h"
#import "RootContainerDelegate.h"
#import "PrefecturesEntity.h"
#import "PrefecturesListTableViewCell.h"
#import "StoryBoard.h"
NS_ASSUME_NONNULL_BEGIN

@interface PrefecturesListViewController : UIViewController <PrefecturesView, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) id <PrefecturesPresenterInput> _Nullable presenter;
@property (weak, nonatomic) id <RootContainerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *prefecturesListTableView;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateLabel;
@property (nonatomic) UIBarButtonItem * reloadButton;
@property (nonatomic) RegionModel *regionModel;
- (void)reloadTableView;
- (void)touchHeader: (UITapGestureRecognizer *)sender;
@end

NS_ASSUME_NONNULL_END
