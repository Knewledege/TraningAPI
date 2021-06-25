//
//  PrefecturesListTableViewCell.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrefecturesListTableViewCell : UITableViewCell
+ (NSString *)cellIdentifer;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *casesTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *casesLabel;
- (void)nameLabelConfigure: (NSString *)name;
- (void)infectedConfigure: (NSString *)number;
@end

NS_ASSUME_NONNULL_END
