//
//  LicenceTableViewCell.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "LicenceTableViewCell.h"

@implementation LicenceTableViewCell

+ (NSString *)cellIdentifer {
    return @"LicenceTableViewCell";
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.licenceNameLabel.text = nil;
}
- (void)licenceNameConfigure:(NSString *)text {
    self.licenceNameLabel.text = text;
}
@end
