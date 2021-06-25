//
//  DetailsPresenterOutput.h
//  TraningAPI
//
//  Created by 高橋慧 on 2021/06/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

#ifndef DetailsPresenterOutput_h
#define DetailsPresenterOutput_h


#endif /* DetailsPresenterOutput_h */
@protocol DetailsPresenterOutput <NSObject>
@required
- (void)setTitle: (NSString *)name population:(NSString *)population;
- (void)setContent: (NSArray<NSString *> *)details;
@end
