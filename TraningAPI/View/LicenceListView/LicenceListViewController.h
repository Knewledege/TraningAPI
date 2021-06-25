//
//  LicenceListViewController.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LicenceTableViewCell.h"
#import "Common.h"
#import "LicenceContentViewController.h"
#import "StoryBoard.h"
NS_ASSUME_NONNULL_BEGIN

@interface LicenceListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *licenceTableView;
@property (nonatomic) NSArray<NSString *> *licenceList;
- (void)tableViewConfigure;
- (void)tableViewLayout;
@end

NS_ASSUME_NONNULL_END
