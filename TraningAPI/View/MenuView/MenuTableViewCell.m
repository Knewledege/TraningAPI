//
//  MenuTableViewCell.m
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

+ (NSString *)cellIdentifer {
    return @"MenuTableViewCell";
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)prepareForReuse {
    [super prepareForReuse];
    self.menuNameLabel.text = nil;
}

- (void)menuLabelConfigure:(NSString *)text {
    self.menuNameLabel.text = text;
}
@end
