//
//  LicenceTableViewCell.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/23.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LicenceTableViewCell : UITableViewCell
+ (NSString *)cellIdentifer;
@property (nonatomic) IBOutlet UILabel *licenceNameLabel;
- (void)licenceNameConfigure: (NSString *)text;
@end

NS_ASSUME_NONNULL_END
