//
//  PrefecturesView.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef PrefecturesView_h
#define PrefecturesView_h


#endif /* PrefecturesView_h */
#import <Foundation/Foundation.h>
@protocol PrefecturesView <NSObject>
@required
- (void)setList;
- (void)setLastUpdate: (NSString *)lastUpdate;
- (void)alert: (NSError *)error;
@end
