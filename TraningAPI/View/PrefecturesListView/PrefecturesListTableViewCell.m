//
//  PrefecturesListTableViewCell.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "PrefecturesListTableViewCell.h"
@implementation PrefecturesListTableViewCell
+ (NSString *)cellIdentifer {
    return @"PrefecturesListTableViewCell";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.casesTitleLabel.text = Common.casesTitle;
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.nameLabel.text = nil;
    self.casesLabel.text = nil;
}
- (void)nameLabelConfigure:(NSString *)name {
    self.nameLabel.text = name;
}
- (void)infectedConfigure:(NSString *)number {
    self.casesLabel.text = number;
}
@end
