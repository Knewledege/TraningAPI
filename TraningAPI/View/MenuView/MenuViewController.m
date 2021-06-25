//
//  MenuViewController.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuList = Common.menuList;
    self.view.layer.backgroundColor = UIColor.whiteColor.CGColor;
    [self tableViewConfigure];
    [self.view addSubview:self.menuTableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self.navigationController.navigationBar setHidden:true];
}

- (void)tableViewConfigure {
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    [self.menuTableView registerNib:[UINib nibWithNibName:MenuTableViewCell.cellIdentifer bundle:nil] forCellReuseIdentifier:MenuTableViewCell.cellIdentifer];
    self.menuTableView.backgroundColor = UIColor.whiteColor;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate setMenuID:indexPath.row];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuList.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MenuTableViewCell.cellIdentifer forIndexPath:indexPath];
    [cell menuLabelConfigure: self.menuList[indexPath.row]];
    return cell;
}


@end
