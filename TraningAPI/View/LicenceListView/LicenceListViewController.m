//
//  LicenceListViewController.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "LicenceListViewController.h"

@interface LicenceListViewController ()

@end

@implementation LicenceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.licenceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
    self.licenceList = Common.libraryTitle;
    
    self.view.backgroundColor = UIColor.systemGray6Color;
    self.navigationItem.title = Common.licenceTitle;
    
    [self tableViewConfigure];
    [self.view addSubview:self.licenceTableView];
    [self tableViewLayout];
}
- (void)tableViewConfigure {
    self.licenceTableView.delegate = self;
    self.licenceTableView.dataSource = self;
    [self.licenceTableView registerNib:[UINib nibWithNibName: LicenceTableViewCell.cellIdentifer bundle:nil] forCellReuseIdentifier: LicenceTableViewCell.cellIdentifer];
    self.licenceTableView.backgroundColor = UIColor.whiteColor;
}
- (void)tableViewLayout {
    self.licenceTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.licenceTableView.topAnchor constraintEqualToAnchor: self.view.topAnchor].active = true;
    [self.licenceTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = true;
    [self.licenceTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LicenceContentViewController *nextVC = [StoryBoard performLicenceContentView:self licencesID:indexPath.row];
    [StoryBoard push:self toViewController:nextVC];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.licenceList.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LicenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LicenceTableViewCell.cellIdentifer forIndexPath:indexPath];
    [cell licenceNameConfigure: self.licenceList[indexPath.row]];
    return cell;
}



@end
