//
//  MenuViewController.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootContainerDelegate.h"
#import "Common.h"
#import "MenuTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) id <RootContainerDelegate> delegate;
@property (nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic) NSArray<NSString *> *menuList;
- (void)tableViewConfigure;

@end

NS_ASSUME_NONNULL_END
