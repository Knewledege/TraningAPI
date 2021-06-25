//
//  MenuTableViewCell.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableViewCell : UITableViewCell
+ (NSString *)cellIdentifer;
@property (weak, nonatomic) IBOutlet UILabel *menuNameLabel;
- (void)menuLabelConfigure: (NSString *)text;
@end

NS_ASSUME_NONNULL_END
