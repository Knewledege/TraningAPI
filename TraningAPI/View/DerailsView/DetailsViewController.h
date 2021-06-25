//
//  DetailsViewController.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsPresenterInput.h"
#import "DetailsPresenterOutput.h"
#import "DetailsPresenter.h"
#import "Common.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController <DetailsPresenterOutput>
/* タイトル関連ビュー */
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *populationLabel;
/* 感染情報関連ビュー */
@property (weak, nonatomic) IBOutlet UIView *itemTitleView;
@property (weak, nonatomic) IBOutlet UIStackView *itemTitleStackView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedLabel;
@property (nonatomic) UIStackView *detailsFrame;
@property (nonatomic) int idNumber;
@property (nonatomic) id <DetailsPresenterInput> presenter;
- (void)detailsFrameLayout;
@end

NS_ASSUME_NONNULL_END
