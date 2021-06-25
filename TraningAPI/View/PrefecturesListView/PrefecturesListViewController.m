//
//  PrefecturesListViewController.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "PrefecturesListViewController.h"

@interface PrefecturesListViewController ()

@end

@implementation PrefecturesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[PrefecturesPresenter alloc] initWithViewControllerDelegate:self];
    [self.presenter getPrefecturesModel:true];
    self.prefecturesListTableView.delegate = self;
    self.prefecturesListTableView.dataSource = self;
    [self.prefecturesListTableView registerNib:[UINib nibWithNibName:PrefecturesListTableViewCell.cellIdentifer bundle:nil] forCellReuseIdentifier:PrefecturesListTableViewCell.cellIdentifer];
    self.reloadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.clockwise"] style:UIBarButtonItemStyleDone target:self action:@selector(reloadTableView)];

    self.navigationItem.rightBarButtonItem = self.reloadButton;
    self.regionModel = [[RegionModel alloc] init];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self.delegate viewWillAppear];
}
- (void)reloadTableView {
    [self.presenter getPrefecturesModel:false];
}
- (void)alert:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"エラーが発生しました" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self.presenter getPrefecturesModel:false];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)setList {
    [self.prefecturesListTableView reloadData];
}

- (void)setLastUpdate:(NSString *)lastUpdate {
    self.lastUpdateLabel.text = lastUpdate;
    [self.reloadButton setEnabled:true];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *indexRow = self.regionModel.prefecturesID[indexPath.section][indexPath.row];
    DetailsViewController *to = [StoryBoard performDetailsView:self prefecturesID:indexRow.integerValue + 1];
    [StoryBoard push:self toViewController:to];
    [self.delegate viewWillAppear];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [[UITableViewHeaderFooterView alloc] init];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchHeader:)];
    [header addGestureRecognizer:gesture];
    header.tag = section;
    return header;
}
/// アコーディオン表示制御
- (void)touchHeader:(UITapGestureRecognizer *)sender {
    NSIndexSet *index = [[NSIndexSet alloc] initWithIndex:sender.view.tag];
    NSMutableArray *nameIsHidden = [self.regionModel.nameIsHidden mutableCopy];
    if (self.regionModel.nameIsHidden[sender.view.tag].boolValue) {
        nameIsHidden[sender.view.tag] = [NSNumber numberWithBool: false];
    } else {
        nameIsHidden[sender.view.tag] = [NSNumber numberWithBool: true];
    }
    self.regionModel.nameIsHidden = [nameIsHidden copy];
    [self.prefecturesListTableView beginUpdates];
    [self.prefecturesListTableView reloadSections:index withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.prefecturesListTableView endUpdates];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *name = self.regionModel.region[section];
    return name;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.regionModel.region.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.regionModel.nameIsHidden[section].boolValue) {
        return 0;
    } else {
        NSArray *prefectures = self.regionModel.prefecturesID[section];
        return prefectures.count;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PrefecturesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PrefecturesListTableViewCell.cellIdentifer forIndexPath:indexPath];
    NSNumber *indexRow = self.regionModel.prefecturesID[indexPath.section][indexPath.row];
    [cell nameLabelConfigure:[self.presenter getPrefectureName:indexRow.integerValue]];
    [cell infectedConfigure:[self.presenter getCasesNumber:indexRow.integerValue]];
    return cell;
}



@end
