//
//  DetailsViewController.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.clipsToBounds = true;
    self.headerView.layer.cornerRadius = 10;
    self.itemTitleView.clipsToBounds = true;
    self.itemTitleView.layer.cornerRadius = 10;
    self.itemTitleStackView.translatesAutoresizingMaskIntoConstraints = false;
    self.itemLabel.text = Common.titleLabelText;
    self.numberLabel.text = Common.numberLabelText;
    self.updatedLabel.text = Common.updatedLabelText;
    self.detailsFrame = [[UIStackView alloc] init];
    self.detailsFrame.axis = UILayoutConstraintAxisVertical;
    self.detailsFrame.alignment = UIStackViewAlignmentFill;
    self.detailsFrame.distribution = UIStackViewDistributionEqualSpacing;
    self.detailsFrame.spacing = 10;
    self.presenter = [[DetailsPresenter alloc] initWithViewControllerDelegate: self];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.detailsFrame];
    [self detailsFrameLayout];
    [self.presenter getPrefecturesInfo: self.idNumber];
}
- (void)detailsFrameLayout {
    self.detailsFrame.translatesAutoresizingMaskIntoConstraints = false;
    [self.detailsFrame.topAnchor constraintEqualToAnchor:self.itemTitleView.bottomAnchor constant:20].active = true;
    [self.detailsFrame.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = true;
    [self.detailsFrame.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
}

/// タイトルビュー設定
- (void)setTitle:(NSString *)name population:(NSString *)population {
    self.titleLabel.text = name;
    self.populationLabel.text = [NSString stringWithFormat:@"%@%@",POPULATION, population];
}

- (void)setContent:(NSArray<NSString *> *)details {
    for (NSArray *values in details) {
        //都道府県の各感染情報表示ビュー設定
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.detailsFrame addArrangedSubview:contentView];
        contentView.translatesAutoresizingMaskIntoConstraints = false;
        [contentView.heightAnchor constraintEqualToConstant:45].active = true;
        contentView.layer.cornerRadius = 10;
        /* 項目、人数、最終更新日のラベル設定 スタックビューで横並び*/
        UIStackView *contentStack = [[UIStackView alloc] init];
        contentStack.axis = UILayoutConstraintAxisHorizontal;
        contentStack.alignment = UIStackViewAlignmentCenter;
        contentStack.distribution = UIStackViewDistributionFillEqually;
        [contentView addSubview:contentStack];
        contentStack.translatesAutoresizingMaskIntoConstraints = false;
        [contentStack.widthAnchor constraintEqualToAnchor: contentView.widthAnchor].active = true;
        [contentStack.heightAnchor constraintEqualToAnchor:contentView.heightAnchor].active = true;
        for (NSString *value in values) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            [contentStack addArrangedSubview:label];
            label.text = value;
            label.adjustsFontSizeToFitWidth = true;
        }
    }
}

@end
